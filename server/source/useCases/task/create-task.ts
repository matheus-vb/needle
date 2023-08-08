import { Task, TaskPriority, TaskStatus, TaskType, User } from "@prisma/client";
import { ITaskRepository } from "../../repositories/ITaskRepository";
import { IUserRepository } from "../../repositories/IUserRepository";
import { IWorkspaceInterface } from "../../repositories/IWorkspaceRepository";
import { IUserWorkspaceRepository } from "../../repositories/IUserWorkspaceRepository";
import { IDocumentRepository } from "../../repositories/IDocumentRepository";
import { z } from "zod";

interface ICreateTaskUseCaseRequest {
    userId: string | null,
    accessCode: string,
    title: string,
    description: string,
    status: string,
    type: string,
    endDate: Date,
    priority: string
}

interface ICreateTaskUseCaseReply {
    task: Task
}

export class CreateTaskUseCase {
    constructor(
        private taskRepository: ITaskRepository, 
        private userRepository: IUserRepository, 
        private workspaceRepository: IWorkspaceInterface,
        private userWorkspaceRepository: IUserWorkspaceRepository,
        private documentRepository: IDocumentRepository
    ) {}

    async handle({
        accessCode,
        description,
        endDate,
        status,
        title,
        type,
        userId,
        priority
    }: ICreateTaskUseCaseRequest): Promise<ICreateTaskUseCaseReply> {
        
        let userExists: boolean = false
        let author = "";

        if(userId) {
            const user = await this.userRepository.findById(userId);
            if(!user) {
                throw new Error();
            }
            userExists = true
            author = user.name;
        }

        const workspace = await this.workspaceRepository.findByCode(accessCode);
        if (!workspace) {
            throw new Error();
        }

        const document = await this.documentRepository.create({
            text: `${title} documentation`,
            title,
            author: userExists ? author : null,
            type,
        })

        const typeEnum = z.nativeEnum(TaskType);
        const checkedType = typeEnum.parse(type);

        const priorityEnum = z.nativeEnum(TaskPriority);
        const checkedPriority = priorityEnum.parse(priority)

        const statusEnum = z.nativeEnum(TaskStatus)
        const checkedStatus = statusEnum.parse(status)

        const task = await this.taskRepository.create({
            description,
            documentId: document.id,
            endDate,
            title,
            type: checkedType,
            userId,
            workId: workspace.id,
            taskPriority: checkedPriority,
            status: checkedStatus,
        })

        return {
            task,
        }
    }
}
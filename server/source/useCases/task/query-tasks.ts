import { Task, TaskPriority, TaskStatus, TaskType } from "@prisma/client";
import { ITaskRepository } from "../../repositories/ITaskRepository";
import { IWorkspaceInterface } from "../../repositories/IWorkspaceRepository";
import { BadRequest } from "../errors/BadRequest";

interface IQueryTasksUseCaseRequest {
    workspaceId: string
    query: string | null
    status: TaskStatus | null
    area: TaskType | null
    priority: TaskPriority | null
}

interface IQueryTasksUseCaseReply {
    tasks: Task[]
}

export class QueryTasksUseCase {
    constructor(private tasksRepository: ITaskRepository, private workspaceRepository: IWorkspaceInterface) {}

    async handle({
        area,
        priority,
        query,
        status,
        workspaceId,
    }: IQueryTasksUseCaseRequest): Promise<IQueryTasksUseCaseReply> {
        const workspace = await this.workspaceRepository.findById(workspaceId);
        if (!workspace) {
            throw new BadRequest()
        }

        const tasks = await this.tasksRepository.queryTasks(
            workspaceId,
            query,
            status,
            area,
            priority,
        )

        return { 
            tasks
        }
    }
}
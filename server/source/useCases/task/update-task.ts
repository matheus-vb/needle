import { Task, TaskPriority, TaskStatus, TaskType } from "@prisma/client"
import { z } from "zod"
import { IDocumentRepository } from "../../repositories/IDocumentRepository"
import { ITaskRepository } from "../../repositories/ITaskRepository"
import { IUserRepository } from "../../repositories/IUserRepository"
import { TaskRepository } from "../../repositories/Prisma/TaskRepository"
import { UserRepository } from "../../repositories/Prisma/UserRepository"

interface IUpdateTaskRequest {
    userId: string | null
    taskId: string
    documentId: string
    title: string
    description: string
    status: string
    type: string
    endDate: Date
    priority: string
    text: string
    textString: string
}

interface IUpdateTaskResponse {
    task: Task
}

export class UpdateTaskUseCase {
    constructor(private taskRespository: ITaskRepository,private docuementRepository: IDocumentRepository){}

    async handle({
        userId,
        taskId,
        documentId,
        title,
        description,
        status,
        type,
        endDate,
        priority,
        text,
        textString
    }: IUpdateTaskRequest) : Promise <IUpdateTaskResponse> {
        const previousTask = await this.taskRespository.findById(taskId);

        if(!previousTask) {
            throw new Error()
        }

        //Update no assign
        if(userId){
            await this.taskRespository.updateAssignee(taskId, userId)
        }

        //Edit tasks
        const parseStatus = z.nativeEnum(TaskStatus)
        const parsePriority = z.nativeEnum(TaskPriority)
        const parseType = z.nativeEnum(TaskType)
        
        const checkedStatus = parseStatus.parse(status)
        const checkedType = parseType.parse(type)
        const checkedPriority = parsePriority.parse(priority)

        await this.taskRespository.updateTask(taskId, title, description, checkedStatus, checkedType, endDate, checkedPriority)

        //Update na documentacao
        await this.docuementRepository.updateDocument(documentId, text, textString)

        //Pegar a task para retornar
        const task = await this.taskRespository.findById(taskId)

        if(!task){
            throw new Error('Task not found after update')
        }

        return {
            task
        }
    }
}


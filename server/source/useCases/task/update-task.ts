import { Task, TaskPriority, TaskStatus, TaskType } from "@prisma/client"
import { z } from "zod"
import { IDocumentRepository } from "../../repositories/IDocumentRepository"
import { ITaskRepository } from "../../repositories/ITaskRepository"
import { IUserRepository } from "../../repositories/IUserRepository"
import { sendNotification } from "../../notification/send-notification"
import { INotificationRepository } from "../../repositories/INotificationRepository"
import { UserNotFound } from "../errors/UserNotFound"
import { BadRequest } from "../errors/BadRequest"

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
    constructor(
        private taskRespository: ITaskRepository,
        private docuementRepository: IDocumentRepository, 
        private userRepository: IUserRepository,
        private notificationRepository: INotificationRepository,
    ){}

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
            throw new BadRequest()
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

        const task = await this.taskRespository.updateTask(taskId, title, description, checkedStatus, checkedType, endDate, checkedPriority)

        //Update na documentacao
        await this.docuementRepository.updateDocument(documentId, text, textString)        

        if(task?.userId !== previousTask.userId && task?.userId) {
            const user = await this.userRepository.findById(task.userId)
            if(!user) {
                throw new UserNotFound()
            }

            if(!user.deviceToken) {
                return { task }
            }
            
            const alert = `Você foi marcado na task ${task.title}!`
            sendNotification(user.deviceToken, alert, {
                notificationRepository: this.notificationRepository,
                userId: user.id,
                workspaceId: task.workId
            })

        } else if (task?.userId) {
            const user = await this.userRepository.findById(task.userId)
            if(!user) {
                throw new UserNotFound()
            }

            if(!user.deviceToken) {
                return { task }
            }
            
            const alert = `Sua task ${task.title} foi editada!`
            sendNotification(user.deviceToken, alert, {
                notificationRepository: this.notificationRepository,
                userId: user.id,
                workspaceId: task.workId
            })
        }

        return {
            task
        }
    }
}


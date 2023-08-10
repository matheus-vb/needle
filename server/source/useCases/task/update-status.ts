import { Task, TaskStatus } from "@prisma/client"
import { ITaskRepository } from "../../repositories/ITaskRepository"
import { z } from "zod"
import { IUserRepository } from "../../repositories/IUserRepository"
import { sendNotification } from "../../notification/send-notification"
import { INotificationRepository } from "../../repositories/INotificationRepository"
import { IWorkspaceInterface } from "../../repositories/IWorkspaceRepository"

interface IUpdateTaskStatusUseCaseRequest {
    taskId: string
    status: string
}

interface IUpdateTaskStatusUseCaseReply {
    task: Task
}

export class UpdateTaskStatusUseCase {
    constructor(
        private taskRepository: ITaskRepository, 
        private userRepository: IUserRepository, 
        private notificationRepository: INotificationRepository,
    ) {}

    async handle({
        status,
        taskId,
    }: IUpdateTaskStatusUseCaseRequest): Promise<IUpdateTaskStatusUseCaseReply> {
        const originalTask = await this.taskRepository.findById(taskId);
        if(!originalTask) {
            throw new Error();
        }

        const statusEnum = z.nativeEnum(TaskStatus);
        const checkedStatus = statusEnum.parse(status);

        const task = await this.taskRepository.updateStatus(originalTask.id, checkedStatus);

        if(!task.userId) {
            return { task }
        }

        const user = await this.userRepository.findById(task.userId)
        if(!user || !user.deviceToken) {
            throw new Error()
        }

        if(originalTask.status === TaskStatus.PENDING && status === TaskStatus.DONE) {
            const alert = `Sua submissão da task ${task.title} foi aprovada!`
            sendNotification(user.deviceToken, alert, {
                notificationRepository: this.notificationRepository,
                userId: user.id,
                workspaceId: task.workId
            })
        }

        if(originalTask.status === TaskStatus.PENDING && status !== TaskStatus.DONE) {
            const alert = `Sua submissão da task ${task.title} precisa de revisão!`
            sendNotification(user.deviceToken, alert, {
                notificationRepository: this.notificationRepository,
                userId: user.id,
                workspaceId: task.workId
            })
        }

        return {
            task,
        }
    }
}
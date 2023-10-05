import { Role, Task, TaskStatus } from "@prisma/client"
import { ITaskRepository } from "../../repositories/ITaskRepository"
import { z } from "zod"
import { IUserRepository } from "../../repositories/IUserRepository"
import { sendNotification } from "../../notification/send-notification"
import { INotificationRepository } from "../../repositories/INotificationRepository"
import { UserNotFound } from "../errors/UserNotFound"
import { BadRequest } from "../errors/BadRequest"
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
        private workspaceRepository: IWorkspaceInterface,
    ) {}

    async handle({
        status,
        taskId,
    }: IUpdateTaskStatusUseCaseRequest): Promise<IUpdateTaskStatusUseCaseReply> {
        const originalTask = await this.taskRepository.findById(taskId);
        if(!originalTask) {
            throw new BadRequest();
        }

        const statusEnum = z.nativeEnum(TaskStatus);
        const checkedStatus = statusEnum.parse(status);

        const task = await this.taskRepository.updateStatus(originalTask.id, checkedStatus);

        if(!task.userId) {
            return { task }
        }

        const user = await this.userRepository.findById(task.userId)
        if(!user) {
            throw new UserNotFound()
        }

        if(!user.deviceToken) {
            return { task }
        }

        if(status === TaskStatus.PENDING) {
            const workspace = await this.workspaceRepository.findById(task.workId)
            if (!workspace) {
                throw new BadRequest()
            }

            const pmArr = await this.userRepository.findAllUsersInWorkspace(workspace.id, Role.PRODUCT_MANAGER)

            if (!pmArr[0].deviceToken) {
                return { task }
            }

            const alert = `A aprovação da task ${task.title} está pendente!`
            sendNotification(pmArr[0].deviceToken, alert, {
                notificationRepository: this.notificationRepository,
                userId: pmArr[0].id,
                workspaceId: task.workId
            })
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
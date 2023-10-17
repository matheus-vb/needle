import { Notification } from "@prisma/client";
import { IWorkspaceInterface } from "../../repositories/IWorkspaceRepository";
import { INotificationRepository } from "../../repositories/INotificationRepository";
import { BadRequest } from "../errors/BadRequest";

interface IGetWorkspaceNotificationsRequest {
    workspaceId: string
}

interface IGetWorkspaceNotificationsReply {
    notifications: Notification[]
}

export class GetWorkspaceNotifications {
    constructor (private notificationRepository: INotificationRepository, private workspaceRepository: IWorkspaceInterface) {}

    async handle({
        workspaceId,
    }: IGetWorkspaceNotificationsRequest): Promise<IGetWorkspaceNotificationsReply> {

        const workspace = await this.workspaceRepository.findById(workspaceId);
        if(!workspace) {
            throw new BadRequest()
        }

        const notifications = await this.notificationRepository.findByWorkspaceId(workspaceId);

        return {
            notifications,
        }
    }
}
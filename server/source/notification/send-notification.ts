import { INotificationRepository } from "../repositories/INotificationRepository";
import { pushAPNS } from "./push-apns";

interface INotificationDTO {
    userId: string
    workspaceId: string
    notificationRepository: INotificationRepository
}

export function sendNotification(deviceToken: string, alert: string, payload: INotificationDTO) {
    pushAPNS(deviceToken, alert);

    const repository = payload.notificationRepository

    repository.create({
        payload: alert,
        userId: payload.userId,
        workspaceId: payload.workspaceId,
    })
}
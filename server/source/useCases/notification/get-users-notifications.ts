import { Notification } from "@prisma/client";
import { INotificationRepository } from "../../repositories/INotificationRepository";
import { IUserRepository } from "../../repositories/IUserRepository";
import { UserNotFound } from "../errors/UserNotFound";

interface IGetUsersNotificationsRequest {
    userId: string
}

interface IGetUsersNotificationsReply {
    notifications: Notification[]
}

export class GetUsersNotifications {
    constructor (private notificationRepository: INotificationRepository, private userRepository: IUserRepository) {}

    async handle({
        userId,
    }: IGetUsersNotificationsRequest): Promise<IGetUsersNotificationsReply> {
        const user = await this.userRepository.findById(userId);
        if(!user) {
            throw new UserNotFound()
        }

        const notifications = await this.notificationRepository.getUserNotifications(userId);

        return {
            notifications,
        }
    }
}
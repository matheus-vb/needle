import { INotificationRepository } from "../../repositories/INotificationRepository"
import { IUserRepository } from "../../repositories/IUserRepository"
import { UserNotFound } from "../errors/UserNotFound"

interface IDeleteUserNotificationsUseCaseRequest {
    userId: string
}

interface IDeleteUserNotificationsUseCaseReply {
    done: boolean
}

export class DeleteUserNotificationsUseCase {
    constructor(private notificationRepository: INotificationRepository, private userRepository: IUserRepository) {}

    async handle({
        userId,
    }: IDeleteUserNotificationsUseCaseRequest): Promise<IDeleteUserNotificationsUseCaseReply> {
        const user = await this.userRepository.findById(userId)
        if (!user) {
            throw new UserNotFound()
        }
        
        await this.notificationRepository.deleteUserNotifications(userId);

        return {
            done: true
        }
    }
}
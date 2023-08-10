import { NotificationRepository } from "../../../repositories/Prisma/NotificationRepository";
import { UserRepository } from "../../../repositories/Prisma/UserRepository";
import { DeleteUserNotificationsUseCase } from "../../notification/delete-user-notifications";


export function makeDeleteUserNotifications() {
    const notificationRepository = new NotificationRepository()
    const userRepository = new UserRepository()

    const useCase = new DeleteUserNotificationsUseCase(notificationRepository, userRepository)

    return useCase
}
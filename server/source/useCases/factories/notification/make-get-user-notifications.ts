import { NotificationRepository } from "../../../repositories/Prisma/NotificationRepository";
import { UserRepository } from "../../../repositories/Prisma/UserRepository";
import { GetUsersNotifications } from "../../notification/get-users-notifications";

export function makeGetUserNotifications() {
    const notificationRepository = new NotificationRepository()
    const userRepository = new UserRepository()

    const useCase = new GetUsersNotifications(notificationRepository, userRepository)

    return useCase
}
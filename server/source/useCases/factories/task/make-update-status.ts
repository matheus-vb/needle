import { NotificationRepository } from "../../../repositories/Prisma/NotificationRepository";
import { TaskRepository } from "../../../repositories/Prisma/TaskRepository";
import { UserRepository } from "../../../repositories/Prisma/UserRepository";
import { UpdateTaskStatusUseCase } from "../../task/update-status";

export function makeUpdateStatusUseCase() {
    const taskRepository = new TaskRepository();
    const userRepository = new UserRepository();
    const notificationRepository = new NotificationRepository();
    const useCase = new UpdateTaskStatusUseCase(taskRepository, userRepository, notificationRepository);
    return useCase
}
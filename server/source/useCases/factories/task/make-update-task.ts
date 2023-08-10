import { DocumentRepository } from "../../../repositories/Prisma/DocumentRepository";
import { NotificationRepository } from "../../../repositories/Prisma/NotificationRepository";
import { TaskRepository } from "../../../repositories/Prisma/TaskRepository";
import { UserRepository } from "../../../repositories/Prisma/UserRepository";
import { UpdateTaskUseCase } from "../../task/update-task";

export function makeUpdateTask(){
    const taskRepository = new TaskRepository()
    const documentRepository = new DocumentRepository()
    const userRepository = new UserRepository()
    const notificationRepository = new NotificationRepository();

    const useCase = new UpdateTaskUseCase(taskRepository, documentRepository, userRepository, notificationRepository)

    return useCase
}
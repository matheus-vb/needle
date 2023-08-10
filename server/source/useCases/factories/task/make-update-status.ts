import { TaskRepository } from "../../../repositories/Prisma/TaskRepository";
import { UserRepository } from "../../../repositories/Prisma/UserRepository";
import { UpdateTaskStatusUseCase } from "../../task/update-status";

export function makeUpdateStatusUseCase() {
    const taskRepository = new TaskRepository();
    const userRepository = new UserRepository();
    const useCase = new UpdateTaskStatusUseCase(taskRepository, userRepository);
    return useCase
}
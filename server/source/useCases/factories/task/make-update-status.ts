import { TaskRepository } from "../../../repositories/Prisma/TaskRepository";
import { UpdateTaskStatusUseCase } from "../../task/update-status";

export function makeUpdateStatusUseCase() {
    const taskRepository = new TaskRepository();
    const useCase = new UpdateTaskStatusUseCase(taskRepository);
    return useCase
}
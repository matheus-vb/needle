import { TaskRepository } from "../../../repositories/Prisma/TaskRepository";
import { AssignTaskUseCase } from "../../task/assign-task";

export function makeAssignTaskUseCase() {
    const taskRepository = new TaskRepository();
    const useCase = new AssignTaskUseCase(taskRepository);

    return useCase;
}
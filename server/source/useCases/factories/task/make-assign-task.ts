import { TaskRepository } from "../../../repositories/Prisma/TaskRepository";
import { UserRepository } from "../../../repositories/Prisma/UserRepository";
import { AssignTaskUseCase } from "../../task/assign-task";

export function makeAssignTaskUseCase() {
    const taskRepository = new TaskRepository();
    const userRepository = new UserRepository();
    const useCase = new AssignTaskUseCase(taskRepository, userRepository);

    return useCase;
}
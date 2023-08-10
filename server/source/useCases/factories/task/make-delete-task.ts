import { TaskRepository } from "../../../repositories/Prisma/TaskRepository";
import { DeleteTaskUseCase } from "../../task/delete-task";

export function makeDeleteTask(){
    const taskRepository = new TaskRepository();
    const useCase = new DeleteTaskUseCase(taskRepository);

    return useCase
}
import { TaskRepository } from "../../../repositories/Prisma/TaskRepository";
import { GetWorkspaceTasksUseCase } from "../../task/get-workspace-tasks";

export function makeGetWorkspaceTasksUseCase(){
    const tasksRepository = new TaskRepository();
    const useCase = new GetWorkspaceTasksUseCase(tasksRepository);

    return useCase;
}
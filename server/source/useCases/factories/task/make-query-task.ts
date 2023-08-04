import { TaskRepository } from "../../../repositories/Prisma/TaskRepository";
import { WorkspaceRepository } from "../../../repositories/Prisma/WorkspaceRepository";
import { QueryTasksUseCase } from "../../task/query-tasks";

export function makeQueryTasksUseCase() {
    const taskRepository = new TaskRepository()
    const workspaceRepository = new WorkspaceRepository()
    const useCase = new QueryTasksUseCase(taskRepository, workspaceRepository)

    return useCase
}
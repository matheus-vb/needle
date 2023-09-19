import { TaskRepository } from "../../../repositories/Prisma/TaskRepository";
import { GetWorkspaceTasksByStatusUseCase } from "../../workspace/get-workspace-tasks-by-status";

export function makeGetWorkspaceTasksByStatus() {
    const taskRepository = new TaskRepository()
    const useCase = new GetWorkspaceTasksByStatusUseCase(taskRepository)

    return useCase;
}   
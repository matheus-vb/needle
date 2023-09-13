import { TaskRepository } from "../../../repositories/Prisma/TaskRepository";
import { GetWorkspaceTasksFinished } from "../../workspace/get-workspace-tasks-finished";

export function makeGetWorkspaceTasksFinished() {
    const taskRepository = new TaskRepository()
    const useCase = new GetWorkspaceTasksFinished(taskRepository)

    return useCase
}
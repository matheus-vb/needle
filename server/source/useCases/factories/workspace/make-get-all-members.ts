import { TaskRepository } from "../../../repositories/Prisma/TaskRepository";
import { UserRepository } from "../../../repositories/Prisma/UserRepository";
import { WorkspaceRepository } from "../../../repositories/Prisma/WorkspaceRepository";
import { GetAllMembersUseCase } from "../../workspace/get-all-members";

export function makeGetAllMembersUseCase() {
    const taskRepository = new TaskRepository()
    const useCase = new GetAllMembersUseCase(taskRepository)

    return useCase
}
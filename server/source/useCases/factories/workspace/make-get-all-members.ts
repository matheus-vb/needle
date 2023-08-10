import { UserRepository } from "../../../repositories/Prisma/UserRepository";
import { WorkspaceRepository } from "../../../repositories/Prisma/WorkspaceRepository";
import { GetAllMembersUseCase } from "../../workspace/get-all-members";

export function makeGetAllMembersUseCase() {
    const userRepository = new UserRepository()
    const workspaceRepository = new WorkspaceRepository()
    const useCase = new GetAllMembersUseCase(userRepository, workspaceRepository)

    return useCase
}
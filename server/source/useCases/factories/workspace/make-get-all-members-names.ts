import { UserRepository } from "../../../repositories/Prisma/UserRepository";
import { WorkspaceRepository } from "../../../repositories/Prisma/WorkspaceRepository";
import { GetAllMembersNamesUseCase } from "../../workspace/get-all-members-names";

export function makeGetAllMembersNamesUseCase() {
    const userRepository = new UserRepository()
    const workspaceRepository = new WorkspaceRepository()
    const useCase = new GetAllMembersNamesUseCase(userRepository, workspaceRepository)

    return useCase
}
import { UserRepository } from "../../../repositories/Prisma/UserRepository";
import { UserWorkspaceRepository } from "../../../repositories/Prisma/UserWorkspaceRepository";
import { WorkspaceRepository } from "../../../repositories/Prisma/WorkspaceRepository";
import { UpdateRoleUseCase } from "../../user/update-role";

export function makeUpdateRoleUseCase(){
    const userRepository = new UserRepository()
    const workspaceRepository = new WorkspaceRepository()
    const userWorkspaceRepository = new UserWorkspaceRepository()

    const useCase = new UpdateRoleUseCase(userWorkspaceRepository, userRepository, workspaceRepository)
    return useCase
}

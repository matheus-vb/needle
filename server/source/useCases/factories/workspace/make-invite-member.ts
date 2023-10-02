import { UserRepository } from "../../../repositories/Prisma/UserRepository";
import { WorkspaceRepository } from "../../../repositories/Prisma/WorkspaceRepository";
import { InviteMemberUseCase } from "../../workspace/invite-member";

export function makeInviteMemberUseCase() {
    const userRepository = new UserRepository()
    const workspaceRepository = new WorkspaceRepository()

    const useCase = new InviteMemberUseCase(userRepository, workspaceRepository)

    return useCase
}

import { UserWorkspaceRepository } from "../../../repositories/Prisma/UserWorkspaceRepository";
import { DeleteWorkspaceMemberUseCase } from "../../workspace/delete-workspace-member";
import { UserRepository } from "../../../repositories/Prisma/UserRepository";

export function makeDeleteWorkspaceMemberUseCase() {
    const userWorkspaceRepository = new UserWorkspaceRepository();
    const userRepository = new UserRepository();
    const useCase = new DeleteWorkspaceMemberUseCase(userWorkspaceRepository, userRepository);

    return useCase;
}
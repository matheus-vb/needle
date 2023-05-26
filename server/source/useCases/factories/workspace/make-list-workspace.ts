import { UserRepository } from "../../../repositories/Prisma/UserRepository";
import { UserWorkspaceRepository } from "../../../repositories/Prisma/UserWorkspaceRepository";
import { WorkspaceRepository } from "../../../repositories/Prisma/WorkspaceRepository";
import { ListWorkspaceUseCase } from "../../workspace/list-workspace";

export function makeListWorkspaceUseCase() {
    const userRepository = new UserRepository();
    const userWorkspaceRepository = new UserWorkspaceRepository();
    const workspaceRepository = new WorkspaceRepository();
    const useCase = new ListWorkspaceUseCase(workspaceRepository, userRepository, userWorkspaceRepository);

    return useCase;
}
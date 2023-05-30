import { UserWorkspaceRepository } from "../../../repositories/Prisma/UserWorkspaceRepository";
import { WorkspaceRepository } from "../../../repositories/Prisma/WorkspaceRepository";
import { CreateWorkspaceUseCase } from "../../workspace/create-workspace";

export function makeCreateWorkspaceUseCase() {
    const workspaceRepository = new WorkspaceRepository();
    const userWorkspaceRespository = new UserWorkspaceRepository();
    const useCase = new CreateWorkspaceUseCase(workspaceRepository, userWorkspaceRespository);

    return useCase;
}
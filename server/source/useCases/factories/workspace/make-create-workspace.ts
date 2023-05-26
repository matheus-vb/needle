import { WorkspaceRepository } from "../../../repositories/Prisma/WorkspaceRepository";
import { CreateWorkspaceUseCase } from "../../workspace/create-workspace";

export function makeCreateWorkspaceUseCase() {
    const workspaceRepository = new WorkspaceRepository();
    const useCase = new CreateWorkspaceUseCase(workspaceRepository);

    return useCase;
}
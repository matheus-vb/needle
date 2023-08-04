import { WorkspaceRepository } from "../../../repositories/Prisma/WorkspaceRepository";
import { DeleteWorkspaceUseCase } from "../../workspace/delete-workspace";

export function makeDeleteWorkspaceUseCase() {
    const workspaceRepository = new WorkspaceRepository()
    const useCase = new DeleteWorkspaceUseCase(workspaceRepository)

    return useCase
}
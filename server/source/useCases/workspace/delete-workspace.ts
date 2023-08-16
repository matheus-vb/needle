import { Workspace } from "@prisma/client";
import { IWorkspaceInterface } from "../../repositories/IWorkspaceRepository";
import { BadRequest } from "../errors/BadRequest";

interface IDeleteWorkspaceUseCaseRequest {
    accessCode: string
}

interface IDeleteWorkspaceUseCaseReply {
    workspace: Workspace
}

export class DeleteWorkspaceUseCase {
    constructor (private workspaceRepository: IWorkspaceInterface) {}

    async handle({
        accessCode
    }: IDeleteWorkspaceUseCaseRequest): Promise<IDeleteWorkspaceUseCaseReply> {
        const workspace = await this.workspaceRepository.findByCode(accessCode)
        if (!workspace) {
            throw new BadRequest()
        }

        await this.workspaceRepository.deleteWorkspace(workspace.id);

        return {
            workspace
        }
    }
}
import { Workspace } from "@prisma/client";
import { IWorkspaceInterface } from "../../repositories/IWorkspaceRepository";
import { generateRandomAccessCode } from "../../utilities/code-generator";

interface ICreateWorkspaceUseCaseRequest {
    name: string,
}

interface ICreateWorkspaceUseCaseReply {
    workspace: Workspace
}

export class CreateWorkspaceUseCase {
    constructor(private workspaceRepository: IWorkspaceInterface) {}

    async handle({
        name,
    }: ICreateWorkspaceUseCaseRequest): Promise<ICreateWorkspaceUseCaseReply> {
        let codeInUse: Boolean = true;
        let accessCode: string = '';

        while (codeInUse) {
            accessCode = generateRandomAccessCode();

            const workspace = await this.workspaceRepository.findByCode(accessCode);
            if(!workspace) {
                codeInUse = false
            }
        }

        const workspace = await this.workspaceRepository.create({
            accessCode,
            name,
        })

        return {
            workspace,
        }
    }
}
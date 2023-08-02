import { Workspace } from "@prisma/client";
import { IUserWorkspaceRepository } from "../../repositories/IUserWorkspaceRepository";
import { IWorkspaceInterface } from "../../repositories/IWorkspaceRepository";
import { generateRandomAccessCode } from "../../utilities/code-generator";

interface ICreateWorkspaceUseCaseRequest {
    name: string,
    userId: string
}

interface ICreateWorkspaceUseCaseReply {
    workspace: Workspace
}

export class CreateWorkspaceUseCase {
    constructor(
            private workspaceRepository: IWorkspaceInterface,
            private userWorkRepository: IUserWorkspaceRepository
                ) {}

    async handle({
        name,
        userId
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

        const userWorkspace = await this.userWorkRepository.create({
            userId,
            workspaceId: workspace.id,
            userRole: "PRODUCT_MANAGER"
        })

        return {
            workspace,
        }
    }
}
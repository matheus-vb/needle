import { User_Workspace } from "@prisma/client"
import { IUserRepository } from "../../repositories/IUserRepository"
import { IWorkspaceInterface } from "../../repositories/IWorkspaceRepository"
import { IUserWorkspaceRepository } from "../../repositories/IUserWorkspaceRepository"

interface IJoinWorkspaceUseCaseRequest {
    userId: string
    accessCode: string
}

interface IJoinWorkspaceUseCaseReply {
    userWorkspace: User_Workspace
}

export class JoinWorkspaceUseCase {
    constructor(
        private userRepository: IUserRepository, 
        private workspaceRepository: IWorkspaceInterface, 
        private userWorkRepository: IUserWorkspaceRepository
    ) {}

    async handle({
        userId,
        accessCode,
    }: IJoinWorkspaceUseCaseRequest): Promise<IJoinWorkspaceUseCaseReply> {
        const user = await this.userRepository.findById(userId);
        if(!user) {
            throw new Error();
        }

        const workspace = await this.workspaceRepository.findByCode(accessCode);
        if(!workspace) {
            throw new Error();
        }

        const userWorkspace = await this.userWorkRepository.create({
            userId,
            workspaceId: workspace.id,
            userRole: "MEMBER"
        })

        return {
            userWorkspace,
        }
    }
}
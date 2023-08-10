import { Role, User_Workspace } from "@prisma/client"
import { IUserRepository } from "../../repositories/IUserRepository"
import { IWorkspaceInterface } from "../../repositories/IWorkspaceRepository"
import { IUserWorkspaceRepository } from "../../repositories/IUserWorkspaceRepository"
import { sendNotification } from "../../notification/send-notification"
import { apnProvider } from "../../notification/provider"

interface IJoinWorkspaceUseCaseRequest {
    userId: string
    accessCode: string
    role: Role
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
        role,
    }: IJoinWorkspaceUseCaseRequest): Promise<IJoinWorkspaceUseCaseReply> {
        const user = await this.userRepository.findById(userId);
        if(!user) {
            throw new Error();
        }

        const workspace = await this.workspaceRepository.findByCode(accessCode);
        if(!workspace) {
            throw new Error();
        }

        const users = await this.userRepository.getUsersInWorkspace(workspace.id)

        for(const u of users) {
            if (u.deviceToken != null) {
                sendNotification(u.deviceToken, apnProvider, `${user.name} acabou de entrar no workspace ${workspace.name}!`)
            }
        }

        const userWorkspace = await this.userWorkRepository.create({
            userId,
            workspaceId: workspace.id,
            userRole: role
        })

        return {
            userWorkspace,
        }
    }
}
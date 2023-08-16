import { Role, User_Workspace } from "@prisma/client"
import { IUserRepository } from "../../repositories/IUserRepository"
import { IWorkspaceInterface } from "../../repositories/IWorkspaceRepository"
import { IUserWorkspaceRepository } from "../../repositories/IUserWorkspaceRepository"
import { sendNotification } from "../../notification/send-notification"
import { INotificationRepository } from "../../repositories/INotificationRepository"
import { UserNotFound } from "../errors/UserNotFound"
import { BadRequest } from "../errors/BadRequest"

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
        private userWorkRepository: IUserWorkspaceRepository,
        private notificationRepository: INotificationRepository,
    ) {}

    async handle({
        userId,
        accessCode,
        role,
    }: IJoinWorkspaceUseCaseRequest): Promise<IJoinWorkspaceUseCaseReply> {
        const user = await this.userRepository.findById(userId);
        if(!user) {
            throw new UserNotFound();
        }

        const workspace = await this.workspaceRepository.findByCode(accessCode);
        if(!workspace) {
            throw new BadRequest();
        }

        const users = await this.userRepository.getUsersInWorkspace(workspace.id)

        for(const u of users) {
            if (u.deviceToken != null) {
                const alert = `${user.name} acabou de entrar no workspace ${workspace.name}!`
                sendNotification(u.deviceToken, alert, {
                    notificationRepository: this.notificationRepository,
                    userId: user.id,
                    workspaceId: workspace.id
                })
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
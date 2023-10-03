import { IUserRepository } from "../../repositories/IUserRepository"
import { IWorkspaceInterface } from "../../repositories/IWorkspaceRepository"
import { sendMail } from "../../services/sendMail"
import { BadRequest } from "../errors/BadRequest"
import { UserNotFound } from "../errors/UserNotFound"

interface IInviteMemberUseCaseRequest{
    userId: string
    workspaceId: string
    email: string
}

interface IInviteMemberUseCaseReply{
    done: boolean
}

export class InviteMemberUseCase {
    constructor(private userRepository: IUserRepository, private workspaceRepository: IWorkspaceInterface) {}

    async handle({
        userId,
        workspaceId,
        email,
    }: IInviteMemberUseCaseRequest): Promise<IInviteMemberUseCaseReply> {
        const user = await this.userRepository.findById(userId)
        if(!user) {
            throw new UserNotFound()
        }

        const workspace = await this.workspaceRepository.findById(workspaceId)
        if(!workspace) {
            throw new BadRequest()
        }

        sendMail({
            toEmail: email,
            subject: `${user.name} invited you to a Needle Workspace!`,
            content: `${user.name} just sent you an invitation to join the ${workspace.name} workspace.\nJoin Neelde and use the ${workspace.accessCode} access code to enter!\n\nDownload Neelde from the AppStore: https://apps.apple.com/br/app/needleapp/id6459739412?l=en-GB&mt=12`,
        })

        return {
            done: true
        }
    }
}

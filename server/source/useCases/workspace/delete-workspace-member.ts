import { IUserWorkspaceRepository } from "../../repositories/IUserWorkspaceRepository"
import { IUserRepository } from "../../repositories/IUserRepository"
import { UserNotFound } from "../errors/UserNotFound"
import { BadRequest } from "../errors/BadRequest"

interface IJoinWorkspaceUseCaseRequest {
    userId: string
    workspaceId: string
}

interface IDeleteWorkspaceMemberUseCaseReply {
    done: boolean
}

export class DeleteWorkspaceMemberUseCase {
    constructor(
        private userWorkspaceRepository: IUserWorkspaceRepository, private userRepository: IUserRepository ) {}

    async handle({
        userId,
        workspaceId,
    }: IJoinWorkspaceUseCaseRequest): Promise<IDeleteWorkspaceMemberUseCaseReply> {
        const user = await this.userRepository.findById(userId)
        if (!user) {
            throw new UserNotFound()
        }
        
        await this.userWorkspaceRepository.deleteWorkspaceMember(userId, workspaceId)

        return {
            done: true
        }
    }
}
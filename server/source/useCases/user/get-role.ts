import { Role } from "@prisma/client"
import { IUserRepository } from "../../repositories/IUserRepository"
import { BadRequest } from "../errors/BadRequest"

interface IGetRoleInWorkspaceUseCaseRequest {
    userId: string
    workspaceId: string
}

interface IGetRoleInWorkspaceUseCaseReply {
    role: Role
}

export class GetRoleInWorkspaceUseCase {
    constructor(private userRepository: IUserRepository) {}

    async handle({
        workspaceId,
        userId,
    }: IGetRoleInWorkspaceUseCaseRequest): Promise<IGetRoleInWorkspaceUseCaseReply> {
        const role = await this.userRepository.getUserRoleInWorkspace(workspaceId, userId);

        if (!role) {
            throw new BadRequest()
        }

        return { 
            role,
        }
    }
}
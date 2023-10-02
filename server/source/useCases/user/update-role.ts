import { Role } from "@prisma/client";
import { IUserWorkspaceRepository } from "../../repositories/IUserWorkspaceRepository";
import { IUserRepository } from "../../repositories/IUserRepository";
import { IWorkspaceInterface } from "../../repositories/IWorkspaceRepository";
import { UserNotFound } from "../errors/UserNotFound";
import { BadRequest } from "../errors/BadRequest";

interface IUpdateRoleUseCaseRequest {
    userId: string
    workspaceId: string
    role: Role
}

interface IUpdateRoleUseCaseReply {
    done: boolean
}

export class UpdateRoleUseCase {
    constructor(
        private userWorkspaceRepository: IUserWorkspaceRepository,
        private userRepository: IUserRepository,
        private workspaceRepository: IWorkspaceInterface,
    ) {}

    async handle({
        userId,
        workspaceId,
        role,
    }: IUpdateRoleUseCaseRequest): Promise<IUpdateRoleUseCaseReply> {
        const user = await this.userRepository.findById(userId)
        if(!user) {
            throw new UserNotFound() 
        }

        const workspace = await this.workspaceRepository.findById(workspaceId)
        if (!workspace) {
            throw new BadRequest()
        }

        await this.userWorkspaceRepository.updateRole(userId, workspaceId, role)

        return {
            done: true
        }
    }
}

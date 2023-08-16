import { User } from "@prisma/client";
import { IUserRepository } from "../../repositories/IUserRepository";
import { IWorkspaceInterface } from "../../repositories/IWorkspaceRepository";
import { BadRequest } from "../errors/BadRequest";

interface IGetAllMembersUseCaseRequest {
    workspaceId: string
}

interface IGetAllMembersUseCaseReply {
    members: User[]
}

export class GetAllMembersUseCase {
    constructor (private userRepository: IUserRepository, private workspaceRepository: IWorkspaceInterface) {}

    async handle({
        workspaceId,
    }: IGetAllMembersUseCaseRequest): Promise<IGetAllMembersUseCaseReply> {
        const workspace = await this.workspaceRepository.findById(workspaceId)
        if (!workspace) {
            throw new BadRequest()
        }

        const members = await this.userRepository.getUsersInWorkspace(workspaceId);

        return {
            members,
        }
    }
}
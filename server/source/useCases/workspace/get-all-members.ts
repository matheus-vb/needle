import { User } from "@prisma/client";
import { IUserRepository } from "../../repositories/IUserRepository";
import { IWorkspaceInterface } from "../../repositories/IWorkspaceRepository";

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
            throw new Error()
        }

        const members = await this.userRepository.getUsersInWorkspace(workspaceId);

        return {
            members,
        }
    }
}
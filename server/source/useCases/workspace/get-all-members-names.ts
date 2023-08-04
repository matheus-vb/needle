import { IUserRepository } from "../../repositories/IUserRepository";
import { IWorkspaceInterface } from "../../repositories/IWorkspaceRepository";

interface IGetAllMembersNamesUseCaseRequest {
    workspaceId: string
}

interface IGetAllMembersNamesUseCaseReply {
    members: { name: string; }[]
}

export class GetAllMembersNamesUseCase {
    constructor (private userRepository: IUserRepository, private workspaceRepository: IWorkspaceInterface) {}

    async handle({
        workspaceId,
    }: IGetAllMembersNamesUseCaseRequest): Promise<IGetAllMembersNamesUseCaseReply> {
        const workspace = await this.workspaceRepository.findById(workspaceId)
        if (!workspace) {
            throw new Error()
        }

        const members = await this.userRepository.getUserNamesInWorkspace(workspaceId);

        return {
            members,
        }
    }
}
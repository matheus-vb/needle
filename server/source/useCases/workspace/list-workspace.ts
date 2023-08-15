import { Workspace } from "@prisma/client"
import { IWorkspaceInterface } from "../../repositories/IWorkspaceRepository"
import { IUserRepository } from "../../repositories/IUserRepository"
import { UserNotFound } from "../errors/UserNotFound"

interface IListWorkspaceUseCaseRequest {
    id: string
}

interface IListWorkspaceUseCaseReply {
    workspaces: Workspace[]
}

export class ListWorkspaceUseCase {
    constructor(private workspaceRepository: IWorkspaceInterface, private  userRepository: IUserRepository) {}

    async handle({
        id
    }:IListWorkspaceUseCaseRequest): Promise<IListWorkspaceUseCaseReply> {
        const user = await this.userRepository.findById(id)
        if(!user) {
            console.log(id)
            throw new UserNotFound()
        }
        
        const workspaces = await this.workspaceRepository.findWorkspaceList(id)

        return {
            workspaces,
        }
    }
}
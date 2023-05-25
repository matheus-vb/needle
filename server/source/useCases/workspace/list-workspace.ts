import { Workspace } from "@prisma/client"
import { IWorkspaceInterface } from "../../repositories/IWorkspaceRepository"
import { promises } from "dns"
import { IUserRepository } from "../../repositories/IUserRepository"
import { IUserWorkspaceRepository } from "../../repositories/IUserWorkspaceRepository"
import { UserNotFound } from "../errors/UserNotFound"

interface IListWorkspaceUseCaseRequest {
    id: string
}

interface IListWorkspaceUseCaseReply {
    workspaces: Workspace[] | null
}

export class ListWorkspaceUseCase {
    constructor(private workspaceRepository: IWorkspaceInterface, private  userRepository: IUserRepository, private userWorkspaceRepository: IUserWorkspaceRepository) {}

    async handle({
        id
    }:IListWorkspaceUseCaseRequest): Promise<IListWorkspaceUseCaseReply> {
        const user = await this.userRepository.findById(id)
        if(!user) {
            throw new UserNotFound()
        }
        const listUserWorkspace = await this.userWorkspaceRepository.findByUserId(id)
        var workspacesList: Workspace[] | null = []

        if(!listUserWorkspace){
            return {workspaces: workspacesList}
        }
        
        const workspaceIds = listUserWorkspace.map(obj => obj.workspaceId)
        workspacesList = await this.workspaceRepository.findWorkspaceList(workspaceIds)

        return {workspaces: workspacesList}
    }
}
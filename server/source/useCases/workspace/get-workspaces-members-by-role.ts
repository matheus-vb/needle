import { User } from "@prisma/client"
import { IUserRepository } from "../../repositories/IUserRepository"

interface IGetWorkspaceMembersByRoleRequest{
    workspaceId: string
    role: string
}

interface IGetWorkspaceMembersByRoleReply{
    members: User[]
}

export class GetWorkspaceMembersByRoleUseCase{
    constructor(private userRepository: IUserRepository){}
    
    async handle({
        workspaceId,
        role
    }: IGetWorkspaceMembersByRoleRequest): Promise<IGetWorkspaceMembersByRoleReply>{
        console.log(workspaceId)
        console.log(role)
        const users = await this.userRepository.findAllUsersInWorkspace(workspaceId, role);

        return {
            members: users
        }
    }
}
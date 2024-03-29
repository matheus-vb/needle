import { Role, User } from "@prisma/client"
import { IUserRepository } from "../../repositories/IUserRepository"

interface IGetWorkspaceMembersByRoleRequest{
    workspaceId: string
    role: Role
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
        const users = await this.userRepository.findAllUsersInWorkspace(workspaceId, role);

        return {
            members: users
        }
    }
}
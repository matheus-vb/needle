import { Prisma, User, Role } from "@prisma/client"

export interface IUserRepository {
    create(data: Prisma.UserCreateInput): Promise<User>;
    findById(id: string): Promise<User | null>;
    findByEmail(email: string): Promise<User | null>;
    findAllUsersInWorkspace(workspaceId: string, role: Role): Promise<User[]>
    getUsersInWorkspace(workspaceId: string): Promise<User[]>;
    updateDeviceToken(id: string, deviceToken: string): Promise<User>;
    getUserRoleInWorkspace(workspaceId: String, userId: string): Promise<Role | null>;
}
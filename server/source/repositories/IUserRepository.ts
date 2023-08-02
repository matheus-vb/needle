import { Prisma, User, Role } from "@prisma/client"

export interface IUserRepository {
    create(data: Prisma.UserCreateInput): Promise<User>;
    findById(id: string): Promise<User | null>;
    findByEmail(email: string): Promise<User | null>;
    findAllUsersInWorkspace(workspaceId: string, role: Role): Promise<User[]>
    getUserNamesInWorkspace(workspaceId: string): Promise<{ name: string; }[]>;
}
import { Prisma, User_Workspace } from "@prisma/client";

export interface IUserWorkspaceRepository {
    create(data: Prisma.User_WorkspaceUncheckedCreateInput): Promise<User_Workspace>;
    findByUserId(id: string): Promise<User_Workspace | null>;
    findByWorkspaceId(id: string): Promise<User_Workspace | null>;
    findById(id: string): Promise<User_Workspace | null>;
}
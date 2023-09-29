import { Prisma, Role, User_Workspace } from "@prisma/client";

export interface IUserWorkspaceRepository {
    create(data: Prisma.User_WorkspaceUncheckedCreateInput): Promise<User_Workspace>;
    findByUserId(id: string): Promise<User_Workspace[]>;
    findByWorkspaceId(id: string): Promise<User_Workspace | null>;
    findById(id: string): Promise<User_Workspace | null>;
    findUserInWorkspace(userId: string, workspaceId: string): Promise<User_Workspace | null>;
    checksIfAUserHasAlreadyEnteredTheWorkspace(userId: string, accessCode: string): Promise<boolean>;
    deleteWorkspaceMember(userId: string, workspaceId: string): Promise<void>;
    updateRole(userId: string, workspaceId: string, role: Role): Promise<boolean>;
}

import { Prisma, User_Workspace } from "@prisma/client";
import { prisma } from "../../lib/prisma";
import { IUserWorkspaceRepository } from "../IUserWorkspaceRepository";


export class UserRepositoryRepository implements IUserWorkspaceRepository{
    async create(data: Prisma.User_WorkspaceUncheckedCreateInput): Promise<User_Workspace> {
        const relatioUserWorkspace = await prisma.user_Workspace.create({
            data,
        })
        return relatioUserWorkspace
    }
    findByUserId(id: string): Promise<User_Workspace | null> {
        throw new Error("Method not implemented.");
    }
    findByWorkspaceId(id: string): Promise<User_Workspace | null> {
        throw new Error("Method not implemented.");
    }
    findById(id: string): Promise<User_Workspace | null> {
        throw new Error("Method not implemented.");
    }
    findUserInWorkspace(userId: string, workspaceId: string): Promise<User_Workspace | null> {
        throw new Error("Method not implemented.");
    }

}
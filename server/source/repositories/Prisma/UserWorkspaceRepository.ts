import { Prisma, User_Workspace } from "@prisma/client";
import { prisma } from "../../lib/prisma";
import { IUserWorkspaceRepository } from "../IUserWorkspaceRepository";


export class UserWorkspaceRepository implements IUserWorkspaceRepository{
    async create(data: Prisma.User_WorkspaceUncheckedCreateInput): Promise<User_Workspace> {
        const relatioUserWorkspace = await prisma.user_Workspace.create({
            data,
        })
        return relatioUserWorkspace
    }
    async findByUserId(id: string): Promise<User_Workspace[]> {
        const realationUserWorkspace = await prisma.user_Workspace.findMany({
            where: {
                userId: id,
            }
        })
        return realationUserWorkspace
    }
    async findByWorkspaceId(id: string): Promise<User_Workspace | null> {
        const realationUserWorkspace = await prisma.user_Workspace.findFirst({
            where: {
                workspaceId: id,
            }
        })
        return realationUserWorkspace
    }
    async findById(id: string): Promise<User_Workspace | null> {
        const relationUserWorkspace = await prisma.user_Workspace.findFirst({
            where: {
                id: id,
            }
        })
        return relationUserWorkspace
    }
    async findUserInWorkspace(userId: string, workspaceId: string): Promise<User_Workspace | null> {
        const relationUserWorkspace = await prisma.user_Workspace.findFirst({
            where: {
                userId: userId,
                workspaceId: workspaceId
            }
        })
        
        return (relationUserWorkspace ? relationUserWorkspace : null)
    }

    async checksIfAUserHasAlreadyEnteredTheWorkspace(userId: string, accessCode: string): Promise<boolean> {
        const relation = await prisma.user_Workspace.findFirst({
            where:{
                userId: userId,
                workspace:{
                    accessCode: accessCode
                }
            }
        })
        if(!relation){
            return false;
        }
        return true;
    }
}
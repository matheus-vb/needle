import { Prisma, Role, Workspace } from "@prisma/client";
import { prisma } from "../../lib/prisma";
import { IWorkspaceInterface } from "../IWorkspaceRepository";

export class WorkspaceRepository implements IWorkspaceInterface{
    async findById(id: string): Promise<Workspace | null> {
        const workspace = await prisma.workspace.findUnique({
            where: {
                id: id
            }
        })
        return workspace
    }

    async findByCode(code: string): Promise<Workspace | null> {
        const workspace = await prisma.workspace.findUnique({
            where: {
                accessCode: code
            }
        })
        return workspace
    }

    async create(data: Prisma.WorkspaceCreateInput): Promise<Workspace> {
        const workspace = await prisma.workspace.create({
            data,
        })
        return workspace
    }

    async findWorkspaceList(userId: string): Promise<Workspace[]> {
        const elements = await prisma.workspace.findMany({
            where: {
                users: {
                    some: {
                        userId
                    }
                }
            },
            include: {
                users: {
                    where: {
                        userRole: Role.PRODUCT_MANAGER
                    }
                }
            }
        })

        return elements
    }

    async deleteWorkspace(id: string) {
        const workspace = await prisma.workspace.delete({
            where: {
                id,
            }
        })

        return workspace;
    }
}
import { Prisma, Role } from "@prisma/client";
import { prisma } from "../../lib/prisma";
import { IUserRepository } from "../IUserRepository";

export class UserRepository implements IUserRepository {
    async create(data: Prisma.UserCreateInput) {
        const user = await prisma.user.create({
            data,
        })
        return user
    }

    async findById(id: string) {
        const user = await prisma.user.findFirst({
            where: {
                id: id
            }
        })
        return user
    }
    async findByEmail(email: string) {
        const user = await prisma.user.findFirst({
            where: {
                email: email,
            }
        })
        return user
    }

    async findAllUsersInWorkspace(workspaceId: string, role: Role) {
        const users = await prisma.user.findMany({
            where: {
                workspaces: {
                    some: {
                        workspaceId: workspaceId,
                        userRole: role
                    }
                },
            }
        })

        return users
    }

    async getUsersInWorkspace(workspaceId: string) {
        const members = await prisma.user.findMany({
            where: {
                workspaces: {
                    some: {
                        workspaceId: workspaceId,
                    },
                },
            }
        });

        return members
    }

    async updateDeviceToken(id: string, deviceToken: string) {
        const user = await prisma.user.update({
            where: {
                id,
            },
            data: {
                deviceToken,
            }
        })

        return user
    }

    async getUserRoleInWorkspace(workspaceId: string, userId: string) {
        const userWorkspace = await prisma.user_Workspace.findFirst({
            where: {
                userId,
                workspaceId,
            }
        })

        if(!userWorkspace) {
            return null
        }

        return userWorkspace.userRole
    }
}
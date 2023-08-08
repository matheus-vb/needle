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

    async getUserNamesInWorkspace(workspaceId: string) {
        const members = await prisma.user.findMany({
            where: {
                workspaces: {
                    some: {
                        workspaceId: workspaceId,
                    },
                },
            },
            select: {
                name: true,
            },
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

}
import { Prisma, Notification } from "@prisma/client";
import { INotificationRepository } from "../INotificationRepository";
import { prisma } from "../../lib/prisma";

export class NotificationRepository implements INotificationRepository {
    async create(data: Prisma.NotificationUncheckedCreateInput) {
        const notification = await prisma.notification.create({
            data,
        })

        return notification
    }
    
    async findById(id: string) {
        const notification = await prisma.notification.findUnique({
            where: {
                id,
            }
        })

        return notification
    }
    
    async findByWorkspaceId(workspaceId: string) {
        const notifications = await prisma.notification.findMany({
            where: {
                workspaceId,
            },
            include: {
                user: true,
            }
        })

        return notifications
    }

    async getUserNotifications(userId: string) {
        const notifications = await prisma.notification.findMany({
            where: {
                userId,
            },
            include: {
                workspace: true,
            }
        })

        return notifications
    }

    async deleteNotification(id: string) {
        const notification = await prisma.notification.delete({
            where: {
                id,
            }
        })    

        return notification
    }

    async deleteUserNotifications(userId: string) {
        await prisma.notification.deleteMany({
            where: {
                userId,
            }
        })

        return
    }
}
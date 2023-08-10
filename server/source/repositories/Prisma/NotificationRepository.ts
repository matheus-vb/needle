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

    async getUserNotifications(userId: string) {
        const notifications = await prisma.notification.findMany({
            where: {
                userId,
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

}
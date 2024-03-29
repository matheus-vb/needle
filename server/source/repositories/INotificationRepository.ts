import { Notification, Prisma } from "@prisma/client";

export interface INotificationRepository {
    create(data: Prisma.NotificationUncheckedCreateInput): Promise<Notification>
    findById(id: string): Promise<Notification | null>
    getUserNotifications(userId: string): Promise<Notification[]>
    deleteNotification(id: string): Promise<Notification>
    deleteUserNotifications(userId: string): Promise<void>
    findByWorkspaceId(workspaceId: string): Promise<Notification[]>
}
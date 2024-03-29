import { Prisma, Task, TaskPriority, TaskStatus, TaskType } from "@prisma/client";
import { prisma } from "../../lib/prisma";
import { ITaskRepository } from "../ITaskRepository";

export class TaskRepository implements ITaskRepository {

    async findTasksByWorkspaceIdAndStatus(workspaceId: string, status: TaskStatus): Promise<number> {
        const tasks = await prisma.task.findMany({ 
            where: {
                workId: workspaceId,
                status: status
            }
        })
        return tasks.length;
    }

    async create(data: Prisma.TaskUncheckedCreateInput) {
        const task = await prisma.task.create({
            data,
        })
        return task;
    }

    async findById(id: string) {
        const task = await prisma.task.findFirst(
            {
                where: {
                    id: id,
                }
            }
        )
        return task
    }

    async filterByAuthor(id: string) {
        const tasks = await prisma.task.findMany({
            where: {
                user: {
                    id: id,
                }
            }
        })
        return tasks
    }

    async updateStatus(id: string, status: TaskStatus) {
        const task = await prisma.task.update({
            where: {
                id: id,
            },
            data: {
                status: status,
            }
        })
        return task
    }

    async updateAssignee(id: string, userId: string) {
        const task = await prisma.task.update({
            where: {
                id,
            },
            data: {
                userId,
            }
        })

        return task;
    }

    async findTasksByWorksapceId(workspaceId: string): Promise<Task[]> {
        const tasks = await prisma.task.findMany({
            where: {
                workId: workspaceId,
            },
            include: {
                document: true,
                user: true,
            },
        })

        return tasks;
    }

    async deleteTask(taskId: string) {
        await prisma.task.delete({
            where: {
                id: taskId,
            }
        })
    }

    async queryTasks(workspaceId: string, query: string | null, status: TaskStatus | null, area: TaskType | null, priority: TaskPriority | null) {
        let whereClause: any = {
            workId: workspaceId,
            status: status || undefined,
            type: area || undefined,
            taskPriority: priority || undefined
        };
    
        if (query) {
            whereClause = {
                ...whereClause,
                OR: [
                    {
                        title: {
                            contains: query,
                            mode: "insensitive",
                        },
                    },
                    {
                        user: {
                            name: {
                                contains: query,
                                mode: "insensitive",
                            },
                        },
                    },
                    {
                        description: {
                            contains: query,
                            mode: "insensitive",
                        }
                    },
                ],
            };
        }
    
        const tasks = await prisma.task.findMany({
            where: whereClause,
            include: {
                document: true,
                user: true
            }
        });
    
        return tasks;
    }

    async updateTask(taskId: string, title: string, description: string, status: TaskStatus, type: TaskType, endDate: Date, priority: TaskPriority, userId: string | null): Promise<Task> {
        const task = await prisma.task.update({
            where:{
                id: taskId,
            },
            data: {
                title,
                description,
                status,
                type,
                endDate,
                taskPriority: priority,
                userId,
            }
        })
        return task
    }
    
    async updateIsVisibleStatus(taskId: string, isVisibile: boolean): Promise<Task> {
        const task = await prisma.task.update({
            where:{
                id: taskId,
            },
            data:{
                isVisible: isVisibile
            }
        })
        return task
    }

}
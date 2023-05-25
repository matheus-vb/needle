import { Prisma, Task, TaskStatus } from "@prisma/client";
import { prisma } from "../../lib/prisma";
import { ITaskRepository } from "../ITaskRepository";

export class TaskRepository implements ITaskRepository{

    async create(data: Prisma.TaskUncheckedCreateInput) {
        const task = await prisma.task.create({
            data,
        })
        return task;
    }

    async findById(id: string) {
        const task = await prisma.task.findFirst(
            {
                where:{
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
    
}
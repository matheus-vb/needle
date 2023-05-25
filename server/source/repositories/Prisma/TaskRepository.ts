import { Prisma, Task, TaskStatus } from "@prisma/client";
import { prisma } from "../../lib/prisma";
import { ITaskRepository } from "../ITaskRepository";

export class TaskRepository implements ITaskRepository{

    async create(data: Prisma.TaskUncheckedCreateInput): Promise<Task> {
        const task = await prisma.task.create({
            data,
        })
        return task;
    }

    async findById(id: string): Promise<Task | null> {
        const task = await prisma.task.findFirst(
            {
                where:{
                    id: id,
                }
            }
        )
        return task
    }
    filterByAuthor(id: string): Promise<Task[]> {
        throw new Error("Method not implemented.");
    }
    updateStatus(id: string, status: TaskStatus): Promise<Task> {
        throw new Error("Method not implemented.");
    }
    
}
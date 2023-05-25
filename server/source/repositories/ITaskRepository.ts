import { Prisma, Task, TaskStatus } from "@prisma/client";

export interface ITaskRepository {
    create(data: Prisma.TaskUncheckedCreateInput): Promise<Task>;
    findById(id: string): Promise<Task | null>;
    filterByAuthor(id: string): Promise<Task[]>;
    updateStatus(id: string, status: TaskStatus): Promise<Task>;
}
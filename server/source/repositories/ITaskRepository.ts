import { Prisma, Task } from "@prisma/client";

export interface ITaskRepository {
    create(data: Prisma.TaskCreateInput): Promise<Task>;
    findById(id: string): Promise<Task | null>;
    filterByAuthor(id: string): Promise<Task[]>;
}
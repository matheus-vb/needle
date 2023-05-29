import { Prisma, Task, TaskStatus } from "@prisma/client";

export interface ITaskRepository {
    create(data: Prisma.TaskUncheckedCreateInput): Promise<Task>;
    findById(id: string): Promise<Task | null>;
    filterByAuthor(id: string): Promise<Task[]>;
    updateStatus(id: string, status: TaskStatus): Promise<Task>;
    updateAssignee(id: string, userId: string): Promise<Task>;
    findTasksByWorksapceId(workspaceId: string): Promise<Task[]>;
    deleteTask(taskId: string): Promise<void>;
}
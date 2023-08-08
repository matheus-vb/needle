import { Prisma, Task, TaskPriority, TaskStatus, TaskType } from "@prisma/client";

export interface ITaskRepository {
    create(data: Prisma.TaskUncheckedCreateInput): Promise<Task>;
    findById(id: string): Promise<Task | null>;
    filterByAuthor(id: string): Promise<Task[]>;
    updateStatus(id: string, status: TaskStatus): Promise<Task>;
    updateAssignee(id: string, userId: string): Promise<Task>;
    findTasksByWorksapceId(workspaceId: string): Promise<Task[]>;
    updateTask(taskId: string, title:string, 
        description:string, status:TaskStatus, type: TaskType, endDate: Date, priority: TaskPriority, userId: string): Promise<Task>;
    deleteTask(taskId: string): Promise<void>;
    queryTasks(
        workspaceId: string,
        query: string | null,
        status: string | null,
        area: string | null,
        priority: string | null
        ): Promise<Task[]>;
}
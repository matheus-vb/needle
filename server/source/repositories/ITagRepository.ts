import { Prisma, TaskTag } from "@prisma/client";

export interface ITagRepository {
    create(data: Prisma.TaskTagUncheckedCreateInput): Promise<TaskTag>;
    getTagsInTask(taskId: string): Promise<TaskTag[]>;
}
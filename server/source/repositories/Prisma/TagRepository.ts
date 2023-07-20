import { Prisma, TaskTag } from "@prisma/client";
import { ITagRepository } from "../ITagRepository";
import { prisma } from "../../lib/prisma";

export class TagRepository implements ITagRepository {
    async create(data: Prisma.TaskTagUncheckedCreateInput) {
        const tag = await prisma.taskTag.create({
            data,
        })

        return tag;
    }

    async getTagsInTask(taskId: string) {
        const tags = await prisma.taskTag.findMany({
            where: {
                taskId,
            }
        })

        return tags;
    }
}
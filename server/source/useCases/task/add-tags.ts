import { TaskTag } from "@prisma/client";
import { ITaskRepository } from "../../repositories/ITaskRepository";
import { ITagRepository } from "../../repositories/ITagRepository";

interface IAddTagsToTaskUseCaseRequest {
    taskId: string,
    tags: string[]
}

interface IAddTagsToTaskUseCaseReply {
    tagsOut: TaskTag[]
}

export class AddTagsToTaskUseCase {
    constructor(private taskRepository: ITaskRepository, private tagRepository: ITagRepository) {}

    async handle({
        taskId,
        tags,
    }: IAddTagsToTaskUseCaseRequest): Promise<IAddTagsToTaskUseCaseReply> {
        const task = await this.taskRepository.findById(taskId);
        if(!task) {
            throw new Error();
        }

        let tagsOut: TaskTag[] = []

        for (const tag of tags) {
            const currentTag = await this.tagRepository.create({
                taskId,
                tag
            })

            tagsOut.push(currentTag);
        }

        return {
            tagsOut,
        }
    }
}
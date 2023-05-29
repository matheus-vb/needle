import { TagRepository } from "../../../repositories/Prisma/TagRepository";
import { TaskRepository } from "../../../repositories/Prisma/TaskRepository";
import { AddTagsToTaskUseCase } from "../../task/add-tags";

export function makeAddTagsUseCase() {
    const taskRepository = new TaskRepository();
    const tagsRepository = new TagRepository();
    const useCase = new AddTagsToTaskUseCase(taskRepository, tagsRepository);

    return useCase;
}
import { UserRepository } from "../../../repositories/Prisma/UserRepository";
import { DeleteUserUseCase } from "../../user/delete-user";

export function makeDeleteUser(){
    const userRepository = new UserRepository();
    const useCase = new DeleteUserUseCase(userRepository);

    return useCase
}
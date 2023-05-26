import { UserRepository } from "../../../repositories/Prisma/UserRepository";
import { RegisterUserUseCase } from "../../auth/register";

export function makeRegisterUseCase() {
    const userRepository = new UserRepository();
    const useCase = new RegisterUserUseCase(userRepository);

    return useCase;
}
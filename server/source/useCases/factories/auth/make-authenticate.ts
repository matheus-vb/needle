import { UserRepository } from "../../../repositories/Prisma/UserRepository";
import { AuthenticateUserUseCase } from "../../auth/authenticate";

export function makeAuthenticateUseCase() {
    const userRepository = new UserRepository();
    const useCase = new AuthenticateUserUseCase(userRepository);

    return useCase;
}
import { UserRepository } from "../../../repositories/Prisma/UserRepository";
import { SignInUseCase } from "../../auth/sign-in";

export function makeSignInUseCase() {
    const userRepository = new UserRepository();
    const useCase = new SignInUseCase(userRepository);

    return useCase;
}
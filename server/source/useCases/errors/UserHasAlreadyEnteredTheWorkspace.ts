export class UserHasAlreadyEnteredTheWorkspace extends Error {
    constructor() {
        super("User has already entered the workspace")
    }
}
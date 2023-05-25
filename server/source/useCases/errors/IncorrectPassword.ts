export class IncorrectPassword extends Error {
    constructor() {
        super("Incorrect password!")
    }
}
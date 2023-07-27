import { app } from "./app";

app.listen({
    host: "0.0.0.0",
    port: 3010,
}).then(() => {
    console.log("listening on port localhost:3000")
})
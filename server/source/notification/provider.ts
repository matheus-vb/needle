import { env } from "../env";
import apn from "apn"

let options: apn.ProviderOptions = {
    token: {
        key: "./auth-key.p8",
        keyId: env.KEY_ID,
        teamId: env.TEAM_ID,
    },
    production: env.NODE_ENV === "PROD" ? true : false
}


export const apnProvider = new apn.Provider(options);
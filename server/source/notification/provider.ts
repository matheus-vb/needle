import { env } from "../env";
import apn from "apn"

export class APNSingleton {
    private static instance: APNSingleton

    public provider: apn.Provider

    private constructor() {
        let options: apn.ProviderOptions = {
            token: {
                key: "./auth-key.p8",
                keyId: env.KEY_ID,
                teamId: env.TEAM_ID,
            },
            production: env.NODE_ENV === "PROD" ? true : false
        }

        this.provider = new apn.Provider(options)
    }


    public static shared(): APNSingleton {
        if (!APNSingleton.instance) {
            APNSingleton.instance = new APNSingleton();
        }

        return APNSingleton.instance
    }
}
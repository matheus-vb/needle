import 'dotenv/config'
import { z } from 'zod';

const envSchema = z.object({
    PORT: z.coerce.number().default(3001),
    KEY_ID: z.string(),
    TEAM_ID: z.string(),
    BUNDLE_ID: z.string(),
    NODE_ENV: z.string(),
})

const _env = envSchema.safeParse(process.env);

if (_env.success === false) {
    console.error("Invalid environment variables", _env.error.format());

    throw new Error("Invalid environment variables");
}

export const env = _env.data
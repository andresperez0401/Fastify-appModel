import { z } from 'zod';

//Modelo base utilizado porque todas las tablas tienen estos campos 
export const basicModelDefinition = z.object({
    id: z.string().uuid(),
    active: z.boolean(),
    createdAt: z.string().datetime().or(z.date()),
    updatedAt: z.string().datetime().or(z.date()),
});
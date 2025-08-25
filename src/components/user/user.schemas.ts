import { z } from 'zod';

export const CreateUserSchema = z.object({
  firstName:  z.string().min(1, 'firstName es requerido'),
  lastName:   z.string().min(1, 'lastName es requerido'),
  email:      z.string().email('email inválido'),
  password:   z.string().min(6, 'password mínimo 6 caracteres'),
  type:       z.enum(['admin', 'professor']),
  birthDate:  z.string().datetime().optional(), // ISO 8601 (opcional)
  phoneNumber: z
    .object({
      areaCode: z.string().min(1, 'phoneNumber.areaCode es requerido'),
      number:   z.string().min(1, 'phoneNumber.number es requerido'),
    })
    .optional(),
});

export type CreateUserDTO = z.infer<typeof CreateUserSchema>;

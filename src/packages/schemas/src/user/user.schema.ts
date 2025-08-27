import { z } from 'zod';
import { basicModelDefinition } from '../utils/basicDefinition';

export const UserSchema = basicModelDefinition.extend({
  firstName:  z.string().min(1, 'firstName es requerido'),
  lastName:   z.string().min(1, 'lastName es requerido'),
  email:      z.string().email('email inválido'),
  password:   z.string().min(8, 'password mínimo 8 caracteres'),
  type:       z.enum(['admin', 'professor']),
  birthDate:  z.string().datetime().optional(), 
  phoneNumber: z
    .object({
      areaCode: z.string().min(1, 'areaCode es requerido'),
      number:   z.string().min(1, 'number es requerido'),
    })
    .optional(),
});
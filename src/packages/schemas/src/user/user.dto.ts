import { z } from 'zod';
import { UserSchema } from './user.schema';

//Se definen los esquemas para que sigan la estructura del UserSchema de od
const createUserInput = UserSchema.pick({
    firstName: true, 
    lastName: true,
    email: true,
    password: true,
    type: true,
    birthDate: true,
    phoneNumber: true,
});

//este es el dto que se utilizara en el servicio y controlador
export interface TUserDTO {
    CreateUserInput: z.infer<typeof createUserInput>;
}

//Hacemos el freeze para que no le puden modificar nada, solo usarlo como tipo
export const UserDTO = Object.freeze({
    createUserInput,
});




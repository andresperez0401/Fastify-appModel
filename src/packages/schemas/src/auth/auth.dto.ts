import { z } from 'zod';
import { UserSchema } from '../user/user.schema';

//Se definen los esquemas para que sigan la estructura del UserSchema de zod
const signUpInput = UserSchema.pick({
    firstName: true, 
    lastName: true,
    email: true,
    password: true,
    type: true,
    birthDate: true,
    phoneNumber: true,
});

const logInInput = UserSchema.pick({
    email: true,
    password: true,
});



//este es el dto que se utilizara en el servicio y controlador
// Aui ya esta tipado para TS, mientras que los de arriba son schemas con Zod
export interface TAuthDTO {
    logInInput: z.infer<typeof logInInput>;
    signUpInput: z.infer<typeof signUpInput>;
}

//Hacemos el freeze para que no le puden modificar nada, solo usarlo como tipo
export const AuthDTO = Object.freeze({
    logInInput,
    signUpInput,
});

import fp from 'fastify-plugin';
import type { FastifyInstance, FastifyReply, FastifyRequest } from 'fastify';
import { TUserDTO, UserDTO } from '@/packages/schemas/src/user/user.dto';
import { TAuthDTO } from '@/packages/schemas/src/auth/auth.dto';
import { thrower } from '@/errors/thrower';
import { compareHash, hash } from '@/lib/encryptor';
import { Exception } from '@/errors/exception';
import { BrowserDetectInfo } from '@/types/browser';
import { generateSession } from './utils/session';


//Le agregamos la propiedad authService al FastifyInstance
declare module 'fastify' {
  interface FastifyInstance {
    authService: AuthService;
  }
}

class AuthService {

    //Se agrega el Fastify como atributo de la clase, para que pueda acceder a otros servicios dentro de Fastify
    private fastify: FastifyInstance;

    constructor(fastify: FastifyInstance) {
        this.fastify = fastify;
    }


// Metodos

//------------------------------------------------------------------------------------------------------------------------------------------
//Metodo para registrar un nuevo usuario, en este metodo solo se valida si ya existe un usuario con el mismo email o teléfono
    async signUp(args: TAuthDTO['signUpInput']) {

        //Verificamos si ya existe un usuario con el mismo email
        const existingUser = await this.fastify.prisma.user.findUnique({
            where: { email: args.email },
        });

        if (existingUser) {
            //Si ya existe, lanzamos una excepción personalizada
            thrower.exception('user', 'email-taken', { email: args.email });
        }

        args.password = await hash(args.password);
        //Se crea el usuario con prisma
        const user = await this.fastify.prisma.user.create({
            data: {
                ...args
            }});
        return user;
    }
//------------------------------------------------------------------------------------------------------------------------------------------


//------------------------------------------------------------------------------------------------------------------------------------------
//Metodo para validar si un email ya esta registrado en la base de datos
    async checkEmail(args: TAuthDTO['emailInput']) {
    
    const user = await this.fastify.prisma.user.findFirst({
        where: { 
            email: args.email,
            type: args.type 
        },
    });


    return !!user;
}
//------------------------------------------------------------------------------------------------------------------------------------------

 

//----------------------------------------------------------------------------------------------------------
//Metodo para hacer login en la aplicacion
    async signIn(args: TAuthDTO['logInInput'],
                 browser: BrowserDetectInfo,
                 ip: string) {

        const user = await this.fastify.prisma.user.findUnique({ where: { email: args.email } });

        console.log(browser)
        
        if (!user || !(await compareHash(user.password, args.password))) {
            thrower.exception('auth', 'invalid-credentials');
        }

        //Validamos que la variable de entorno Secret este configurada
        if (!process.env.SECRET) thrower.exception('auth', 'internal-error');

        //Parseamos el usuario obtenido desde la base de datos, para que siga la estructura del DTO
        const resultUser = UserDTO.sessionUserInput.safeParse(user);

        //Capturamos el error si no lo puede parsear bien
        if (!resultUser.success) {
            thrower.exception('auth', 'internal-error');
            return;
        }

        //Creamos la sesion 
        const session = await generateSession(resultUser.data, browser, ip);

        // Guardamos la sesion en la BD
        const createdSession = await this.fastify.prisma.session.create({
            data: session,
        });

        return {
            token: createdSession.token,
            user: resultUser.data,
        }
    }
}

export default fp(
    async function (fastify: FastifyInstance){
        fastify.decorate('authService', new AuthService(fastify));
    }, 
    { name: 'auth-service', dependencies: ['prisma-plugin'] });

import fp from 'fastify-plugin';
import type { FastifyInstance, FastifyReply, FastifyRequest } from 'fastify';
import { TUserDTO } from '@/packages/schemas/src/user/user.dto';
import { thrower } from '@/errors/thrower';


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

    async signUp(args: TUserDTO['CreateUserInput']) {
        
        //Verificamos si ya existe un usuario con el mismo email
        const existingUser = await this.fastify.prisma.user.findUnique({
            where: { email: args.email },
        });

        if (existingUser) {
            //Si ya existe, lanzamos una excepción personalizada
            thrower.exception('user', 'email-taken', { email: args.email });
        }

        //Verificamos si ya existe un usuario con el mismo número de teléfono
        if (args.phoneNumber) {
            const existingPhoneUser = await this.fastify.prisma.user.findFirst({
                where: { 
                phoneNumber: {
                    equals: JSON.parse(JSON.stringify(args.phoneNumber))
                }
                },
            });

            if (existingPhoneUser) {
                thrower.exception('user', 'phone-taken', { phone: `${args.phoneNumber.areaCode}-${args.phoneNumber.number}` });
            }
        }
        //Se crea el usuario con prisma
        const user = await this.fastify.prisma.user.create({
            data: {
                ...args
            }});
        return user;
    }

//------------------------------------------------------------------------------------------------------------------------------------------

    async signIn(email: string, password: string) {
        const user = await this.fastify.prisma.user.findUnique({ where: { email } });
        if (!user || user.password !== password) {
        throw new Error('Invalid email or password');
        }
        // Aquí puedes generar y devolver un token JWT u otro mecanismo de autenticación
        return 'fake-jwt-token'; // Reemplaza con la lógica real de generación de tokens
    }
}

export default fp(
    async function (fastify: FastifyInstance){
        fastify.decorate('authService', new AuthService(fastify));
    }, 
    { name: 'auth-service', dependencies: ['prisma-plugin'] });

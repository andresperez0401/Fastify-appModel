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

    //Metodo para registrar un nuevo usuario, en este caso lo crea con prisma.
    async signUp(args: TUserDTO['CreateUserInput']) {
        
        //Creamos el user con prisma
        const user = await this.fastify.prisma.user.create({
            data: {
                ...args
            }});

        return user;
    }

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

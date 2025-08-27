import fp from 'fastify-plugin';
import type { FastifyInstance, FastifyReply, FastifyRequest } from 'fastify';
import {
    TUserDTO, UserDTO
}from '../../packages/schemas/src/user/user.dto';

//Le agregamos la propiedad authController al FastifyInstance
declare module 'fastify' {
  interface FastifyInstance {
    authController: AuthController;
  }
}

class AuthController {

    //Se agrega el Fastify como atributo de la clase, para que pueda acceder a otros servicios dentro de Fastify
    private fastify: FastifyInstance;

    //Constructor de la clase, se le inyectara la dependencia de Fastify
    constructor(fastify: FastifyInstance) {
        this.fastify = fastify;

        //Hay que bindear los metodos para que no pierdan el contexto
        this.signUp = this.signUp.bind(this);
        this.signIn = this.signIn.bind(this);
    }

//----------------------------------------------------------------------------------------------------------------------------------------------------------
// POST /auth/sign-up
//Funcion que se encarga de orquestar hacia el servicio para crear un usuario, y recibe desde las rutas.

    async signUp(

        //El request body pudiera ser ServerRequest en lugar de FastifyRequest
        request: FastifyRequest <{ Body: TUserDTO['CreateUserInput'] }>,
        reply: FastifyReply
    ) {
        //Llamamos al servicio para crear el usuario
        const user = await this.fastify.authService.signUp(request.body);
        return user;
    }

//----------------------------------------------------------------------------------------------------------------------------------------------------------



    async signIn(
        request: FastifyRequest <{ Body: { email: string; password: string } }>,
        reply: FastifyReply
    ) {
        const { email, password } = request.body;
        const token = await this.fastify.authService.signIn(email, password);
        return { token };
    }
}

export default fp(
    async function (fastify: FastifyInstance){
        fastify.decorate('authController', new AuthController(fastify));
    }, 
    { name: 'auth-controller', dependencies: ['auth-service'] });

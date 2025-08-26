import fp from 'fastify-plugin';
import type { FastifyInstance, FastifyReply, FastifyRequest } from 'fastify';
import {
    TUserDTO, UserDTO
}from '../../packages/schemas/src/user/user.dto';

declare module 'fastify' {
  interface FastifyInstance {
    authController: AuthController;
  }
}

class AuthController {

    private fastify: FastifyInstance;

    constructor(fastify: FastifyInstance) {
        this.fastify = fastify;

    //Hay que bindear para que no pieda el contexto
        this.signUp = this.signUp.bind(this);
        this.signIn = this.signIn.bind(this);
    }
  
    async signUp(
        //El request body pudiera ser ServerRequest en ves de FastifyRequest
        request: FastifyRequest <{ Body: TUserDTO['CreateUserInput'] }>,
        reply: FastifyReply
    ) {
        const user = await this.fastify.authService.signUp(request.body);
        return user;
    }


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

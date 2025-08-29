import fp from 'fastify-plugin';
import type { FastifyInstance, FastifyReply, FastifyRequest } from 'fastify';
import browserDetect from 'browser-detect';
import {
    TUserDTO, UserDTO
}from '../../packages/schemas/src/user/user.dto';
import { TAuthDTO, AuthDTO,  } from '@/packages/schemas/src/auth/auth.dto';

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
        this.checkEmail = this.checkEmail.bind(this);
        this.signIn = this.signIn.bind(this);
    }

//----------------------------------------------------------------------------------------------------------------------------------------------------------
// POST /auth/sign-up
//Funcion que se encarga de orquestar hacia el servicio para crear un usuario, y recibe desde las rutas.

    async signUp(

        //El request body pudiera ser ServerRequest en lugar de FastifyRequest
        request: FastifyRequest <{ Body: TAuthDTO['signUpInput'] }>,
        reply: FastifyReply
    ) {
        //Llamamos al servicio para crear el usuario
        const user = await this.fastify.authService.signUp(request.body);
        return user;
    }

//----------------------------------------------------------------------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//POST /auth/check-email
//Funcion que se encarga de validar si un email ya esta registrado en la base de datos

    async checkEmail(
        request: FastifyRequest <{ Body: TAuthDTO['emailInput'] }>,
        reply: FastifyReply
    ) {
        const exists = await this.fastify.authService.checkEmail(request.body);
        return { exists };
    }

//-----------------------------------------------------------------------------------------------------------------------------------------------------------


//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//POST /auth/sign-in

    async signIn(
        request: FastifyRequest <{ Body: TAuthDTO['logInInput'] }>,
        reply: FastifyReply
    ) {

        //Detectamos el navegador desde el user-agent
        const browser = browserDetect(request.headers['user-agent']);

        //Obtenemos la IP del request
        const ip = request.ip;

        const resp = await this.fastify.authService.signIn(request.body, browser, ip);

        return resp;
    }

//-----------------------------------------------------------------------------------------------------------------------------------------------------------
}

export default fp(
    async function (fastify: FastifyInstance){
        fastify.decorate('authController', new AuthController(fastify));
    }, 
    { name: 'auth-controller', dependencies: ['auth-service'] });

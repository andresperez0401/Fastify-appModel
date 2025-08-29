import fp from 'fastify-plugin';
import type { FastifyInstance } from 'fastify';
import { thrower } from '@/errors/thrower';
import { AuthDTO } from '@/packages/schemas/src/auth/auth.dto';


//Funcion que registra las rutas públics de Auth
async function registerAuthRoutes(fastify: FastifyInstance) {

//-------------------------------------------------------------------------------------------------------------------------------------------   
  //Ruta para el registro de un usuario
  fastify.post('/sign-up', {
  
    //Se le pasa el schema en el body, para que pueda tener la prevalidación con el middleware de Zod: Plugins/errors/middlewares
    config: {
        inputSchema: AuthDTO.signUpInput,
    },
    handler: fastify.authController.signUp,
  });

//-------------------------------------------------------------------------------------------------------------------------------------------


//-------------------------------------------------------------------------------------------------------------------------------------------
//Ruta para validar si un email de un usuario ya esta registrado en la base de datos 
fastify.post('/check-email', {

    config: {
      inputSchema: AuthDTO.emailInput,
    },
    handler: fastify.authController.checkEmail,
  });

//-------------------------------------------------------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------------------------------------
// Ruta para hacer Login en la aplicacion 
fastify.post('/sign-in', {

    config: {
        inputSchema: AuthDTO.logInInput,
        },
    handler: fastify.authController.signIn,
  });

//---------------------------------------------------------------------------------------------------------------------------

  //de prueba
  fastify.get('/all', async (request, reply) => {
    const users = await fastify.prisma.user.findMany();
    reply.send(users);
  });


  fastify.get('/test-error', async (request, reply) => {
    // Simulamos un error para probar el manejador de errores
     thrower.exception('user', 'not-found', { id: 123 });
  });

}

//Funcion para agregar las rutas al fastify instance
export default fp(
  async (fastify) => {
    await fastify.register(registerAuthRoutes, { prefix: 'auth' });
  },
  { name: 'auth-routes', dependencies: ['auth-controller'] }
);

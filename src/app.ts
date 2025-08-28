import type { Server } from 'node:http';
import path from 'path';
import Fastify, { fastify, type FastifyHttpOptions } from 'fastify';
import autoload from '@fastify/autoload';
import { handleError } from '@/plugins/errors/error-handler';

export async function createApp() {
  let config: FastifyHttpOptions<Server> = 
  {
  logger: {
    level: 'debug', // debug para desarrollo
    transport: {
      target: 'pino-pretty',
      options: {
        colorize: true,             // colores en la consola
        translateTime: 'HH:MM:ss',  // tiempo en formato legible
        ignore: 'pid,hostname',     // ignora campos que no quieres
        singleLine: true            // todo en una línea
      }
    }
  }
};

  const app = Fastify(config);

  //Manejo de errores con el handler en: plugins/errors
  app.setErrorHandler(handleError);
  

  // Register plugins
//   await app.register(autoload, {
//     dir: path.join(__dirname, 'plugins/middlewares'),
//   });


  //Carga de todos los plugins de integraciones, aca esta incluido Prisma
  await app.register(autoload, {
    dir: path.join(__dirname, 'plugins/integrations'),
  });


  //Carga de los plugins de errores
  await app.register(autoload, {
    dir: path.join(__dirname, 'plugins/errors' )
  });



  // Registro de las rutas
  await app.register(autoload, {
    dir: path.join(__dirname, 'plugins/routes'),
  });

  await app.ready();

  return app;
}
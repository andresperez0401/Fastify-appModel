import type { Server } from 'node:http';
import path from 'path';
import Fastify, { type FastifyHttpOptions } from 'fastify';
import autoload from '@fastify/autoload';

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
//   { logger: true };
  const app = Fastify(config);

  // Register plugins
//   await app.register(autoload, {
//     dir: path.join(__dirname, 'plugins/middlewares'),
//   });
  await app.register(autoload, {
    dir: path.join(__dirname, 'plugins/integrations'),
  });

  // Register Routes and Websockets
  await app.register(autoload, {
    dir: path.join(__dirname, 'plugins/routes'),
  });

  // Register error handlers
//   await app.register(autoload, {
//     dir: path.join(__dirname, 'plugins/errors'),
//   });

  await app.ready();

  return app;
}
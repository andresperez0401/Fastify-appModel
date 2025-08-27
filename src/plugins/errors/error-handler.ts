import type { FastifyReply, FastifyRequest } from 'fastify';
import { Exception } from '@/errors/exception';
import { errorsDictionary, errorRegistry } from '@/errors/dictionaries';
import { ZodError } from 'zod';


//Esta función reemplaza los placeholders en el mensaje con los valores reales
function injectParams(detail: string, params: Record<string, any>) {
  return Object.entries(params).reduce((acc, [key, value]) => {
    return acc.replace(`<${key}>`, String(value));
  }, detail);
}

const productionEnv = process.env.APP_ENV === 'production';

export function handleError(
  error: Error | Exception,
  _request: FastifyRequest,
  reply: FastifyReply
) {

  // 1) Zod → validation-error (400), para cuando usamos el schema.parse, checkee y retorne en caso de algun error 
if (error instanceof ZodError) {
  const e = errorsDictionary.internal['validation-error'];

  return reply.status(e.status).send({
    title: e.title,
    message: e.message.replace(
      '<message>',
      error.issues.map(i => `${i.path.join('.')}: ${i.message}`).join(' | ')
    ),
    status: e.status,
    code: e.code,


    //Por si se quiere manejar mejor como detalles
    // details: error.issues.map(i => ({
    //   field: i.path.join('.'),
    //   message: i.message,  // ← Aquí ya viene "firstName es requerido", "password mínimo 8 caracteres", etc.
    // })),
  });
}

  let title = 'Unhandled server error';
  let status = 500;
  let message = 'An unexpected error appeared';
  let type = 'default';
  let silent = false;

  if (error instanceof Exception) {
    silent = error.silent && productionEnv;
    const data = error.data;
    title = data.title;
    status = data.status;
    type = data.type;
    message = injectParams(data.message, error.params);
  }

  const genericError = errorRegistry.getError('internal', 'default' as any);
  const response = {
    title:   silent ? genericError.title   : title,
    message: silent ? genericError.message : message,
    status:  silent ? genericError.status  : status,
    type:     silent ? genericError.type    : type,
    code:     silent ? genericError.code    : (error instanceof Exception ? error.data.code : 'INTERNAL'),
  };

  reply.status(response.status).send(response);
  return reply;
}

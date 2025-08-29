import type { FastifyReply, FastifyRequest } from 'fastify';
import { Exception } from '@/errors/exception';
import { errorsDictionary, errorRegistry } from '@/errors/dictionaries';
import { ZodError } from 'zod';
import { de } from 'zod/v4/locales';


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

  let title = 'Unhandled server error';
  let status = 500;
  let message = 'An unexpected error appeared';
  let type = 'DEFAULT_ERROR';
  let silent = false;
  let details: unknown = undefined;

  if (error instanceof Exception) {
    silent = error.silent && productionEnv;
    const data = error.data;
    title = data.title;
    status = data.status;
    type = data.type;
    message = injectParams(data.message, error.params);
    if (error.params?.details) {
      details = error.params.details;
    }

  }

  const genericError = errorRegistry.getError('internal', 'default' as any);
  const response = {
    title:   silent ? genericError.title   : title,
    message: silent ? genericError.message : message,
    status:  silent ? genericError.status  : status,
    type:     silent ? genericError.type    : type,
    code:     silent ? genericError.code    : (error instanceof Exception ? error.data.code : 'INTERNAL'),
    ...(details ? { details } : {}),
  };

  reply.status(response.status).send(response);
}



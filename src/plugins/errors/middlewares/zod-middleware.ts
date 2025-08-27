import fp from 'fastify-plugin';
import type { FastifyInstance } from 'fastify';
import { ZodError, ZodObject } from 'zod';
import { thrower } from '@/errors/thrower';

export default fp(async (fastify: FastifyInstance) => {
  fastify.addHook('preValidation', async (req) => {
    const schema = (req.routeOptions.config as any)?.zodSchema;

    if (schema && schema instanceof ZodObject) {
      try {
        req.body = schema.parse(req.body);
      } catch (err) {
        if (err instanceof ZodError) {
          const details = err.issues.map(i => ({
            field: i.path.join('.'),
            message: i.message,
          }));

          thrower.exception('internal', 'validation-error', {
            message: details.map(d => `${d.field}: ${d.message}`).join('; ')
          });
        }
      }
    }
  });
});

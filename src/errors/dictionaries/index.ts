import { authErrors } from './auth';
import { userErrors } from './users';
import { internalErrors } from './internal';

export const errorsDictionary = {
  auth: authErrors,
  user: userErrors,
  internal: internalErrors
} as const;

// Tipado igual al del artículo
export const EntitiesObject = Object.freeze({
  auth: 'auth',
  user: 'user',
  internal: 'internal'
});
export type EntityType = keyof typeof EntitiesObject;

export type ErrorCodes<T extends EntityType> =
  keyof (typeof errorsDictionary)[T];

// Estructura estándar
export type StandardError = {
  status: number;
  type: string;
  code: string;
  title: string;
  message: string;
};

export const errorRegistry = {
  getError<T extends EntityType>(entity: T, code: ErrorCodes<T>) {
    const found = (errorsDictionary[entity] as any)?.[code];
    if (found) return found as StandardError;
    return internalErrors.default as StandardError; 
  },
};

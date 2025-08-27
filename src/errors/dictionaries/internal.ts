export const internalErrors = {
  default: {
    status: 500,
    type: 'INTERNAL_ERROR',
    code: 'INTERNAL_SERVER_ERROR',
    title: 'Error interno',
    message: 'Ocurrió un error inesperado. Por favor intente más tarde.',
  },
  'validation-error': {
    status: 400,
    type: 'VALIDATION_ERROR',
    code: 'VALIDATION_ERROR',
    title: 'Datos inválidos',
    message: 'La petición contiene datos inválidos: <message>.',
  },
  timeout: {
    status: 504,
    type: 'TIMEOUT_ERROR',
    code: 'TIMEOUT',
    title: 'Tiempo de espera excedido',
    message: 'El servidor tardó demasiado en responder.',
  },
} as const;

export const authErrors = {
  'login-required': {
    status: 401,
    type: 'AUTHENTICATION_ERROR',
    code: 'LOGIN_REQUIRED',
    title: 'Inicio de sesión requerido',
    message: 'Debes iniciar sesión para continuar.',
  },
  'invalid-credentials': {
    status: 401,
    type: 'AUTHENTICATION_ERROR',
    code: 'INVALID_CREDENTIALS',
    title: 'Credenciales inválidas',
    message: 'Email o contraseña incorrectos.',
  },
  forbidden: {
    status: 403,
    type: 'AUTHORIZATION_ERROR',
    code: 'FORBIDDEN',
    title: 'Acceso denegado',
    message: 'No tienes permisos para realizar esta acción.',
  },
  'token-expired': {
    status: 401,
    type: 'AUTHENTICATION_ERROR',
    code: 'TOKEN_EXPIRED',
    title: 'Token expirado',
    message: 'Tu sesión ha expirado. Por favor, inicia sesión nuevamente.',
  },
  'invalid-token': {
    status: 401,
    type: 'AUTHENTICATION_ERROR',
    code: 'INVALID_TOKEN',
    title: 'Token inválido',
    message: 'El token proporcionado no es válido.',
  },
  'internal-error': {
    status: 500,
    type: 'INTERNAL_ERROR',
    code: 'INTERNAL_SERVER_ERROR',
    title: 'Error interno',
    message: 'Ocurrió un error inesperado. Por favor intente más tarde.',
  },
} as const;

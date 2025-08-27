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
} as const;

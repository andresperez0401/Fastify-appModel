export const userErrors = {
  'not-found': {
    status: 404,
    type: 'NOT_FOUND_ERROR',
    code: 'USER_NOT_FOUND',
    title: 'Usuario no encontrado',
    message: 'El usuario que buscas no fue encontrado',
  },
  suspended: {
    status: 403,
    type: 'AUTHORIZATION_ERROR',
    code: 'SUSPENDED_USER',
    title: 'Usuario suspendido',
    message: 'Tu cuenta se encuentra suspendida',
  },
  'email-taken': {
    status: 409,
    type: 'CONFLICT_ERROR',
    code: 'EMAIL_TAKEN',
    title: 'Email ya registrado',
    message: 'El correo <email> ya está asociado a una cuenta',
  },
  'phone-taken': {
    status: 409,
    type: 'CONFLICT_ERROR',
    code: 'PHONE_TAKEN',
    title: 'Teléfono ya registrado',
    message: 'Este número de teléfono ya está asociado a una cuenta.',
  },
} as const;

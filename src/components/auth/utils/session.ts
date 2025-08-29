import jwt from "jsonwebtoken";
import { BrowserDetectInfo } from "@/types/browser";
import { getGeoLocationFromIP } from "@/utils/ip-location";
import { SessionDTO, SessionCreateInput,  JwtUserPayload} from "@/packages/schemas/src/user/session/session.schema";
import { TUserDTO } from "@/packages/schemas/src/user/user.dto";
import { thrower } from '@/errors/thrower';


export async function generateSession(
  user: TUserDTO['SessionUserInput'],
  browser: BrowserDetectInfo,
  ip: string
) {

  //Agregamos la informacion que queremos en el payload del token
  const tokenPayload: JwtUserPayload = {
    id: String(user.id),
    role: user.type,
    email: user.email,
  };

  //Firmamos el token con la libreria jsonwebtoken
  const token = jwt.sign(tokenPayload, process.env.SECRET!
    // , { expiresIn: "1d", // opcional}
  );

  //Obtenemos datos a partir de la IP
  const ipLocation = await getGeoLocationFromIP(ip);


  const session: SessionCreateInput = {
    token, 
    userId: String(user.id),

    //Agregamos el userType a la sesion para que no se tenga que repetir la clase session por cada middleware
    //La idea es tener un middleware de Admin y otro de User y que ambos registren en la session 
    userType: user.type,
    ip,
    device: {
      os: browser.os || 'unknown',
      browser: browser.name || 'unknown',
      name: browser.name || 'unknown',
      version: browser.version || 'unknown',
      isMobile: browser.mobile || false,
    },
    expirationDate: new Date(Date.now() + 744 * 60 * 60 * 1000),
    location: {
      city: ipLocation.city || '',
      countryCode: ipLocation.countryCode || '',
      regionCode: ipLocation.regionCode || '',
      continentCode: ipLocation.continentCode || '',
      timezone: ipLocation.timezone || '',
      countryLanguages: ipLocation.countryLanguages || ['en-US'],
    }
  };

  return session;
}

import { z } from "zod";
import { basicModelDefinition } from "../../utils/basicDefinition";

export const sessionDevice = z.object({
  os: z.string().max(100),
  browser: z.string().max(100),
  name: z.string().max(100).optional(),
  version: z.string().max(100).optional(),
  isMobile: z.boolean().default(false),
});
export type SessionDevice = z.infer<typeof sessionDevice>;

export const sessionLocation = z.object({
  city: z.string().max(255).optional(),
  countryCode: z.string().max(100).optional(),
  regionCode: z.string().max(100).optional(),
  continentCode: z.string().max(100).optional(),
  timezone: z.string().max(100).optional(),
  countryLanguages: z.array(z.string().max(100)).default(["en-US"]).optional(),
});
export type SessionLocation = z.infer<typeof sessionLocation>;

export const sessionDefinition = basicModelDefinition.extend({
  ip: z.string().max(45), 
  token: z.string().max(999),
  device: sessionDevice,
  expirationDate: z.date(),
  location: sessionLocation.optional(),
  userId: z.string(),
});

export const sessionCreateInput = sessionDefinition.omit({
  id: true,
  createdAt: true,
  updatedAt: true,
  active: true,
});

export type SessionDTO = z.infer<typeof sessionCreateInput>;


export type JwtUserPayload = {
  id: string;
  role: string;
  email: string;
};

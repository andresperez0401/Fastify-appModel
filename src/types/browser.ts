// export interface BrowserDetectInfo {
//   name?: string;
//   version?: string;
//   versionNumber?: number;
//   mobile?: boolean;
//   os?: string;
// }

export interface BrowserDetectInfo {
  name?: string;
  version?: string;
  versionNumber?: number;
  mobile?: boolean;
  os?: string;
  browser?: string;   // 👈 opcional, por compatibilidad con session
  isMobile?: boolean; // 👈 opcional, por compatibilidad con session
}
import { ThemeColorProps } from "../types/BasicTypes";

interface CustomWindow extends Window {
  invokeNative?: unknown;
}

// Will return whether the current environment is in a regular browser
// and not CEF
export const isEnvBrowser = (): boolean =>
  !(window as CustomWindow).invokeNative;

// Basic no operation function
export const noop = (): void => {};

export function debugLog(error: any, functionName?: string) {
  const now = new Date();
  const timestamp = now.toISOString();
  const errorMessage = error.message || "No Message.";
  const errorStack = error.stack || "No Stack.";

  const logMessage = `
    Info: ${functionName ?? "?"},
    Time: ${timestamp}
    Error Message: ${errorMessage}
    Error Stack Trace: ${errorStack}
    Error: ${error}
  `;
  console.error(logMessage);
}

export function whichColor(key: ThemeColorProps, type: string): string {
  switch (key) {
    case "_orange":
      switch (type) {
        case "text":
          return "!text-fOrange";
        case "background-linear":
          return "bg-fOrange-linear !important";
        case "background":
          return "bg-fOrange";
        case "hover:background":
          return "hover:bg-fOrange";
        case "drop-shadow":
          return "drop-shadow-[0_0_3px]";
        case "border":
          return "border-fOrange";
        case "hover:border":
          return "hover:border-fOrange";
        case "fill":
          return "fill-fOrange";
        case "stroke":
          return "stroke-fOrange";
        case "shadow":
          return "shadow-fOrange/95";
        default:
          return "text-fOrange";
      }
    case "_green":
      switch (type) {
        case "text":
          return "!text-fGreen";
        case "background-linear":
          return "bg-fGreen-linear !important";
        case "background":
          return "bg-fGreen";
        case "hover:background":
          return "hover:bg-fGreen";
        case "drop-shadow":
          return "drop-shadow-[0_0_3px]";
        case "border":
          return "border-fGreen";
        case "hover:border":
          return "hover:border-fGreen";
        case "fill":
          return "fill-fGreen";
        case "stroke":
          return "stroke-fGreen";
        case "shadow":
          return "shadow-fGreen/95";
        default:
          return "text-fGreen";
      }
    case "_red":
      switch (type) {
        case "text":
          return "!text-fRed";
        case "background-linear":
          return "bg-fRed-linear !important";
        case "background":
          return "bg-fRed";
        case "hover:background":
          return "hover:bg-fRed";
        case "drop-shadow":
          return "drop-shadow-[0_0_3px]";
        case "border":
          return "border-fRed";
        case "hover:border":
          return "hover:border-fRed";
        case "fill":
          return "fill-fRed";
        case "stroke":
          return "stroke-fRed";
        case "shadow":
          return "shadow-fRed/95";
        default:
          return "text-fRed";
      }
    case "_blue":
      switch (type) {
        case "text":
          return "!text-fBlue";
        case "background-linear":
          return "bg-fBlue-linear !important";
        case "background":
          return "bg-fBlue";
        case "hover:background":
          return "hover:bg-fBlue";
        case "drop-shadow":
          return "drop-shadow-[0_0_3px]";
        case "border":
          return "border-fBlue";
        case "hover:border":
          return "hover:border-fBlue";
        case "fill":
          return "fill-fBlue";
        case "stroke":
          return "stroke-fBlue";
        case "shadow":
          return "shadow-fBlue/95";
        default:
          return "text-fBlue";
      }
    case "_444":
      switch (type) {
        case "text":
          return "!text-[#444]";
        case "background-linear":
          return "bg-444-linear !important";
        case "background":
          return "bg-[#444]";
        case "hover:background":
          return "hover:bg-[#444]";
        case "drop-shadow":
          return "drop-shadow-[0_0_3px]";
        case "border":
          return "border-[#444]";
        case "hover:border":
          return "hover:border-[#444]";
        case "fill":
          return "fill-[#444]";
        case "stroke":
          return "stroke-[#444]";
        default:
          return "text-[#444]";
      }
    case "_181818":
      switch (type) {
        case "text":
          return "!text-[#181818]";
        case "background-linear":
          return "bg-181818-linear !important";
        case "background":
          return "bg-[#181818]";
        case "hover:background":
          return "hover:bg-[#181818]";
        case "drop-shadow":
          return "drop-shadow-[0_0_3px]";
        case "border":
          return "border-[#181818]";
        case "hover:border":
          return "hover:border-[#181818]";
        case "fill":
          return "fill-[#181818]";
        case "stroke":
          return "stroke-[#181818]";
        default:
          return "text-[#181818]";
      }
    default:
      return "text-fOrange";
  }
}

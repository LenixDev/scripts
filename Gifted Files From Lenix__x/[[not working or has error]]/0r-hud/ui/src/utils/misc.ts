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

export const inheritColor = {
  gray: "bg-gray-700",
  green: "bg-green-700",
  blue: "bg-blue-950",
  orange: "bg-orange_bar",
  cyan: "bg-cyan_bar",
  red: "bg-red_bar",
  zinc: "bg-zinc-300",
  black: "bg-black",
  yellow: "bg-yellow-500",
  amber: "bg-amber-500",
  lime: "bg-lime_bar",
  emerald: "bg-emerald-600",
  purple: "bg-purple-600",
};

import plugin from "tailwindcss/plugin";

/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  darkMode: "class",
  theme: {
    extend: {
      fontFamily: {
        Roboto: "Roboto Mono",
      },
      textShadow: {
        sm: "0 2px 20px var(--tw-shadow-color)",
        DEFAULT: "0 2px 12px var(--tw-shadow-color)",
        lg: "0 8px 16px var(--tw-shadow-color)",
      },
      transitionProperty: {
        width: "width",
        height: "height",
      },
      textColor: {
        x_green: "#05483A",
      },
      colors: {
        orange_bar:"#FF9900",
        cyan_bar:"#00C2FF",
        lime_bar:"#C4FF48",
        red_bar:"#CF4E5B",
        settings_green: "#76FF9C",
        settings_gray: "rgba(146, 146, 146)",
        settings: "rgba(18, 18, 18)",
        setting: "#212121",
      },
    },
  },
  plugins: [
    plugin(function ({ matchUtilities, theme }) {
      matchUtilities(
        {
          "text-shadow": (value) => ({
            textShadow: value,
          }),
        },
        { values: theme("textShadow") }
      );
    }),
  ],
};

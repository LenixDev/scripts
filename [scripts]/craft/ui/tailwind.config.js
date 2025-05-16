/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  darkMode: "class",
  theme: {
    extend: {
      fontFamily: {
        Akira: "Akira Expanded",
      },
      colors: {
        fOrange: "#E39434",
        fGreen: "#34E365",
        fBlue: "#34A4E3",
        fRed: "#E34934",
      },
    },
  },
  plugins: [],
};

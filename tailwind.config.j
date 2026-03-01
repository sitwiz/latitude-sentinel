/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      colors: {
        'latitude-blue': '#0052FF',
        'solana-green': '#14F195',
        'dark-bg': '#0B0E11',
      },
    },
  },
  plugins: [],
}

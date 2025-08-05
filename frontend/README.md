# React + TypeScript + Vite

Esta plantilla proporciona una configuración mínima para que React funcione en Vite con HMR y algunas reglas de ESLint.

Actualmente, dos plugins oficiales están disponibles:

- [@vitejs/plugin-react](https://github.com/vitejs/vite-plugin-react/blob/main/packages/plugin-react/README.md) usa [Babel](https://babeljs.io/) para Fast Refresh
- [@vitejs/plugin-react-swc](https://github.com/vitejs/vite-plugin-react-swc) usa [SWC](https://swc.rs/) para Fast Refresh

## Expandiendo la configuración de ESLint

Si estás desarrollando una aplicación de producción, recomendamos actualizar la configuración para habilitar reglas de lint conscientes del tipo:

```js
export default tseslint.config({
  extends: [
    // Elimina ...tseslint.configs.recommended y reemplaza con esto
    ...tseslint.configs.recommendedTypeChecked,
    // Alternativamente, usa esto para reglas más estrictas
    ...tseslint.configs.strictTypeChecked,
    // Opcionalmente, agrega esto para reglas estilísticas
    ...tseslint.configs.stylisticTypeChecked,
  ],
  languageOptions: {
    // otras opciones...
    parserOptions: {
      project: ['./tsconfig.node.json', './tsconfig.app.json'],
      tsconfigRootDir: import.meta.dirname,
    },
  },
})
```

También puedes instalar [eslint-plugin-react-x](https://github.com/Rel1cx/eslint-react/tree/main/packages/plugins/eslint-plugin-react-x) y [eslint-plugin-react-dom](https://github.com/Rel1cx/eslint-react/tree/main/packages/plugins/eslint-plugin-react-dom) para reglas de lint específicas de React:

```js
// eslint.config.js
import reactX from 'eslint-plugin-react-x'
import reactDom from 'eslint-plugin-react-dom'

export default tseslint.config({
  plugins: {
    // Agrega los plugins react-x y react-dom
    'react-x': reactX,
    'react-dom': reactDom,
  },
  rules: {
    // otras reglas...
    // Habilita sus reglas typescript recomendadas
    ...reactX.configs['recommended-typescript'].rules,
    ...reactDom.configs.recommended.rules,
  },
})
```

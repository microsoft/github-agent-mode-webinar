# Construcción y Pruebas de la Aplicación OctoCAT Supply Chain

Esta guía proporciona instrucciones para construir, ejecutar y probar la aplicación de Gestión de Cadena de Suministro OctoCAT, que consiste en un componente API y un Frontend React.

## Prerrequisitos

- Node.js (versión 18 o superior)
- npm (se recomienda la última versión)
- Docker/Podman (opcional, para containerización)

### Prerrequisitos adicionales para la API Python

- Python 3.12 (o posterior)

### Prerrequisitos adicionales para la API Java

 - Java 23 (o posterior)
 - Maven

## Instalación

1. Clona el repositorio
2. Instala las dependencias:
   ```bash
   npm install
   ```

## Construcción de la Aplicación

### Usando Comandos npm

Puedes construir toda la aplicación o sus componentes individuales usando los siguientes comandos npm:

```bash
# Construir tanto los componentes API como Frontend
npm run build

# Construir solo el componente API
npm run build --workspace=api

# Construir solo el componente Frontend
npm run build --workspace=frontend
```

### Usando Tareas de VS Code

Las tareas de VS Code han sido configuradas para agilizar el proceso de construcción:

1. Presiona `Ctrl+Shift+P` (o `Cmd+Shift+P` en macOS) para abrir la Paleta de Comandos
2. Escribe `Tasks: Run Task` y selecciónalo
3. Elige una de las siguientes tareas:
   - `Build All`: Construye tanto los componentes API como Frontend
   - `Build API`: Construye solo el componente API
   - `Build Frontend`: Construye solo el componente Frontend

Alternativamente, puedes presionar `Ctrl+Shift+B` (o `Cmd+Shift+B` en macOS) para ejecutar la tarea de construcción predeterminada (`Build All`).

## Ejecutar la Aplicación

### Usando Comandos npm

```bash
# Iniciar tanto API como Frontend en modo desarrollo con recarga automática
npm run dev

# Iniciar solo la API en modo desarrollo
npm run dev:api

# Iniciar solo el Frontend en modo desarrollo
npm run dev:frontend

# Iniciar la aplicación en modo producción (ejecuta start:install en el workspace de la API)
npm run start
```

### Usando el Depurador de VS Code

1. Abre el panel de Debug (`Ctrl+Shift+D` o `Cmd+Shift+D` en macOS)
2. Selecciona `Start API & Frontend` del menú desplegable
3. Haz clic en el botón de reproducción verde o presiona F5

Esto iniciará tanto la API como el Frontend en modo desarrollo con el terminal integrado, permitiéndote ver la salida de la consola.

## Probar la Aplicación

### Ejecutar Pruebas

```bash
# Ejecutar todas las pruebas en todos los workspaces
npm run test

# Ejecutar pruebas para un workspace específico
npm run test --workspace=api
```

### Linting

```bash
# Ejecutar verificaciones de linting en el código del Frontend
npm run lint
```

## Información Adicional

### Configuración de Puertos

La API se ejecuta en el puerto 3000 por defecto, y el Frontend se ejecuta en el puerto 5137. Cuando se ejecuta en un entorno de Codespace, asegúrate de que la visibilidad del puerto de la API esté configurada como `public` para evitar errores de CORS cuando el Frontend trate de comunicarse con la API.

### Despliegue con Docker

El proyecto incluye Dockerfiles para ambos componentes API y Frontend y un archivo docker-compose.yml para un fácil despliegue containerizado:

```bash
# Construir e iniciar usando Docker Compose
docker-compose up --build
```
# Guía para subir tu proyecto a GitHub

El error que recibiste (`El término 'git' no se reconoce...`) indica que **Git no está instalado** en tu computadora. Sigue estos pasos para solucionarlo:

## Paso 1: Instalar Git
1.  Descarga Git desde aquí: [https://git-scm.com/download/win](https://git-scm.com/download/win)
2.  Instálalo dejando todas las opciones por defecto (Next, Next, Next...).
3.  **IMPORTANTE:** Una vez termine la instalación, **cierra completamente Visual Studio Code** y vuélvelo a abrir. Esto es necesario para que reconozca el nuevo comando.

## Paso 2: Subir el código
Una vez reabierto VS Code, abre una **Nueva Terminal** (Menú `Terminal` > `New Terminal`) y asegúrate de estar en la carpeta del proyecto (`ecommerce-db-m3`).

Copia y pega estos comandos uno por uno (o en bloque):

```powershell
# 1. Configura tu identidad (necesario si es tu primera vez usando Git)
# Cambia "Tu Nombre" y el correo por los tuyos reales
git config --global user.name "Tu Nombre"
git config --global user.email "tu_correo@ejemplo.com"

# 2. Inicia el repositorio local
git init

# 3. Prepara todos los archivos para subir
git add .

# 4. Guarda los cambios (Commit)
git commit -m "Primer commit: Estructura inicial del proyecto"

# 5. Renombra la rama principal a 'main'
git branch -M main

# 6. Conecta tu carpeta con el repositorio que creaste en GitHub
git remote add origin https://github.com/ceroblade/ecommerce-db-m3

# 7. Sube los archivos a la nube
git push -u origin main
```

Si al hacer el último paso (`git push`) te pide iniciar sesión, sigue las instrucciones que aparezcan en la ventana emergente del navegador.

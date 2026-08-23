# Datitos — Diversidad de recursos para compartir

## Qué es
Un newsletter semanal con recursos útiles que nos dieron resultado: apps, artículos, servicios, libros y más. Publicado todos los viernes a las 18:00.

## URLs
- **Producción**: `https://datitos.com.ar/` (pendiente de configurar DNS)
- **GitHub Pages (temporal)**: `https://diegap.github.io/datitos/`

## Stack
- **Hugo** (estático, rápido)
- **GitHub Pages** (hosting gratuito)
- **GitHub Actions** (deploy automático)
- **Tally** (formulario de envío)
- **Google Sheets** (recolección de respuestas)

## Estructura
```
├── content/
│   ├── _index.md              # Home
│   ├── issues/                # Publicaciones semanales
│   │   ├── _index.md
│   │   └── 001.md
│   ├── enviar/
│   │   └── _index.md          # Formulario Tally embebido
│   └── archivo.md             # Archivo de todas las publicaciones
├── layouts/
│   ├── _default/
│   │   ├── baseof.html        # Shell HTML base
│   │   ├── list.html          # Home (últimas publicaciones)
│   │   ├── single.html        # Publicación individual
│   │   └── archive.html       # Archivo completo
│   ├── enviar.html            # Layout del formulario
│   └── partials/
│       ├── head.html          # Meta tags, CSS
│       ├── header.html        # Navegación
│       └── footer.html        # Pie de página
├── static/
│   └── css/style.css          # Design system
├── .github/workflows/
│   └── deploy.yml             # CI/CD a GitHub Pages
└── hugo.toml                  # Configuración
```

## Design System
- **Paleta**: off-white `#F5F0EB`, texto `#2D2A26`, acento `#6B8FA3`, cards `#EDE8E2`, bordes `#D4CEC7`
- **Dark mode**: `prefers-color-scheme`
- **Font**: Atkinson Hyperlegible (Braille Institute)
- **Body**: 18px, line-height 1.7, max-width 640px
- **Sin animaciones**, respetar `prefers-reduced-motion`

## Tags (Categorías)
- 💬 Comunicación
- 📱 Apps
- 🛠️ Herramientas
- 📄 Artículos
- 👥 Servicios
- 📚 Libros
- 🎧 Podcasts
- 🎓 Educación
- 🏠 Vida diaria
- 💭 Emociones
- 🤝 Comunidad

## Formulario Tally
- **ID**: `LZ4eQz`
- **URL**: https://tally.so/r/LZ4eQz
- **Campos**:
  1. Nombre del recurso (requerido)
  2. Link al recurso (requerido)
  3. Para qué lo usás y resultados (requerido)
  4. Categoría (requerido)
  5. Nombre/contacto (opcional)

## Workflow de curación
1. La comunidad envía recursos via Tally
2. Las respuestas llegan a Google Sheets
3. Vos revisás y curás los mejores recursos
4. Creás un issue nuevo en `content/issues/XXX.md`
5. Hacés push a `main`
6. GitHub Actions deploya automáticamente a GitHub Pages

## Desarrollo local
```bash
# Instalar Hugo (si no está)
brew install hugo

# Ejecutar servidor de desarrollo
hugo server -D

# Abrir http://localhost:1313
```

## Deploy
El sitio se deploya automáticamente a GitHub Pages cada vez que hacés push a `main`.

## Próximos pasos
1. ~~Crear repositorio en GitHub~~
2. ~~Push inicial del proyecto~~
3. Habilitar GitHub Pages en el repo
4. Verificar que el sitio funcione en la URL pública
5. Probar el formulario Tally completo
6. Cuando el MVP esté pulido, configurar DNS de `datitos.com.ar`

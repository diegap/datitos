# AGENTS.md — Contexto del Proyecto

## Qué es esto
**Datitos** — Diversidad de recursos para compartir. Un newsletter semanal con recursos prácticos para personas neurodivergentes y sus familias, publicado como sitio web estático en GitHub Pages. Los recursos son compartidos por la comunidad (familias, amigos, profesionales) y curados semanalmente.

## Dominio
- **Producción**: `https://datitos.com.ar/` (domain ya registrado, DNS pendiente de configurar)
- **GitHub Pages (temporal)**: `https://diegap.github.io/datitos/`
- **Repositorio**: `diegap/datitos`

## Stack
- **Framework**: Hugo (binario único, sin dependencias)
- **Hosting**: GitHub Pages
- **CI/CD**: GitHub Actions
- **Formulario**: Tally (iframe embed)
- **CSS**: Custom properties, design system propio
- **Sin framework CSS externo** — todo manual para control total
- **Template language**: Go templates (Hugo nativo)

## Design System (no negociable)
- **Paleta**: off-white `#F5F0EB`, texto `#2D2A26`, acento muted `#6B8FA3`, cards `#EDE8E2`, bordes `#D4CEC7`
- **Dark mode**: vía `prefers-color-scheme`
- **Font**: Atkinson Hyperlegible (Braille Institute), fallback `system-ui`
- **Body**: 18px, line-height 1.7, max-width 640px
- **Sin animaciones**, sin auto-play, respetar `prefers-reduced-motion`
- **Espaciado generoso**, bloques de texto cortos, mismo orden de secciones siempre

## Formato del Issue
Cada issue tiene la misma estructura (regla de oro — irreversible):
- **Título**: Nombre descriptivo del issue (ej: "Recursos de comunicación alternativa")
- **Recursos**: Lista de recursos curados, cada uno con:
  - Nombre
  - URL
  - Descripción
  - Tags (categorías)
  - Imagen (link externo, opcional)
- **Tags**: Categorías para agrupar recursos (ver lista completa abajo)

Estructura de cada recurso:
```yaml
- name: "ARASAAC"
  url: "https://arasaac.org"
  description: "Portal Aragonés de Comunicación Augmentativa y Alternativa con pictogramas gratuitos"
  tags: ["comunicación", "herramientas", "educación"]
  image: "https://..." # link externo, opcional
```

## Schedule
- **Frecuencia**: Semanal
- **Día y hora**: Viernes a las 18:00
- **En la home**: "Una nueva publicación el próximo viernes a las 18:00"

## Distribución (MVP)
- **Sin RSS** para MVP
- **Sin email subscription** para MVP
- **Sin automatización de redes sociales** para MVP
- **Predicción en home**: día y hora de la próxima publicación
- **Formulario de contenido**: Tally embebido en `/enviar/`

## Tags (Categorías)
- **Comunicación**: Pictogramas, AAC, lenguaje
- **Apps**: Aplicaciones móviles o web
- **Herramientas**: Agendas visuales, organizadores
- **Artículos**: Blog posts, guías, tutoriales
- **Servicios**: Terapia, diagnóstico, apoyo
- **Libros**: Libros, ebooks
- **Podcasts**: Podcasts, audios
- **Educación**: Recursos escolares, materiales
- **Vida diaria**: Rutinas, autonomía, hogar
- **Emociones**: Bienestar, regulación emocional
- **Comunidad**: Grupos, foros, eventos

## Formulario (Tally)
- **Propósito**: Recolección de recursos sugeridos por la comunidad
- **Campos**:
  - Nombre del recurso (texto, obligatorio)
  - URL del recurso (URL, obligatorio)
  - Descripción (textarea, obligatorio)
  - Categoría (dropdown multi-select, obligatorio)
  - Imagen (link externo, opcional)
  - Nombre del remitente (texto, opcional)
  - Relación (dropdown: familiar, amigo, profesional, neurodivergente, opcional)
- **Límite**: Ilimitado (gratis en Tally)
- **Integración**: Google Sheets vía Tally
- **Acceso**: Botón "Enviar contenido" en home + link en cada issue

## Idioma
- **MVP**: Español
- **Futuro**: Bilingüe (EN/ES)

## Precauciones de Privacidad
- **Servicios**: Al compartir nombres de profesionales/lugares, obtener consentimiento explícito
- **Datos de contacto**: No compartir datos personales sin autorización
- **Recomendación**: Enviar enlace al sitio/web del profesional, no datos directos
- **Moderación**: Revisar cada recurso antes de publicar

## Estructura del Proyecto
```
datitos/
├── content/
│   ├── _index.md          # Home page
│   ├── issues/
│   │   └── 001.md         # Cada issue
│   └── enviar/
│       └── _index.md      # Página del formulario
├── layouts/
│   ├── _default/
│   │   ├── baseof.html    # Shell HTML base
│   │   ├── list.html      # Listado (home, archivo)
│   │   └── single.html    # Página individual (issue)
│   └── partials/
│       ├── head.html
│       ├── header.html
│       └── footer.html
├── static/
│   └── css/
│       └── style.css
├── hugo.toml              # Configuración de Hugo
└── .github/
    └── workflows/
        └── deploy.yml
```

## Decisiones Clave
1. **Formato one-pager**: Regla de oro, irreversible
2. **Sin frameworks CSS**: Control total sobre el design system
3. **Hugo sobre Eleventy**: Binario único, sin dependencias de Node.js, más rápido, más comunidad (89k stars vs 19k), themes listos para usar
4. **Tally sobre Google Forms**: Mejor diseño, iframe más limpio
5. **Viernes 18:00**: Predictibilidad para audiencia neurodivergente
6. **Sin RSS/email MVP**: Simplificar, agregar después si es necesario
7. **Recursos curados por comunidad**: Contenido valioso y práctico, no entretenimiento
8. **Reusar dominio existente**: `datitos.com.ar` ya registrado, pendiente de configurar DNS cuando el MVP esté pulido

## Patrones Observados en la Comunidad
- Celebrar cambios de mes/temporada (comportamiento de ritual/comfort)
- Interés en aprendizaje de idiomas (pero no universal — impulsado por hiperfijación)
- Lenguaje preferido: "neurodivergente" (no "neurodiverso/a")
- "Neurospicy" se usa pero no es válido para branding

#!/bin/bash
# fetch-og-images.sh
# Extrae og:image de cada resource y lo guarda en el frontmatter.
# Solo procesa resources que NO tengan campo image: ya definido.

set -uo pipefail

RESOURCES_DIR="content/resources"
FOUND=0
SKIPPED=0
FAILED=0

for file in "$RESOURCES_DIR"/*.md; do
  [ -f "$file" ] || continue

  # Si ya tiene image:, skip
  if grep -q "^image:" "$file" 2>/dev/null; then
    SKIPPED=$((SKIPPED + 1))
    continue
  fi

  # Extraer params.link del frontmatter
  link=$(grep "link:" "$file" | sed 's/.*"\(.*\)".*/\1/' | head -1)

  if [ -z "$link" ]; then
    echo "⚠  Sin link: $(basename "$file")"
    SKIPPED=$((SKIPPED + 1))
    continue
  fi

  name=$(grep "^title:" "$file" | head -1 | sed 's/.*"\(.*\)".*/\1/')
  echo -n "🔍 $name ... "

  # Fetch la página (timeout 5s total, 3s connect)
  http_code=$(curl -sL -o /tmp/og_fetch.html --max-time 5 --connect-timeout 3 -w "%{http_code}" -A "Mozilla/5.0 (compatible; DatitosBot/1.0)" "$link" 2>/dev/null) || http_code="000"

  if [ "$http_code" = "000" ] || [ "$http_code" -ge 400 ] 2>/dev/null; then
    echo "⚠  HTTP $http_code (skipped)"
    FAILED=$((FAILED + 1))
    continue
  fi

  html=$(cat /tmp/og_fetch.html 2>/dev/null || echo "")

  if [ -z "$html" ]; then
    echo "⚠  respuesta vacía"
    FAILED=$((FAILED + 1))
    continue
  fi

  # Extraer og:image (varios patrones) - suprimir errores de grep
  og_image=$(echo "$html" | grep -oE 'property="og:image"[[:space:]]+content="[^"]*"' | head -1 | sed 's/.*content="\([^"]*\)".*/\1/' || true)
  if [ -z "$og_image" ]; then
    og_image=$(echo "$html" | grep -oE 'content="[^"]*"[[:space:]]+property="og:image"' | head -1 | sed 's/.*content="\([^"]*\)".*/\1/' || true)
  fi
  if [ -z "$og_image" ]; then
    og_image=$(echo "$html" | grep -oE 'name="twitter:image"[[:space:]]+content="[^"]*"' | head -1 | sed 's/.*content="\([^"]*\)".*/\1/' || true)
  fi
  if [ -z "$og_image" ]; then
    og_image=$(echo "$html" | grep -oE 'content="[^"]*"[[:space:]]+name="twitter:image"' | head -1 | sed 's/.*content="\([^"]*\)".*/\1/' || true)
  fi
  if [ -z "$og_image" ]; then
    og_image=$(echo "$html" | grep -oE '<meta[^>]+property="og:image"[^>]+>' | head -1 | grep -oE 'content="[^"]*"' | sed 's/content="\([^"]*\)"/\1/' || true)
  fi

  if [ -z "$og_image" ]; then
    echo "⚠  sin og:image"
    FAILED=$((FAILED + 1))
    continue
  fi

  # Normalizar URL relativa a absoluta
  if echo "$og_image" | grep -qE '^/'; then
    base=$(echo "$link" | sed -E 's|(https?://[^/]+).*|\1|')
    og_image="${base}${og_image}"
  fi

  # Agregar image: después de la línea de tags:
  awk -v img="$og_image" '
    /^tags:/ && !done {
      print
      printf "image: \"%s\"\n", img
      done=1
      next
    }
    { print }
  ' "$file" > "$file.tmp" && mv "$file.tmp" "$file"

  echo "✅"
  FOUND=$((FOUND + 1))
done

rm -f /tmp/og_fetch.html
echo ""
echo "📊 Resultado: $FOUND encontradas, $SKIPPED ya tenían imagen, $FAILED fallaron"

#!/usr/bin/env bash
# Compila a PDF todos los documentos Typst del repositorio:
#   * entrega-*/*.typ   (documentos de cada entrega)
#   * templates/starter-*.typ   (ejemplos de las plantillas)
# Solo compila los ficheros que son documentos (los que tienen un `#show:` o
# un `#title-slide(` a nivel superior); los módulos auxiliares como
# comun.typ se saltan.
# Uso, desde cualquier sitio:  templates/compilar-todo.sh
set -euo pipefail
cd "$(dirname "$(realpath "$0")")/.."
status=0
for f in entrega-*/*.typ templates/starter-*.typ; do
  [ -e "$f" ] || continue
  grep -qE '^#(show:|title-slide\()' "$f" || continue
  echo "→ $f"
  if ! typst compile --root . --font-path templates/fonts "$f"; then
    echo "✗ Error al compilar $f" >&2
    status=1
  fi
done
exit $status

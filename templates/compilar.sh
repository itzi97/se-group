#!/usr/bin/env bash
# Compila un documento Typst con la plantilla de Neuranet.
# Uso (desde cualquier sitio):  templates/compilar.sh entrega-1/documento.typ [watch]
# Usa la raíz del repositorio como --root (para los imports "/templates/...")
# y las fuentes incluidas en templates/fonts (no hace falta instalarlas).
set -euo pipefail
[ $# -ge 1 ] || { echo "Uso: templates/compilar.sh ruta/al/documento.typ [watch]"; exit 1; }
doc="$(realpath "$1")"
cd "$(dirname "$(realpath "$0")")/.."
cmd=compile; [ "${2:-}" = "watch" ] && cmd=watch
exec typst "$cmd" --root . --font-path templates/fonts "$doc"

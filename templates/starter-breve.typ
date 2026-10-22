// ============================================================
//  Neuranet — DOCUMENTO BREVE (sin portada, cabecera compacta)
//
//  Para documentos de 1–5 páginas: nota técnica, presupuesto,
//  resumen ejecutivo…  Para actas de reunión usa starter-acta.typ.
//  1. Copia este fichero a la carpeta de la entrega (p. ej. entrega-1/).
//  2. Rellena los campos de abajo y escribe.
//  3. Compila desde la raíz del repositorio:
//       ./templates/compilar.sh entrega-1/nota.typ
// ============================================================

#import "/templates/lib.typ": *

#show: neuranet-breve.with(
  doc-type: [Nota técnica],
  title: [Título del documento],
  client: [Nombre del cliente],
  project: [AñadaMaster],
  reference: "NN-AM-NT-01",
  version: "1.0",
  date: "22 de octubre de 2026",
  author: "Nombre 1 · Nombre 2",
  contents: true,                        // índice corto bajo la cabecera
)

= Primer apartado
Escribe aquí el contenido.

#important[Un recuadro destacado.]

= Segundo apartado
== Un subapartado
Más contenido.

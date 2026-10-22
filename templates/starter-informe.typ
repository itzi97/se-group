// ============================================================
//  Neuranet — INFORME para cliente (portada + índice + capítulos)
//
//  Para documentos largos: propuesta técnica, especificación de
//  requisitos, documento de arquitectura, informe de TCO…
//  1. Copia este fichero a la carpeta de la entrega (p. ej. entrega-1/).
//  2. Rellena los campos de abajo y escribe.
//  3. Compila desde la raíz del repositorio:
//       ./templates/compilar.sh entrega-1/documento.typ
// ============================================================

#import "/templates/lib.typ": *

#show: neuranet-doc.with(
  doc-type: [Propuesta técnica],         // tipo de documento (encima del título)
  title: [Título del documento],
  subtitle: [Subtítulo opcional],        // bórralo si no hace falta
  client: [Nombre del cliente],          // «Preparado para»
  project: [AñadaMaster],
  reference: "NN-AM-001",
  version: "1.0",
  status: [Borrador],                    // Borrador | En revisión | Final
  date: "22 de octubre de 2026",
  author: "Nombre 1 · Nombre 2 · Nombre 3 · Nombre 4",
  short-title: [Título corto],           // cabecera de cada página
  confidential: true,
  chapter-break: true,                   // false = los capítulos siguen en la misma página
)

// Índice y control de versiones en la misma página
#outline(title: [Índice])
#v(1.2cm)
#version-history(
  ("1.0", "22/10/2026", "Nombre 1", [Primera versión.]),
)
#pagebreak()

= Primer capítulo
== Un apartado
Escribe aquí el contenido.

#note[Un recuadro de nota.]

#neuranet-table(
  columns: (auto, 1fr),
  header: ([Columna 1], [Columna 2]),
  [Dato], [Descripción],
  [Dato], [Descripción],
)

== Organigrama de ejemplo
#figure(
  orgchart(
    org-node([Rol principal], style: "root",
      org-node([Rol A]),
      org-node([Rol B], style: "highlight"),
      org-node([Rol C])),
  ),
  caption: [Organigrama (sustituye los roles por los vuestros).],
)

// ---- Componentes disponibles ------------------------------------------
//   note[...]  /  callout(..., title: ...)  /  important[...]
//   neuranet-table(columns: 2, header: (...), ...filas)
//   version-history(("1.1", "fecha", "autor", [cambios]), ...)
//   orgchart(org-node("Raíz", org-node("Hijo", style: "highlight")))
//   timeline(total-days: 12, labels: (...), rows: (...), links: ((0,1),))   // Gantt
//   evolution-chain(("v1","Etiqueta","start"), ...)
//   Bloques de código ```lang ... ``` con números de línea automáticos
//
// ---- Anexos: numeración con letras (dos líneas sueltas) --------------
// #counter(heading).update(0)
// #set heading(numbering: "A.1")
// = Actas de reuniones

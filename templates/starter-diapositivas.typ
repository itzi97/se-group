// ============================================================
//  Neuranet — DIAPOSITIVAS (16:9)
//
//  1. Copia este fichero a la carpeta de la entrega (p. ej. entrega-1/).
//  2. Rellena y escribe.
//  3. Compila desde la raíz del repositorio:
//       ./templates/compilar.sh entrega-1/presentacion.typ
//     o con vista previa en directo:
//       ./templates/compilar.sh entrega-1/presentacion.typ watch
// ============================================================

#import "/templates/lib.typ": *

#let secciones = ("Primera sección", "Segunda sección")

#title-slide(
  title: [Título de la presentación],
  subtitle: [Subtítulo opcional],
  author: "Nombre 1 · Nombre 2 · Nombre 3 · Nombre 4",
  date: "Octubre 2026",
  client: [Nombre del cliente],         // «Preparado para»
  event: [Propuesta técnica · AñadaMaster],
)

#agenda-slide(secciones, current: 1)

#section-slide[1 · Primera sección]

#slide(title: [Una diapositiva])[
  - Primer punto
  - Segundo punto
]

#slide(title: [Dos columnas])[
  #slide-columns(
    [Texto o viñetas a la izquierda.],
    note(title: [Recuadro])[Todos los recuadros de la plantilla funcionan en diapositivas.],
  )
]

#slide(title: [Una cifra])[
  #stat[42][una cifra que queráis destacar]
]

#focus-slide[Una idea clave en grande.]

// Diapositiva con un diagrama que ocupa todo el espacio: fit: true
//   #slide(title: [Organigrama], fit: true)[ #orgchart(org-node(...)) ]
// Ayudas: title-slide, agenda-slide(items, current:), section-slide,
// slide(title:, fit:, align-center:), focus-slide, slide-columns, stat.

// Piezas compartidas por el documento y las diapositivas de la Entrega 1:
// datos del equipo, organigrama y lienzo del modelo de negocio.
#import "/templates/lib.typ": *

// ---------------- Equipo ----------------
#let equipo = (
  (nombre: "Itziar Morales Rodriguez", cargo: "CEO & Project Manager", area: none,
   tareas: ([Dirige la empresa y el proyecto], [Planifica y hace el seguimiento (Gantt)], [Es la interlocutora con el cliente], [Redacta las actas de las reuniones])),
  (nombre: "Samuel Porta Boylan", cargo: "Business Analyst", area: [Análisis y requisitos],
   tareas: ([Captura y gestiona los requisitos], [Casos de uso y sus especificaciones], [Historias de usuario y criterios en Gherkin], [Mapa de stakeholders])),
  (nombre: "Javier Cejuela García", cargo: "Software Architect", area: [Arquitectura y diseño],
   tareas: ([Arquitectura del sistema], [Diagramas de clases y de secuencia], [Infraestructura y TCO])),
  (nombre: "Diego Herrera Rodríguez", cargo: "Lead Developer (AI & QA)", area: [Desarrollo, IA y calidad],
   tareas: ([Desarrollo asistido por IA], [Pruebas y control de calidad], [Material para que el cliente evolucione su aplicación con IA])),
)

// ---------------- Organigrama ----------------
// Mezcla de estructura jerárquica y plana: las tres áreas responden ante la
// dirección (líneas continuas) y trabajan entre sí sin intermediarios
// (flechas). Cada caja lleva el cargo, la persona y sus responsabilidades;
// las tres de abajo miden siempre lo mismo.
#let org-tareas(p, s, color) = {
  set par(justify: false, leading: 0.4em)
  set text(size: 8pt * s, fill: color)
  set align(left)
  list(marker: box(baseline: -0.22em, square(size: 0.34em, fill: chispa)),
    indent: 0pt, body-indent: 0.5em, spacing: 0.5em, tight: false, ..p.tareas)
}
#let org-caja(p, w, h, top: false, s: 1) = block(
  width: w, height: h, inset: (x: 9pt * s, y: 8pt * s), breakable: false,
  fill: if top { petroleo } else { white },
  stroke: if top { none } else { 1pt + petroleo },
  {
    set par(justify: false, leading: 0.45em)
    set align(center + std.top)
    set block(spacing: 0pt)
    if p.area != none { block(text(size: 6.8pt * s, fill: brasa, weight: 700, tracking: 0.6pt)[#upper(p.area)]); v(4pt * s) }
    block(text(size: 10pt * s, weight: 700, font: headingfont, fill: if top { white } else { petroleo })[#p.cargo])
    v(3pt * s)
    block(text(size: 8.5pt * s, fill: if top { rgb("#DCE4E5") } else { muted })[#p.nombre])
    v(7pt * s)
    line(length: 100%, stroke: 0.5pt + if top { rgb("#3E5A60") } else { hairline })
    v(7pt * s)
    if top {
      let mitad = calc.ceil(p.tareas.len() / 2)
      grid(columns: (1fr, 1fr), column-gutter: 10pt * s,
        org-tareas((tareas: p.tareas.slice(0, mitad)), s, white),
        org-tareas((tareas: p.tareas.slice(mitad)), s, white))
    } else { org-tareas(p, s, ink) }
  },
)

#let organigrama(s: 1) = layout(size => {
  let jefa = equipo.at(0)
  let rest = equipo.slice(1)
  let W = size.width
  let inset-x = 8pt * s
  let arrow-w = 16pt * s
  let bw = (W - 2 * inset-x - 2 * arrow-w) / 3
  let top-w = calc.min(W * 0.62, bw * 2)
  let h = calc.max(..rest.map(p => measure(org-caja(p, bw, auto, s: s)).height))
  let th = measure(org-caja(jefa, top-w, auto, top: true, s: s)).height
  let colab = box(width: arrow-w, height: h, align(center + horizon,
    text(size: 13pt * s, fill: chispa, font: "DejaVu Sans Mono", weight: 700)[↔]))
  let drop = 12pt * s
  // posiciones x de los centros de las tres cajas
  let cx = range(3).map(i => inset-x + bw / 2 + i * (bw + arrow-w))
  stack(spacing: 0pt,
  align(center, org-caja(jefa, top-w, th, top: true, s: s)),
  block(width: W, height: 2 * drop, {
    place(top + left, dx: W / 2, line(start: (0pt, 0pt), end: (0pt, drop), stroke: 1pt + petroleo))
    place(top + left, dx: cx.at(0), dy: drop, line(start: (0pt, 0pt), end: (cx.at(2) - cx.at(0), 0pt), stroke: 1pt + petroleo))
    for x in cx { place(top + left, dx: x, dy: drop, line(start: (0pt, 0pt), end: (0pt, drop), stroke: 1pt + petroleo)) }
  }),
  block(width: W, fill: niebla, inset: (x: inset-x, top: 0pt, bottom: 8pt * s),
    stroke: (paint: rgb("#C9D6D8"), thickness: 0.6pt, dash: "dashed"), {
      grid(columns: (bw, arrow-w, bw, arrow-w, bw), align: horizon,
        org-caja(rest.at(0), bw, h, s: s), colab, org-caja(rest.at(1), bw, h, s: s), colab, org-caja(rest.at(2), bw, h, s: s))
      v(6pt * s)
      align(center, text(size: 7.5pt * s, fill: muted)[Equipo de proyecto · las áreas colaboran entre sí sin intermediarios])
    }),
  )
})

// ---------------- Lienzo del modelo de negocio ----------------
#let lienzo-celda(titulo, cuerpo, s: 1, acento: false) = block(
  width: 100%, height: 100%, inset: 7pt * s, fill: if acento { rgb("#FFF1EC") } else { white },
  stroke: 0.7pt + petroleo, {
    set align(left + top)
    set par(justify: false, leading: 0.5em, spacing: 0.5em)
    set list(spacing: 0.45em, indent: 0pt, body-indent: 0.45em, marker: box(baseline: -0.2em, square(size: 0.32em, fill: chispa)))
    text(size: 7.2pt * s, weight: 700, fill: brasa, tracking: 0.5pt)[#upper(titulo)]
    v(3pt * s)
    set text(size: 7.8pt * s)
    cuerpo
  })

#let lienzo(s: 1, alto: 15cm) = {
  let c = lienzo-celda.with(s: s)
  grid(
    columns: (1fr,) * 10,
    rows: (alto * 0.39, alto * 0.39, alto * 0.22),
    gutter: 0pt,
    grid.cell(colspan: 2, rowspan: 2, c([Socios clave])[
      - Proveedores de modelos de IA que permiten un uso privado de los datos
      - Proveedores de infraestructura en la nube
    ]),
    grid.cell(colspan: 2, c([Actividades clave])[
      - Análisis de requisitos con el cliente
      - Diseño y desarrollo asistido por IA
      - Pruebas y mantenimiento
    ]),
    grid.cell(colspan: 2, rowspan: 2, c([Propuesta de valor], acento: true)[
      - Software de gestión a medida, adaptado a cada problema
      - Desarrollo más rápido con LLM, aprendizaje automático y redes neuronales
      - Uso de IA que protege la privacidad de los datos del cliente
    ]),
    grid.cell(colspan: 2, c([Relación con clientes])[
      - Un único interlocutor: la CEO & Project Manager
      - Reuniones con acta
      - Soporte continuo con el mantenimiento
    ]),
    grid.cell(colspan: 2, rowspan: 2, c([Segmentos de clientes])[
      - Pymes de sectores tradicionales (agroalimentario, logística, comercio…)
      - Empresas que aún gestionan con hojas de cálculo o programas antiguos
    ]),
    grid.cell(colspan: 2, c([Recursos clave])[
      - Equipo de cuatro especialistas
      - Herramientas y modelos de IA
      - Método propio: plantillas y diagramas
    ]),
    grid.cell(colspan: 2, c([Canales])[
      - Contacto directo
      - Reuniones en las instalaciones del cliente u online
      - Oficina en Madrid
    ]),
    grid.cell(colspan: 5, c([Estructura de costes])[
      - Salarios del equipo (el coste principal)
      - Herramientas y modelos de IA, infraestructura en la nube y equipos
      - Oficina en Madrid (trabajo híbrido)
    ]),
    grid.cell(colspan: 5, c([Fuentes de ingresos], acento: true)[
      - *Precio cerrado por proyecto:* alcance, precio y plazo pactados al inicio
      - *Cuota mensual de mantenimiento:* soporte, corrección de errores y actualizaciones
    ]),
  )
}

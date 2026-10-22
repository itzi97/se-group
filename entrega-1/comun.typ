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
// (flechas discontinuas).
#let org-caja(p, top: false, s: 1) = box(
  width: 100%, height: if top { auto } else { 2.4cm * s }, inset: (x: 8pt * s, y: 7pt * s),
  fill: if top { petroleo } else { white },
  stroke: if top { none } else { 1pt + petroleo },
  {
    set align(center + horizon)
    set par(justify: false, leading: 0.45em)
    if p.area != none { text(size: 7pt * s, fill: brasa, weight: 700, tracking: 0.6pt)[#upper(p.area)]; v(2pt * s) }
    text(size: 10pt * s, weight: 700, font: headingfont, fill: if top { white } else { petroleo })[#p.cargo]
    v(1pt * s)
    text(size: 8.5pt * s, fill: if top { rgb("#DCE4E5") } else { ink })[#p.nombre]
  },
)

#let organigrama(s: 1) = {
  let jefa = equipo.at(0)
  let rest = equipo.slice(1)
  let colab = box(width: 100%, align(center + horizon,
    text(size: 14pt * s, fill: chispa, font: "DejaVu Sans Mono", weight: 700)[↔]))
  set block(spacing: 0pt)
  align(center, box(width: 40%, org-caja(jefa, top: true, s: s)))
  // conectores: bajada central, travesaño y tres bajadas
  align(center, line(start: (0pt, 0pt), end: (0pt, 12pt * s), stroke: 1pt + petroleo))
  block(width: 100%, height: 12pt * s, {
    place(top + left, dx: 16.67%, line(length: 66.66%, stroke: 1pt + petroleo))
    for x in (16.67%, 50%, 83.33%) { place(top + left, dx: x, line(start: (0pt, 0pt), end: (0pt, 12pt * s), stroke: 1pt + petroleo)) }
  })
  block(width: 100%, fill: niebla, inset: (x: 6pt * s, y: 8pt * s), stroke: (paint: rgb("#C9D6D8"), thickness: 0.6pt, dash: "dashed"), {
    grid(columns: (1fr, 1.3em * s, 1fr, 1.3em * s, 1fr), align: horizon,
      org-caja(rest.at(0), s: s), colab, org-caja(rest.at(1), s: s), colab, org-caja(rest.at(2), s: s))
    v(6pt * s)
    align(center, text(size: 7.5pt * s, fill: muted)[Equipo de proyecto · las áreas colaboran entre sí sin intermediarios])
  })
}

// ---------------- Lienzo del modelo de negocio ----------------
#let lienzo-celda(titulo, cuerpo, s: 1, acento: false) = block(
  width: 100%, height: 100%, inset: 7pt * s, fill: if acento { rgb("#FFF1EC") } else { white },
  stroke: 0.7pt + petroleo, {
    set align(left + top)
    set par(justify: false, leading: 0.5em, spacing: 0.5em)
    set list(spacing: 0.45em, marker: text(fill: chispa)[▪])
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

// ============================================================
//  Entrega 1 · Diapositivas para la exposición (5–15 min)
//  Compilar desde la raíz del repo:
//    ./templates/compilar.sh entrega-1/presentacion.typ
//  Cada diapositiva sigue el orden del documento: lo que se ve son
//  los puntos clave y el resto se cuenta de palabra.
// ============================================================

#import "/templates/lib.typ": *
#import "comun.typ": equipo
#import "/templates/neuranet-ramify.typ": usecase-diagram

#let secciones = ("Quiénes somos", "Modelo de negocio", "Organización", "Casos de uso")

// Franja de colores de la marca
#let paleta = grid(columns: (1fr,) * 5, column-gutter: 8pt,
  ..((petroleo, "Petróleo"), (chispa, "Chispa"), (brasa, "Brasa"), (sinapsis, "Sinapsis"), (niebla, "Niebla")).map(((c, n)) =>
    stack(spacing: 6pt,
      block(width: 100%, height: 1.1cm, fill: c, stroke: 0.5pt + hairline),
      text(size: 13pt, fill: muted)[#n])))

// ---------- Piezas visuales ----------
#let flecha(c: chispa, size: 26pt) = text(fill: c, font: "DejaVu Sans Mono", weight: 700, size: size)[→]
#let paso(titulo, sub, color: petroleo, w: 7.2cm, h: 3.4cm, oscuro: false) = block(
  width: w, height: h, fill: if oscuro { petroleo } else { niebla }, inset: 12pt,
  stroke: (top: 4pt + color), align(center + horizon, {
    set par(justify: false, leading: 0.45em)
    text(font: headingfont, weight: 700, size: 21pt, fill: if oscuro { white } else { color })[#titulo]
    if sub != none { v(0.25cm); text(size: 15pt, fill: if oscuro { rgb("#DCE4E5") } else { muted })[#sub] }
  }))
#let etiqueta(body, color: petroleo) = box(fill: color, inset: (x: 13pt, y: 8pt),
  text(fill: white, weight: 600, size: 15pt)[#body])

#title-slide(
  title: [AñadaMaster],
  subtitle: [Propuesta inicial],
  client: [Bodegas Viña Alcorza],
  author: "Itziar Morales · Samuel Porta · Javier Cejuela · Diego Herrera",
  date: "22 de octubre de 2026",
)

#agenda-slide(secciones)

// ---------------- 1 · Quiénes somos ----------------
#section-tag[1 · Quiénes somos]

#slide(title: [Somos Neuranet])[
  #slide-columns(ratio: (1.5fr, 1fr), gutter: 1cm,
    [
      #grid(columns: 3, column-gutter: 0.5cm, row-gutter: 0.3cm, align: center + bottom,
        text(font: headingfont, size: 50pt, weight: 700, fill: chispa)[neura],
        text(font: headingfont, size: 40pt, weight: 700, fill: muted)[+],
        text(font: headingfont, size: 50pt, weight: 700, fill: petroleo)[net],
        text(size: 16pt, fill: muted)[redes neuronales], [], text(size: 16pt, fill: muted)[red],
      )
      #v(1cm)
      #text(font: headingfont, size: 24pt, weight: 700, fill: petroleo)[Software de gestión a medida \ para pymes, hecho con IA.]
    ],
    align(center, image("/templates/logo-mark.svg", height: 6.5cm)),
  )
]

#slide(title: [Nuestros valores])[
  #set text(size: 26pt)
  #cards(gutter: 0.8cm, inset: (x: 24pt, y: 34pt), title-size: 1.15em,
    (title: [Innovación], accent: brasa, body: [Lo nuevo, si ayuda al cliente.]),
    (title: [Integridad], accent: petroleo, body: [Sus datos son suyos.]),
    (title: [Flexibilidad], accent: sinapsis, body: [A medida, y no al revés.]),
  )
]

#slide(title: [Nuestra marca], align-center: true)[
  #image("/templates/logo-full.svg", width: 12cm)
  #v(0.3cm)
  #text(font: headingfont, size: 24pt, fill: brasa)[Soluciones de IA a tu medida]
  #v(0.9cm)
  #box(width: 20cm, paleta)
]

// ---------------- 2 · Modelo de negocio ----------------
#section-tag[2 · Modelo de negocio]

#slide(title: [Modelo de negocio], fit: true)[
  #set align(center)
  #grid(columns: 5, column-gutter: 0.45cm, align: horizon,
    paso([Pymes], [con hojas de cálculo y programas viejos], h: 4cm),
    flecha(),
    paso([Neuranet], [desarrollo con IA], color: chispa, oscuro: true, h: 4cm),
    flecha(),
    paso([Software a medida], [más rápido y con sus datos seguros], color: sinapsis, h: 4cm),
  )
  #v(1.1cm)
  #grid(columns: 2, column-gutter: 0.8cm,
    etiqueta([Precio cerrado por proyecto], color: brasa),
    etiqueta([Cuota mensual de mantenimiento]),
  )
]

#let celda(t, b, acento: false) = block(width: 100%, height: 100%, inset: 11pt,
  fill: if acento { rgb("#FFF1EC") } else { white }, stroke: 0.8pt + petroleo, {
    set align(left + top)
    set par(justify: false, leading: 0.45em)
    text(size: 10.5pt, weight: 700, fill: brasa, tracking: 0.5pt)[#upper(t)]
    v(0.2cm)
    text(size: 15pt, fill: ink)[#b]
  })
#slide(title: [Lienzo del modelo de negocio], fit: true)[
  #box(width: 24cm)[
  #grid(columns: (1fr,) * 10, rows: (3.5cm, 3.5cm, 2.4cm),
    grid.cell(colspan: 2, rowspan: 2, celda([Socios clave], [Proveedores de IA y de nube])),
    grid.cell(colspan: 2, celda([Actividades], [Requisitos, desarrollo y mantenimiento])),
    grid.cell(colspan: 2, rowspan: 2, celda([Propuesta de valor], [Software a medida, más rápido y con los datos seguros], acento: true)),
    grid.cell(colspan: 2, celda([Relación], [Un solo contacto])),
    grid.cell(colspan: 2, rowspan: 2, celda([Clientes], [Pymes de sectores tradicionales])),
    grid.cell(colspan: 2, celda([Recursos], [Equipo de 4 y herramientas de IA])),
    grid.cell(colspan: 2, celda([Canales], [Trato directo y oficina en Madrid])),
    grid.cell(colspan: 5, celda([Costes], [Salarios, IA y nube, oficina])),
    grid.cell(colspan: 5, celda([Ingresos], [Precio cerrado + cuota mensual], acento: true)),
  )]
]

// ---------------- 3 · Organización ----------------
#section-tag[3 · Organización]

#let rol(p, oscuro: false, w: 7cm) = block(width: w, height: 2.9cm, inset: 10pt,
  fill: if oscuro { petroleo } else { white }, stroke: if oscuro { none } else { 1.2pt + petroleo },
  align(center + horizon, {
    set par(justify: false, leading: 0.4em)
    if p.area != none { text(size: 10.5pt, weight: 700, fill: brasa, tracking: 0.5pt)[#upper(p.area)]; linebreak() }
    text(font: headingfont, size: 17pt, weight: 700, fill: if oscuro { white } else { petroleo })[#p.cargo]
    linebreak()
    text(size: 14pt, fill: if oscuro { rgb("#DCE4E5") } else { muted })[#p.nombre]
  }))
#slide(title: [Quién hace qué], fit: true)[
  #set align(center)
  #let L = 1pt + petroleo
  #block(width: 24cm, {
    set block(spacing: 0pt)
    align(center, rol(equipo.at(0), oscuro: true, w: 9cm))
    block(width: 24cm, height: 1cm, {
      place(top + left, dx: 12cm, line(end: (0pt, 0.5cm), stroke: L))
      place(top + left, dx: 3.5cm, dy: 0.5cm, line(end: (17cm, 0pt), stroke: L))
      for x in (3.5cm, 12cm, 20.5cm) { place(top + left, dx: x, dy: 0.5cm, line(end: (0pt, 0.5cm), stroke: L)) }
    })
    grid(columns: (7cm, 1.5cm, 7cm, 1.5cm, 7cm), align: center + horizon,
      rol(equipo.at(1)), flecha(size: 20pt), rol(equipo.at(2)), flecha(size: 20pt), rol(equipo.at(3)))
  })
  #v(0.9cm)
  #etiqueta([Jerárquica en la responsabilidad]) #h(0.3cm)
  #etiqueta([Plana en el trabajo], color: sinapsis) #h(0.3cm)
  #etiqueta([Híbrido · Madrid], color: brasa) #h(0.3cm)
  #etiqueta([Proceso Unificado], color: muted)
]

// ---------------- 4 · Casos de uso ----------------
#section-tag[4 · Casos de uso]

#let flecha-uml(tipo, color) = box(width: 4.2cm, height: 1cm, {
  place(horizon + left, line(length: 4cm, stroke: (paint: color, thickness: 1.4pt, dash: "dashed")))
  place(horizon + right, text(fill: color, size: 16pt, font: "DejaVu Sans Mono")[▶])
  place(top + center, dy: -0.15cm, text(fill: color, size: 13pt, weight: 700)[«#tipo»])
})
#slide(title: [Cómo hemos planteado los casos de uso], fit: true)[
  #set align(center)
  #grid(columns: 2, column-gutter: 1.2cm,
    paso([CoreReservas], [Pedidos · Personal y Administrador], w: 10cm, h: 3cm),
    paso([CoreBodega], [Uva y empleados · Administrador], color: sinapsis, w: 10cm, h: 3cm),
  )
  #v(0.5cm)
  #text(size: 19pt, fill: petroleo, weight: 600)[Un caso de uso por opción del menú]
  #v(0.9cm)
  #grid(columns: (auto, auto), column-gutter: 0.6cm, row-gutter: 0.7cm, align: left + horizon,
    flecha-uml("include", chispa), text(size: 18pt)[se hace siempre (buscar el pedido)],
    flecha-uml("extend", sinapsis), text(size: 18pt)[solo a veces (el cliente no existe)],
  )
]

#slide(title: [CoreReservas], fit: true)[
  #usecase-diagram(json("/diagramas/usecase-casos-de-uso-corereservas-0f712f.json"), show-codes: false, size: 11pt, row-gap: 7pt, v-pad: 0.7, legend: false)
]

#slide(title: [CoreBodega], fit: true)[
  #usecase-diagram(json("/diagramas/usecase-casos-de-uso-corebodega-b0c308.json"), show-codes: false, size: 11pt, row-gap: 12pt, v-pad: 0.8, legend: false)
]

#let estado(t, c: petroleo) = box(fill: c, inset: (x: 12pt, y: 9pt), text(fill: white, weight: 600, size: 16pt)[#t])
#slide(title: [Cambios tras la reunión del 16/10], fit: true)[
  #set align(center)
  #text(size: 15pt, weight: 700, fill: brasa, tracking: 0.6pt)[ESTADOS DEL PEDIDO]
  #v(0.35cm)
  #estado([Reservado]) #flecha(size: 18pt) #estado([Confirmado]) #flecha(size: 18pt) #estado([Facturado], c: brasa) #flecha(size: 18pt) #estado([Enviado]) #flecha(size: 18pt) #estado([Cerrado])
  #v(0.25cm)
  #text(size: 14pt, fill: muted)[Solo se puede anular antes de facturar]
  #v(1cm)
  #grid(columns: 3, column-gutter: 0.6cm,
    paso([Generar factura], [la factura se guarda], color: brasa, w: 7cm, h: 3cm),
    paso([Ficha de cliente], [residencial o industrial, NIF o CIF], w: 7cm, h: 3cm),
    paso([Entrada de uva], [peso, variedad y grado de azúcar], color: sinapsis, w: 7cm, h: 3cm),
  )
]

#focus-slide[Gracias \ #text(size: 22pt, weight: 500, fill: chispa)[Soluciones de IA a tu medida]]

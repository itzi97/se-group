// ============================================================
//  Entrega 2 · Diapositivas para la exposición (5–15 min)
//  Compilar desde la raíz del repo:
//    ./templates/compilar.sh entrega-2/presentacion.typ
//  Mismo orden que el documento: visión, stakeholders y modelos UML.
//  Lo que se ve son los puntos clave; el resto se cuenta de palabra.
// ============================================================

#import "/templates/lib.typ": *
#import "/templates/neuranet-uml.typ": *
#import "comun.typ": *

#let secciones = ("Visión", "Stakeholders", "Casos de uso", "Clases y estados", "Secuencias")

#let pieza(titulo, cuerpo, color: petroleo) = block(width: 100%, fill: niebla, inset: 14pt,
  stroke: (top: 4pt + color), {
    set par(justify: false, leading: 0.5em)
    text(font: headingfont, weight: 700, size: 20pt, fill: color, titulo)
    v(0.3cm)
    text(size: 16pt, cuerpo)
  })

#title-slide(
  title: [AñadaMaster],
  subtitle: [Visión, stakeholders y modelos UML],
  client: [Bodegas Viña Alcorza],
  author: "Itziar Morales · Samuel Porta · Javier Cejuela · Diego Herrera",
  date: "12 de noviembre de 2026",
)

#agenda-slide(secciones)

// ---------------- 1 · Visión ----------------
#section-tag[1 · Visión]

#slide(title: [AñadaMaster en un minuto], fit: true)[
  #box(width: 26cm, vision-pitch(vision, size: 15pt))
]

// ---------------- 2 · Stakeholders ----------------
#section-tag[2 · Stakeholders]

#slide(title: [Quién está implicado], fit: true)[
  #grid(columns: 2, column-gutter: 1.2cm, align: horizon,
    stakeholder-onion(stakeholders, side: 10cm, size: 8pt),
    stakeholder-grid(stakeholders, side: 9.5cm, size: 7.5pt))
  #align(center, stakeholder-legend(size: 10pt))
]

#slide(title: [Qué hacemos con cada uno])[
  #cards(gutter: 0.6cm, inset: (x: 18pt, y: 20pt),
    (title: [Gestionar de cerca], accent: brasa,
     body: text(size: 16pt)[Dirección, vuestro representante y los administradores. Validan cada entrega.]),
    (title: [Mantener informados], accent: sinapsis,
     body: text(size: 16pt)[Personal de oficina, clientes y viticultores. Formación antes del cambio.]),
    (title: [Mantener satisfechos], accent: petroleo,
     body: text(size: 16pt)[Hacienda y protección de datos. Facturas y datos personales, desde el diseño.]),
  )
]

// ---------------- 3 · Casos de uso ----------------
#section-tag[3 · Casos de uso]

#slide(title: [CoreReservas: 8 casos de uso], fit: true)[#usecase-diagram(reservas)]
#slide(title: [CoreBodega: 7 casos de uso], fit: true)[#usecase-diagram(bodega)]

#slide(title: [Cada caso de uso, especificado])[
  #slide-columns(ratio: (1fr, 1.25fr), gutter: 1cm,
    [
      #set text(size: 18pt)
      - Actor, precondiciones y disparador
      - Flujo principal paso a paso
      - Flujos alternativos (errores, «no confirma»…)
      - Postcondiciones
      #v(0.6cm)
      #text(fill: muted, size: 15pt)[Las 15 especificaciones están en el documento.]
    ],
    box(width: 100%, {
      set text(size: 9pt)
      especificacion(reservas.data.nodes.find(n => n.at("spec", default: (:)).at("code", default: "") == "CU-06"), size: 10pt)
    }),
  )
]

#slide(title: [Lo que hemos supuesto (para confirmar)], fit: true)[
  #box(width: 30cm, tabla-supuestos(size: 11pt))
]

// ---------------- 4 · Clases y estados ----------------
#section-tag[4 · Clases y estados]

#slide(title: [Modelo de dominio · CoreReservas], fit: true)[#class-diagram(dominio-reservas)]
#slide(title: [Modelo de dominio · CoreBodega], fit: true)[#class-diagram(dominio-bodega)]
#slide(title: [Diseño · CoreReservas], fit: true)[#class-diagram(diseno-reservas)]
#slide(title: [Diseño · CoreBodega], fit: true)[#class-diagram(diseno-bodega)]
#slide(title: [Ciclo de vida de un pedido], fit: true)[#state-diagram(estados)]

// ---------------- 5 · Secuencias ----------------
#section-tag[5 · Secuencias]

#slide(title: [Una secuencia por opción del menú])[
  #grid(columns: (1fr,) * 4, column-gutter: 0.5cm, row-gutter: 0.5cm,
    ..secuencias.map(s => block(width: 100%, height: 3cm, fill: niebla, inset: 12pt, stroke: (top: 3pt + sinapsis), {
      text(font: monofont, size: 13pt, fill: brasa, s.cu); linebreak()
      text(font: headingfont, weight: 700, size: 17pt, fill: petroleo, s.opcion)
    })))
  #v(0.5cm)
  #text(size: 17pt)[Pantalla → control → entidades → base de datos. Todas las operaciones en fragmentos `alt`.]
]

#slide(title: [Ejemplo: Factura (CU-06)], fit: true)[#sequence-diagram(secuencias.at(4).d)]
#slide(title: [Ejemplo: Detalle Materia Prima (CU-22)], fit: true)[#sequence-diagram(secuencias.at(6).d)]

#focus-slide[Gracias \ #text(size: 22pt, weight: 500, fill: chispa)[Soluciones de IA a tu medida]]

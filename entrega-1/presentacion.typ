// ============================================================
//  Entrega 1 · Diapositivas para la exposición (5–15 min)
//  Compilar desde la raíz del repo:
//    ./templates/compilar.sh entrega-1/presentacion.typ
// ============================================================

#import "/templates/lib.typ": *
#import "comun.typ": equipo, organigrama
#import "/templates/neuranet-ramify.typ": usecase-diagram

#let secciones = ("Quiénes somos", "Modelo de negocio", "Organización", "Casos de uso")

#title-slide(
  title: [AñadaMaster],
  subtitle: [Propuesta inicial],
  client: [Bodegas Viña Alcorza],
  author: "Itziar Morales · Samuel Porta · Javier Cejuela · Diego Herrera",
  date: "22 de octubre de 2026",
)

#agenda-slide(secciones)

#section-tag[1 · Quiénes somos]

#slide(title: [Por qué «Neuranet»])[
  #slide-columns(ratio: (1.1fr, 1fr),
    [
      #set text(size: 22pt)
      - *neura*, de redes neuronales
      - *net*, red
      - Trabajamos con LLM, aprendizaje automático y redes neuronales
    ],
    align(center, image("/templates/logo-mark.svg", height: 5.5cm)),
  )
]

#slide(title: [Nuestros valores])[
  #set text(size: 25pt)
  #cards(gutter: 0.8cm, inset: (x: 22pt, y: 30pt), title-size: 1.25em,
    (title: [Innovación], accent: brasa, body: [Probamos lo nuevo y nos quedamos con lo que ayuda al cliente.]),
    (title: [Integridad], accent: petroleo, body: [Los datos del cliente son suyos. Usamos la IA sin poner en riesgo su privacidad.]),
    (title: [Flexibilidad], accent: sinapsis, body: [Adaptamos el software a cada empresa, y no al revés.]),
  )
]

#slide(title: [Nuestra marca], align-center: true)[
  #image("/templates/logo-full.svg", width: 13cm)
  #v(0.6cm)
  #text(font: headingfont, size: 22pt, fill: brasa)[Soluciones de IA a tu medida]
  #v(0.5cm)
  #text(size: 18pt, fill: muted)[La "N" es una red neuronal: entra la necesidad, se enciende la neurona y sale el software.]
]

#section-tag[2 · Modelo de negocio]

#slide(title: [Modelo de negocio])[
  #set text(size: 18pt)
  #cards(columns: 2, gutter: 0.6cm, inset: (x: 18pt, y: 16pt), title-size: 1.2em,
    (title: [Para quién], accent: petroleo,
     body: [Pymes del sector agroalimentario, la logística o el comercio que aún se apañan con hojas de cálculo o programas viejos.]),
    (title: [Qué ofrecemos], accent: brasa,
     body: [Un programa de gestión pensado para su forma de trabajar. Con IA tardamos menos, y cuidamos sus datos.]),
    (title: [Cómo trabajamos], accent: sinapsis,
     body: [Una sola persona de contacto, un acta de cada reunión y oficina en Madrid.]),
    (title: [Cómo ganamos dinero], accent: chispa,
     body: [Precio cerrado por proyecto y una cuota al mes por el mantenimiento.]),
  )
]

#section-tag[3 · Organización]

#slide(title: [Quién hace qué], fit: true)[
  #box(width: 25cm, organigrama(s: 1.6))
]

#section-tag[4 · Casos de uso]

#slide(title: [Casos de uso · CoreReservas], fit: true)[
  #usecase-diagram(json("/diagramas/usecase-casos-de-uso-corereservas-0f712f.json"), show-codes: false, size: 11pt, row-gap: 7pt, v-pad: 0.7, legend: false)
]

#slide(title: [Casos de uso · CoreBodega], align-center: true)[
  #usecase-diagram(json("/diagramas/usecase-casos-de-uso-corebodega-b0c308.json"), show-codes: false, size: 12.5pt, row-gap: 10pt, v-pad: 0.8, legend: false, max-scale: 2)
]

#slide(title: [Lo que cambió tras hablar con el cliente])[
  #set text(size: 23pt)
  #set list(spacing: 1em)
  - Imprimir factura pasa a ser *Generar factura*: la factura se guarda
  - Pedido: reservado › confirmado › facturado › enviado › cerrado. Solo se anula antes de facturar
  - Cliente residencial o industrial, con NIF o CIF
  - De la uva se apuntan peso, variedad y grado de azúcar. No hay devoluciones
  - La producción, más adelante
]

#focus-slide[Soluciones de IA a tu medida.]

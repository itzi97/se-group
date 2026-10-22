// ============================================================
//  Entrega 1 · Diapositivas para la exposición (5–15 min)
//  Compilar desde la raíz del repo:
//    ./templates/compilar.sh entrega-1/presentacion.typ
// ============================================================

#import "/templates/lib.typ": *
#import "comun.typ": equipo, organigrama, lienzo
#import "/templates/neuranet-ramify.typ": usecase-diagram

#let secciones = ("Quiénes somos", "Modelo de negocio", "Organización", "Casos de uso")

#title-slide(
  title: [AñadaMaster],
  subtitle: [Propuesta inicial],
  client: [Bodegas Viña Alcorza],
  author: "Itziar Morales · Samuel Porta · Javier Cejuela · Diego Herrera",
  date: "22 de octubre de 2026",
)

#agenda-slide(secciones, current: 1)

#section-slide[1 · Quiénes somos]

#slide(title: [Por qué «Neuranet»])[
  #slide-columns(ratio: (1.1fr, 1fr),
    [
      - *neura*: redes neuronales
      - *net*: red
      - Desarrollamos con LLM, aprendizaje automático y redes neuronales
      - Siempre al día de cómo avanza la industria
    ],
    align(center, image("/templates/logo-mark.svg", height: 5.5cm)),
  )
]

#slide(title: [Nuestros valores])[
  #set text(size: 20pt)
  #set par(justify: false)
  #grid(columns: (1fr, 1fr, 1fr), column-gutter: 0.8cm,
    callout(title: [Innovación], accent: brasa)[Al corriente de lo que aparece, y lo usamos cuando aporta valor.],
    callout(title: [Integridad], accent: petroleo)[Cuidamos los datos del cliente y usamos los LLM sin poner en riesgo su privacidad.],
    callout(title: [Flexibilidad], accent: sinapsis)[Nos adaptamos a cada problema con soluciones a medida.],
  )
]

#slide(title: [Nuestra marca], align-center: true)[
  #image("/templates/logo-full.svg", width: 13cm)
  #v(0.6cm)
  #text(font: headingfont, size: 22pt, fill: brasa)[Soluciones de IA a tu medida]
  #v(0.5cm)
  #text(size: 15pt, fill: muted)[La «N» es una red neuronal: entrada, neurona que se enciende y salida. La «a» repite la neurona.]
]

#section-slide[2 · Modelo de negocio]

#slide(title: [Modelo de negocio], fit: true)[
  #box(width: 26cm, lienzo(s: 1.35, alto: 14.5cm))
]

#slide(title: [Cómo ganamos dinero])[
  #set par(justify: false)
  #slide-columns(
    callout(title: [Precio cerrado por proyecto], accent: brasa)[Alcance, precio y plazo pactados al inicio: el cliente sabe desde el primer día cuánto le cuesta.],
    callout(title: [Cuota mensual de mantenimiento], accent: petroleo)[Soporte, corrección de errores y actualizaciones una vez entregado el software.],
  )
]

#section-slide[3 · Organización]

#slide(title: [Organigrama], fit: true)[
  #box(width: 24cm, organigrama(s: 1.45))
]

#slide(title: [Quién hace qué])[
  #set text(size: 14pt)
  #neuranet-table(
    columns: (auto, auto, 1fr),
    inset: (x: 10pt, y: 7pt),
    header: ([Persona], [Cargo], [Responsabilidades]),
    ..equipo.map(p => ([#p.nombre], [*#p.cargo*], p.tareas.join([ · ]))).flatten(),
  )
]

#section-slide[4 · Casos de uso]

#slide(title: [Casos de uso · CoreReservas], fit: true)[
  #usecase-diagram(json("/diagramas/usecase-casos-de-uso-corereservas-0f712f.json"), show-codes: false, size: 9.5pt, row-gap: 6pt, v-pad: 0.5, legend: false)
]

#slide(title: [Casos de uso · CoreBodega], fit: true)[
  #usecase-diagram(json("/diagramas/usecase-casos-de-uso-corebodega-b0c308.json"), show-codes: false, size: 11pt, row-gap: 7pt, v-pad: 0.5, legend: false)
]

#slide(title: [Lo que cambió tras hablar con el cliente])[
  #set text(size: 18pt)
  - *Generar factura*: será su primer sistema de facturación
  - Pedido: reservado › confirmado › facturado › enviado › cerrado; se anula solo antes de facturar
  - Cliente residencial o industrial, con NIF o CIF
  - Uva: peso, variedad y grado de azúcar; la que no llega al mínimo se tira
  - La producción, en versiones posteriores
]

#focus-slide[Soluciones de IA a tu medida.]

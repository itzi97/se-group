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
      - *neura*: redes neuronales
      - *net*: red
      - Desarrollamos con LLM, aprendizaje automático y redes neuronales
      - Siempre al día de cómo avanza la industria
    ],
    align(center, image("/templates/logo-mark.svg", height: 5.5cm)),
  )
]

#slide(title: [Nuestros valores])[
  #set text(size: 25pt)
  #cards(gutter: 0.8cm, inset: (x: 22pt, y: 30pt), title-size: 1.25em,
    (title: [Innovación], accent: brasa, body: [Al corriente de lo que aparece, y lo usamos cuando aporta valor.]),
    (title: [Integridad], accent: petroleo, body: [Cuidamos los datos del cliente y usamos los LLM sin poner en riesgo su privacidad.]),
    (title: [Flexibilidad], accent: sinapsis, body: [Nos adaptamos a cada problema con soluciones a medida.]),
  )
]

#slide(title: [Nuestra marca], align-center: true)[
  #image("/templates/logo-full.svg", width: 13cm)
  #v(0.6cm)
  #text(font: headingfont, size: 22pt, fill: brasa)[Soluciones de IA a tu medida]
  #v(0.5cm)
  #text(size: 18pt, fill: muted)[La «N» es una red neuronal: entrada, neurona que se enciende y salida. La «a» repite la neurona.]
]

#section-tag[2 · Modelo de negocio]

#slide(title: [Modelo de negocio])[
  #set text(size: 18pt)
  #cards(columns: 2, gutter: 0.6cm, inset: (x: 18pt, y: 16pt), title-size: 1.2em,
    (title: [Para quién], accent: petroleo,
     body: [Pymes de sectores tradicionales (agroalimentario, logística, comercio) que aún gestionan con hojas de cálculo o programas antiguos.]),
    (title: [Qué ofrecemos], accent: brasa,
     body: [Software de gestión a medida, desarrollado con IA para reducir plazos y con un uso de los LLM que protege sus datos.]),
    (title: [Cómo trabajamos], accent: sinapsis,
     body: [Un único interlocutor, reuniones con acta y equipo híbrido con oficina en Madrid.]),
    (title: [Cómo ganamos dinero], accent: chispa,
     body: [Precio cerrado por proyecto y una cuota mensual de mantenimiento (soporte, errores y actualizaciones).]),
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
  - *Generar factura*: será su primer sistema de facturación
  - Pedido: reservado › confirmado › facturado › enviado › cerrado; se anula solo antes de facturar
  - Cliente residencial o industrial, con NIF o CIF
  - Uva: peso, variedad y grado de azúcar; la que no llega al mínimo se tira
  - La producción, en versiones posteriores
]

#focus-slide[Soluciones de IA a tu medida.]

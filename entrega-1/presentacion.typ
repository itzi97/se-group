// ============================================================
//  Entrega 1 · Diapositivas para la exposición (5–15 min)
//  Compilar desde la raíz del repo:
//    ./templates/compilar.sh entrega-1/presentacion.typ
//  Cada diapositiva sigue el orden del documento: lo que se ve son
//  los puntos clave y el resto se cuenta de palabra.
// ============================================================

#import "/templates/lib.typ": *
#import "comun.typ": equipo, organigrama, lienzo
#import "/templates/neuranet-ramify.typ": usecase-diagram

#let secciones = ("Quiénes somos", "Modelo de negocio", "Organización", "Casos de uso")

// Franja de colores de la marca
#let paleta = grid(columns: (1fr,) * 5, column-gutter: 8pt,
  ..((petroleo, "Petróleo"), (chispa, "Chispa"), (brasa, "Brasa"), (sinapsis, "Sinapsis"), (niebla, "Niebla")).map(((c, n)) =>
    stack(spacing: 6pt,
      block(width: 100%, height: 1.1cm, fill: c, stroke: 0.5pt + hairline),
      text(size: 13pt, fill: muted)[#n])))

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
  #slide-columns(ratio: (1.35fr, 1fr), gutter: 1.2cm,
    [
      #text(font: headingfont, size: 26pt, weight: 700, fill: petroleo)[Software de gestión a medida para pymes, hecho con IA.]
      #v(0.7cm)
      #set text(size: 20pt)
      - *neura*, de redes neuronales, y *net*, red
      - Trabajamos con LLM, aprendizaje automático y redes neuronales
      - Empresa de Madrid, cuatro personas
    ],
    align(center, image("/templates/logo-mark.svg", height: 6cm)),
  )
]

#slide(title: [Nuestros valores])[
  #set text(size: 23pt)
  #cards(gutter: 0.8cm, inset: (x: 22pt, y: 26pt), title-size: 1.3em,
    (title: [Innovación], accent: brasa, body: [Probamos lo nuevo y nos quedamos con lo que ayuda al cliente.]),
    (title: [Integridad], accent: petroleo, body: [Los datos del cliente son suyos. Usamos la IA sin poner en riesgo su privacidad.]),
    (title: [Flexibilidad], accent: sinapsis, body: [Adaptamos el software a cada empresa, y no al revés.]),
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

#slide(title: [Modelo de negocio])[
  #set text(size: 19pt)
  #cards(columns: 2, gutter: 0.6cm, inset: (x: 20pt, y: 18pt), title-size: 1.2em,
    (title: [Para quién], accent: petroleo,
     body: [Pymes del sector agroalimentario, la logística o el comercio que aún se apañan con hojas de cálculo.]),
    (title: [Qué ofrecemos], accent: brasa,
     body: [Un programa pensado para su forma de trabajar. Con IA tardamos menos, y cuidamos sus datos.]),
    (title: [Cómo nos relacionamos], accent: sinapsis,
     body: [Una sola persona de contacto, reuniones en sus instalaciones u online y un acta de cada una.]),
    (title: [Cómo ganamos dinero], accent: chispa,
     body: [Precio cerrado por proyecto y una cuota al mes por el mantenimiento.]),
  )
]

#slide(title: [Lienzo del modelo de negocio], fit: true)[
  #box(width: 24cm, lienzo(s: 1.45, alto: 13.5cm))
]

// ---------------- 3 · Organización ----------------
#section-tag[3 · Organización]

#slide(title: [Cómo nos organizamos])[
  #set text(size: 19pt)
  #cards(gutter: 0.7cm, inset: (x: 20pt, y: 22pt), title-size: 1.1em,
    (title: [Una dirección], accent: petroleo,
     body: [Una persona dirige el proyecto y habla con el cliente. Siempre sabe a quién llamar.]),
    (title: [Áreas a la par], accent: sinapsis,
     body: [Requisitos, diseño y desarrollo trabajan juntos y se pasan el trabajo sin intermediarios.]),
    (title: [Trabajo híbrido], accent: brasa,
     body: [Oficina en Madrid y parte de la semana en remoto. En AñadaMaster seguimos el Proceso Unificado.]),
  )
]

#slide(title: [Quién hace qué], fit: true)[
  #box(width: 25cm, organigrama(s: 1.6))
]

// ---------------- 4 · Casos de uso ----------------
#section-tag[4 · Casos de uso]

#slide(title: [Cómo hemos planteado los casos de uso])[
  #set text(size: 19pt)
  #cards(columns: 2, gutter: 0.6cm, inset: (x: 20pt, y: 18pt), title-size: 1.2em,
    (title: [Dos programas], accent: petroleo,
     body: [CoreReservas para los pedidos y CoreBodega para la uva y los empleados. Un diagrama para cada uno.]),
    (title: [Una opción, un caso de uso], accent: brasa,
     body: [Cada opción del menú es un caso de uso. Dar de alta, modificar, dar de baja o anular van dentro.]),
    (title: [Actores], accent: sinapsis,
     body: [El administrador puede hacer lo mismo que el personal. El cliente de la bodega no usa el programa.]),
    (title: [«include» y «extend»], accent: chispa,
     body: [Un «include» se hace siempre, como buscar el pedido. Un «extend» solo a veces.]),
  )
]

#slide(title: [CoreReservas], fit: true)[
  #usecase-diagram(json("/diagramas/usecase-casos-de-uso-corereservas-0f712f.json"), show-codes: false, size: 11pt, row-gap: 7pt, v-pad: 0.7, legend: false)
]

#slide(title: [CoreBodega], fit: true)[
  #usecase-diagram(json("/diagramas/usecase-casos-de-uso-corebodega-b0c308.json"), show-codes: false, size: 11pt, row-gap: 12pt, v-pad: 0.8, legend: false)
]

#slide(title: [Cambios tras la reunión del 16/10])[
  #set text(size: 22pt)
  #set list(spacing: 0.9em)
  - Imprimir factura pasa a ser *Generar factura*: la factura se guarda
  - Pedido: reservado › confirmado › facturado › enviado › cerrado
  - Solo se anula antes de facturar
  - Cliente residencial o industrial, con NIF o CIF
  - De la uva se apuntan peso, variedad y grado de azúcar. No hay devoluciones
  - La producción, más adelante
]

#focus-slide[Gracias \ #text(size: 22pt, weight: 500, fill: chispa)[Soluciones de IA a tu medida]]

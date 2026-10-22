// ============================================================
//  Entrega 1 · Documento (parte 1: la empresa · parte 2: casos de uso)
//  Compilar desde la raíz del repo:
//    ./templates/compilar.sh entrega-1/documento.typ
// ============================================================

#import "/templates/lib.typ": *
#import "comun.typ": equipo, organigrama, lienzo
#import "/templates/neuranet-ramify.typ": usecase-diagram

#show: neuranet-doc.with(
  doc-type: [Propuesta inicial],
  title: [AñadaMaster],
  subtitle: [Quiénes somos y casos de uso del sistema],
  client: [Bodegas Viña Alcorza],
  project: [AñadaMaster],
  reference: "NN-AM-001",
  version: "1.0",
  status: [Final],
  date: "22 de octubre de 2026",
  author: "Itziar Morales Rodriguez · Samuel Porta Boylan · Javier Cejuela García · Diego Herrera Rodríguez",
  short-title: [AñadaMaster · Propuesta inicial],
)

// Índice y control de versiones en la misma página (sin cabecera ni pie)
#outline(title: [Índice])
#v(1.2cm)
#version-history(
  ("1.0", "22/10/2026", "Neuranet", [Primera versión: presentación de la empresa y casos de uso.]),
)

= Quiénes somos

Neuranet es una empresa de desarrollo de software con sede en Madrid. Creamos software de gestión a medida para pymes de sectores tradicionales y lo desarrollamos con ayuda de modelos de lenguaje (LLM), aprendizaje automático y redes neuronales.

== Nuestro nombre

*Neuranet* une _neura_, de las redes neuronales, y _net_, red. Usamos tecnologías pioneras en LLM, aprendizaje automático y redes neuronales para desarrollar código, y procuramos estar siempre al día de cómo avanza la industria. El nombre recoge esa forma de trabajar.

== Valores

#[
#set par(justify: false)
#grid(columns: (1fr, 1fr, 1fr), column-gutter: 10pt,
  callout(title: [Innovación], accent: brasa)[
    Estamos al corriente de las herramientas y técnicas que aparecen y las incorporamos cuando aportan valor al cliente.
  ],
  callout(title: [Integridad], accent: petroleo)[
    Tratamos los datos de nuestros clientes con cuidado y usamos los LLM sin poner en riesgo su privacidad.
  ],
  callout(title: [Flexibilidad], accent: sinapsis)[
    Nos adaptamos a cada problema y ofrecemos soluciones a medida en lugar de productos cerrados.
  ],
)
]

== Nuestra marca

#figure(
  image("/templates/logo-full.svg", width: 8.5cm),
  caption: [Logotipo de Neuranet.],
)

- *Logotipo.* La «N» es una red neuronal mínima: dos nodos de entrada (la necesidad del cliente), una neurona central que se enciende (nuestro equipo y nuestro proceso) y dos nodos de salida (el software que entregamos). La «a» repite esa neurona encendida en mitad de la palabra. La «N» sola sirve de icono cuando el logotipo no cabe.
- *Lema.* _Soluciones de IA a tu medida._ Resume lo que hacemos (IA) y cómo lo hacemos (a medida).
- *Colores.* El petróleo transmite seriedad y confianza. El naranja de la neurona aporta energía y marca los puntos importantes.
- *Tipografía.* Sora para títulos y logotipo, IBM Plex Sans para el texto e IBM Plex Mono para código e identificadores.

#let muestra(c) = box(width: 1.4em, height: 0.9em, fill: c, stroke: 0.4pt + hairline, baseline: 15%)
#neuranet-table(
  columns: (auto, auto, auto, 1fr),
  header: ([], [Color], [Código], [Uso]),
  muestra(petroleo), [Petróleo], `#12343B`, [Color principal: logotipo, títulos y texto],
  muestra(chispa), [Chispa], `#FF6A3D`, [La neurona del logotipo y los elementos gráficos destacados],
  muestra(brasa), [Brasa], `#C2410C`, [Texto destacado sobre fondo claro],
  muestra(sinapsis), [Sinapsis], `#2E8B7A`, [Color secundario para diagramas],
  muestra(niebla), [Niebla], `#F4F7F7`, [Fondos claros],
)

= Modelo de negocio

Nos dirigimos a pymes de sectores tradicionales, como el agroalimentario, la logística o el comercio, que todavía gestionan su actividad con hojas de cálculo o con programas antiguos. Les ofrecemos software de gestión hecho para su caso concreto, desarrollado con IA para reducir plazos y con un tratamiento cuidadoso de sus datos.

Cobramos de dos formas:

- *Precio cerrado por proyecto.* Al inicio pactamos el alcance, el precio y el plazo. El cliente sabe desde el primer día cuánto le va a costar.
- *Cuota mensual de mantenimiento.* Cubre el soporte, la corrección de errores y las actualizaciones una vez entregado el software. Nos da ingresos recurrentes y al cliente le asegura que su aplicación sigue funcionando.

@lienzo resume el modelo completo.

#figure(
  lienzo(alto: 13.5cm),
  caption: [Lienzo del modelo de negocio de Neuranet.],
) <lienzo>

= Organización

== Estructura

Somos cuatro personas, así que hemos combinado una estructura jerárquica con una plana:

- *Jerárquica en la responsabilidad.* La dirección y la jefatura de proyecto recaen en la misma persona, que decide, planifica y es la única interlocutora con el cliente. El cliente siempre sabe a quién dirigirse.
- *Plana en el trabajo.* Las tres áreas técnicas colaboran directamente entre sí. Los requisitos pasan al diseño y el diseño al desarrollo sin intermediarios, que es el orden en que trabaja el Proceso Unificado.

Una jerarquía pura añadiría capas innecesarias en un equipo tan pequeño, y una estructura totalmente plana dejaría al cliente sin un interlocutor claro.

#figure(
  organigrama(),
  caption: [Organigrama de Neuranet.],
)

== Roles

#neuranet-table(
  columns: (3.4cm, 3.9cm, 1fr),
  header: ([Persona], [Cargo], [Responsabilidades]),
  ..equipo.map(p => (
    [#p.nombre],
    [*#p.cargo*#if p.area != none [ \ #text(size: 0.85em, fill: muted)[#p.area]]],
    list(..p.tareas),
  )).flatten(),
)

== Cómo trabajamos

Trabajamos en formato híbrido: tenemos oficina en Madrid, trabajamos en remoto parte de la semana y nos reunimos con el cliente en sus instalaciones o por videollamada. Recogemos cada reunión en un acta.

Como empresa recién creada, todavía no tenemos una metodología fija. En AñadaMaster usaremos un desarrollo orientado a objetos y el Proceso Unificado. Al terminar, analizaremos qué habría cambiado con otras metodologías para elegir la que mejor nos funcione en los siguientes proyectos.

= Casos de uso

AñadaMaster está formado por dos programas, CoreReservas y CoreBodega, y hemos hecho un diagrama de casos de uso para cada uno. Son programas distintos, con usuarios distintos, y en un único diagrama los 25 casos de uso no se leerían bien.

Decisiones de modelado:

- *Actores.* En CoreReservas, el Personal es quien más usa el programa. El Administrador hereda de Personal: tiene los mismos privilegios y puede hacer todo lo que hace el Personal. En CoreBodega solo actúa el Administrador.
- *El cliente de la bodega no es actor.* No usa el sistema: llama por teléfono y el personal registra sus pedidos.
- *Confirmar y validar* son el último paso de cada caso de uso, no casos de uso aparte.
- *«include» y «extend».* Un «include» se ejecuta siempre: las búsquedas que comparten varios casos de uso y, en CoreBodega, _Registrar responsable de la operación_, porque debe quedar constancia de quién hizo cada gestión. Un «extend» solo ocurre si se cumple una condición: si al dar de alta un pedido el cliente no existe, se da de alta en ese momento.

#callout(title: [Cambios tras la reunión con el cliente del 16 de octubre], accent: brasa)[
  - _Imprimir factura_ pasa a ser _Generar factura_: AñadaMaster será el primer sistema de facturación de la bodega, así que la factura se guarda además de imprimirse.
  - Un pedido pasa por los estados reservado, confirmado, facturado, enviado y cerrado. Solo se puede anular antes de facturarlo.
  - La ficha de cliente indica si es residencial o industrial, y su NIF o CIF.
  - Al ingresar uva se registran el peso del remolque, la variedad y el grado de azúcar. No hay devoluciones: la uva que no llega al grado mínimo se tira y se usa como abono.
  - La producción de vino queda para versiones posteriores.

  Lo hablado en la reunión está en el acta NN-AM-ACT-01.
]

#let cu-tabla(d) = neuranet-table(
  columns: (auto, auto, 1fr),
  inset: (x: 8pt, y: 5pt),
  header: ([Código], [Caso de uso], [Qué hace]),
  ..d.data.nodes.filter(n => n.type == "usecase").sorted(key: n => n.spec.code)
    .map(n => (raw(n.spec.code), n.label.replace("\n", " "), n.spec.description)).flatten(),
)

#let reservas = json("/diagramas/usecase-casos-de-uso-corereservas-0f712f.json")
#let bodega = json("/diagramas/usecase-casos-de-uso-corebodega-b0c308.json")

== CoreReservas

#figure(usecase-diagram(reservas), caption: [Casos de uso de CoreReservas.], placement: none)

#[#set text(size: 9pt); #cu-tabla(reservas)]

== CoreBodega

#figure(usecase-diagram(bodega), caption: [Casos de uso de CoreBodega.])

#[#set text(size: 9pt); #cu-tabla(bodega)]

La especificación completa de cada caso de uso (actores, precondiciones, flujos y postcondiciones) está en los diagramas de se-ramify, en la carpeta `diagramas/`.

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
  chapter-break: false,
)

// Índice y control de versiones en la misma página (sin cabecera ni pie)
#outline(title: [Índice])
#v(1.2cm)
#version-history(
  ("1.0", "22/10/2026", "Neuranet", [Primera versión: presentación de la empresa y casos de uso.]),
)
#pagebreak()

= Quiénes somos

Neuranet es una empresa de software de Madrid. Hacemos software de gestión a medida para pymes de sectores tradicionales.

== Nuestro nombre

*Neuranet* une _neura_ (redes neuronales) y _net_ (red). Desarrollamos con LLM, aprendizaje automático y redes neuronales, y seguimos de cerca cómo avanza la industria.

== Valores

#cards(
  (title: [Innovación], accent: brasa,
   body: [Conocemos las herramientas que aparecen y las usamos cuando aportan valor al cliente.]),
  (title: [Integridad], accent: petroleo,
   body: [Cuidamos los datos de nuestros clientes y usamos los LLM sin poner en riesgo su privacidad.]),
  (title: [Flexibilidad], accent: sinapsis,
   body: [Nos adaptamos a cada problema con soluciones a medida, no con productos cerrados.]),
)

== Nuestra marca

#figure(image("/templates/logo-full.svg", width: 8cm), caption: [Logotipo de Neuranet.])

- *Logotipo.* La «N» es una red neuronal mínima: la entrada (la necesidad del cliente), una neurona que se enciende (nuestro trabajo) y la salida (el software). La «a» repite esa neurona.
- *Lema.* _Soluciones de IA a tu medida._
- *Tipografía.* Sora para títulos, IBM Plex Sans para el texto e IBM Plex Mono para el código.

#let muestra(c, nombre, hex, uso) = block(width: 100%, breakable: false, {
  set par(justify: false, leading: 0.4em)
  block(width: 100%, height: 1.1cm, fill: c, stroke: 0.5pt + hairline, below: 5pt)
  [#text(weight: 700, fill: petroleo, size: 9.5pt)[#nombre] #h(1fr) #text(font: monofont, size: 7.5pt, fill: muted)[#hex]]
  v(2pt, weak: true)
  text(size: 8.5pt, fill: muted)[#uso]
})
#grid(columns: (1fr,) * 5, column-gutter: 8pt,
  muestra(petroleo, [Petróleo], "#12343B", [Logotipo, títulos y texto]),
  muestra(chispa, [Chispa], "#FF6A3D", [La neurona y los detalles]),
  muestra(brasa, [Brasa], "#C2410C", [Texto destacado]),
  muestra(sinapsis, [Sinapsis], "#2E8B7A", [Diagramas]),
  muestra(niebla, [Niebla], "#F4F7F7", [Fondos]),
)

= Modelo de negocio

Hacemos software de gestión a medida para pymes de sectores tradicionales (agroalimentario, logística, comercio) que aún trabajan con hojas de cálculo o programas antiguos. Lo desarrollamos con IA para acortar plazos y cuidamos sus datos.

#cards(
  (title: [Precio cerrado por proyecto], accent: brasa,
   body: [Pactamos alcance, precio y plazo al inicio. El cliente sabe desde el primer día cuánto le cuesta.]),
  (title: [Cuota mensual de mantenimiento], accent: petroleo,
   body: [Soporte, corrección de errores y actualizaciones. Ingresos recurrentes para nosotros y tranquilidad para el cliente.]),
)

#figure(
  lienzo(s: 1.08, alto: 11.2cm),
  caption: [Lienzo del modelo de negocio de Neuranet.],
)

= Organización

== Estructura y roles

Somos cuatro personas y combinamos dos estructuras:

- *Jerárquica en la responsabilidad.* Una sola persona dirige, planifica y habla con el cliente, así que el cliente siempre sabe a quién dirigirse.
- *Plana en el trabajo.* Las tres áreas colaboran sin intermediarios: los requisitos pasan al diseño y el diseño al desarrollo, como en el Proceso Unificado.

Una jerarquía pura sobraría en un equipo tan pequeño, y una estructura plana dejaría al cliente sin un interlocutor claro. La @organigrama muestra los cargos y las responsabilidades de cada persona.

#figure(organigrama(), caption: [Organigrama de Neuranet: cargos y responsabilidades.], placement: auto) <organigrama>

== Cómo trabajamos

Trabajamos en formato híbrido, con oficina en Madrid, y vemos al cliente en sus instalaciones o por videollamada. Cada reunión queda en un acta.

Como empresa nueva, aún no tenemos una metodología fija. En AñadaMaster usaremos orientación a objetos y el Proceso Unificado. Al terminar, lo compararemos con otras metodologías para elegir la nuestra.

= Casos de uso

Hay un diagrama por programa, porque CoreReservas y CoreBodega tienen usuarios y opciones distintos. La especificación completa de cada caso de uso (actores, precondiciones, flujos y postcondiciones) está en los ficheros de se-ramify, en la carpeta `diagramas/`.

- *Un caso de uso por opción del menú.* Las operaciones de cada opción (alta, modificar, baja o anular) están en la tabla y en su especificación.
- *Actores.* En CoreReservas, el Personal es el actor principal y el Administrador hereda de él, porque tienen los mismos privilegios. En CoreBodega solo actúa el Administrador. El cliente de la bodega no es actor: llama por teléfono y el personal registra sus pedidos.
- *«include» y «extend».* Un «include» se ejecuta siempre: las búsquedas compartidas y _Registrar responsable de la operación_. Un «extend» solo si se cumple una condición: si el cliente no existe al dar de alta un pedido, se da de alta en ese momento.
- *Confirmar y validar* son el último paso de cada operación, no casos de uso.

#callout(title: [Cambios tras la reunión con el cliente del 16 de octubre (acta NN-AM-ACT-01)], accent: brasa)[
  - _Imprimir factura_ pasa a _Generar factura_: es su primer sistema de facturación.
  - Pedido: reservado › confirmado › facturado › enviado › cerrado. Solo se anula antes de facturar.
  - Ficha de cliente: residencial o industrial, con NIF o CIF.
  - Entrada de uva: peso, variedad y grado de azúcar. No hay devoluciones: la uva que no llega al mínimo se tira.
  - La producción queda para versiones posteriores.
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

#figure(usecase-diagram(reservas), caption: [Casos de uso de CoreReservas.])

#[#set text(size: 9pt); #cu-tabla(reservas)]

== CoreBodega

#figure(usecase-diagram(bodega), caption: [Casos de uso de CoreBodega.])

#[#set text(size: 9pt); #cu-tabla(bodega)]

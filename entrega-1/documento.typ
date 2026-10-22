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

Somos Neuranet, una empresa de software de Madrid. Hacemos programas de gestión a medida para pymes y usamos la IA para hacerlos en menos tiempo.

== Nuestro nombre

Neuranet sale de juntar "neura", por las redes neuronales, y "net", red. Trabajamos con LLM, aprendizaje automático y redes neuronales, y nos gusta estar al día de lo que va saliendo.

== Valores

#cards(
  (title: [Innovación], accent: brasa,
   body: [Probamos las herramientas nuevas que van saliendo y nos quedamos con las que de verdad ayudan al cliente.]),
  (title: [Integridad], accent: petroleo,
   body: [Los datos de cada cliente son suyos. Usamos la IA sin poner en riesgo su privacidad.]),
  (title: [Flexibilidad], accent: sinapsis,
   body: [Cada empresa trabaja a su manera, así que adaptamos el software a ella y no al revés.]),
)

== Nuestra marca

#figure(image("/templates/logo-full.svg", width: 8cm), caption: [Logotipo de Neuranet.])

El logotipo es la propia palabra. La "N" dibuja una red neuronal muy sencilla: entra la necesidad del cliente, se enciende la neurona (nuestro trabajo) y sale el software. La "a" lleva la misma neurona. Nuestro lema es _Soluciones de IA a tu medida_.

Usamos Sora para los títulos, IBM Plex Sans para el texto e IBM Plex Mono para el código, con estos cinco colores:

#let muestra(c, nombre, hex, uso) = block(width: 100%, breakable: false, {
  set par(justify: false, leading: 0.4em)
  block(width: 100%, height: 1.1cm, fill: c, stroke: 0.5pt + hairline, below: 5pt)
  text(weight: 700, fill: petroleo, size: 9.5pt)[#nombre]
  v(3pt, weak: true)
  text(font: monofont, size: 7.5pt, fill: brasa)[#hex]
  v(3pt, weak: true)
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

Nuestros clientes son pymes del sector agroalimentario, la logística o el comercio que todavía se apañan con hojas de cálculo o con programas que se han quedado viejos. Les hacemos un programa pensado para su forma de trabajar. Como desarrollamos con ayuda de IA tardamos menos, y cuidamos mucho sus datos.

#block(breakable: false)[
Cobramos de dos formas:

#cards(
  (title: [Precio cerrado por proyecto], accent: brasa,
   body: [Al empezar acordamos qué se hace, cuánto cuesta y cuándo se entrega. Así no hay sorpresas.]),
  (title: [Cuota mensual de mantenimiento], accent: petroleo,
   body: [Con el programa ya en marcha, seguimos dando soporte, arreglando errores y actualizándolo.]),
)
]

#figure(
  lienzo(s: 1.08, alto: 11.2cm),
  caption: [Lienzo del modelo de negocio de Neuranet.],
)

= Organización

== Estructura y roles

Somos cuatro, así que no tenía sentido montar una jerarquía con varios niveles. Tampoco queríamos una estructura del todo plana, porque el cliente tiene que saber a quién llamar. Al final hemos mezclado las dos:

- Itziar, como CEO y Project Manager, dirige el proyecto y es la persona de contacto con el cliente.
- Samuel, Javier y Diego llevan los requisitos, el diseño y el desarrollo. Trabajan juntos y se pasan el trabajo directamente, sin tener que pasar por ella para cada cosa.

En la @organigrama se ve qué hace cada uno.

#figure(organigrama(), caption: [Organigrama de Neuranet.], placement: auto) <organigrama>

== Cómo trabajamos

Trabajamos en modo híbrido: tenemos oficina en Madrid y parte de la semana trabajamos desde casa. Con el cliente nos vemos en sus instalaciones o por videollamada, y de cada reunión sale un acta.

Como somos una empresa nueva, todavía no tenemos una metodología fija. En AñadaMaster vamos a usar orientación a objetos y el Proceso Unificado. Cuando acabemos, veremos qué tal ha ido y lo compararemos con otras metodologías antes de quedarnos con una.

= Casos de uso

AñadaMaster son dos programas: CoreReservas, para los pedidos de los clientes, y CoreBodega, para la entrada de uva y los empleados. Los usan personas distintas, así que hay un diagrama para cada uno. La especificación completa de cada caso de uso (precondiciones, pasos y alternativas) está en los ficheros de la carpeta `diagramas/`.

Para leer los diagramas conviene saber esto:

- Cada opción del menú es un caso de uso. Lo que se puede hacer dentro de cada opción (dar de alta, modificar, dar de baja o anular) está en las tablas.
- CoreReservas lo usa el personal de la bodega. El administrador puede hacer lo mismo que ellos, por eso en el diagrama hereda de Personal. CoreBodega solo lo usa el administrador.
- Los clientes de la bodega no aparecen porque no usan el programa: llaman por teléfono y es el personal quien apunta el pedido.
- Un «include» es un paso que se hace siempre, como buscar el pedido antes de facturarlo. Un «extend» solo pasa a veces: si al hacer un pedido el cliente no existe, se le da de alta en ese momento.
- Confirmar y validar no son casos de uso aparte. Son el último paso de cada operación.

#callout(title: [Lo que cambió después de la reunión del 16 de octubre], accent: brasa)[
  - Imprimir factura pasa a ser Generar factura. AñadaMaster va a ser el primer sistema de facturación de la bodega, así que la factura tiene que quedar guardada.
  - Un pedido pasa por estos estados: reservado, confirmado, facturado, enviado y cerrado. Solo se puede anular antes de facturarlo.
  - En la ficha del cliente se indica si es residencial o industrial y su NIF o CIF.
  - Cuando entra uva se apuntan el peso, la variedad y el grado de azúcar. No hay devoluciones: si la uva no llega al grado mínimo, se tira.
  - La parte de producción se deja para más adelante.

  Todo está recogido en el acta NN-AM-ACT-01.
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

// ============================================================
//  Entrega 2 · Documento (UML, mapa de stakeholders y visión)
//  Compilar desde la raíz del repo:
//    ./templates/compilar.sh entrega-2/documento.typ
//  Los diagramas se leen de diagramas/ (los mismos ficheros que se
//  abren en se-ramify): si cambias un diagrama, el PDF cambia con él.
// ============================================================

#import "/templates/lib.typ": *
#import "/templates/neuranet-uml.typ": *
#import "comun.typ": *

#show: neuranet-doc.with(
  doc-type: [Análisis y diseño],
  title: [AñadaMaster],
  subtitle: [Visión, stakeholders y modelos UML del sistema],
  client: [Bodegas Viña Alcorza],
  project: [AñadaMaster],
  reference: "NN-AM-002",
  version: "1.0",
  status: [Final],
  date: "12 de noviembre de 2026",
  author: "Itziar Morales Rodriguez · Samuel Porta Boylan · Javier Cejuela García · Diego Herrera Rodríguez",
  short-title: [AñadaMaster · Análisis y diseño],
  chapter-break: false,
)

#outline(title: [Índice], depth: 2)
#v(1cm)
#version-history(
  ("1.0", "12/11/2026", "Neuranet", [Visión, mapa de stakeholders, casos de uso con su especificación, modelo de dominio, diseño de clases, estados del pedido y diagramas de secuencia.]),
)
#pagebreak()

= Qué hay en este documento

En la propuesta inicial (NN-AM-001) os presentamos Neuranet y los casos de uso de AñadaMaster. Aquí damos el siguiente paso: explicamos qué queremos conseguir con el sistema, quién está implicado y cómo va a funcionar por dentro.

#cards(
  (title: [Visión], accent: chispa, body: [Qué es AñadaMaster y por qué os va a ayudar, en un párrafo.]),
  (title: [Stakeholders], accent: brasa, body: [Todas las personas y organizaciones a las que afecta el proyecto, y cómo vamos a tratar con cada una.]),
  (title: [Modelos UML], accent: sinapsis, body: [Casos de uso con su especificación, clases, estados del pedido y una secuencia por cada opción del menú.]),
)

Todo parte de lo que hablamos en la reunión del 16 de octubre (acta NN-AM-ACT-01). Algunas dudas quedaron abiertas. Para poder avanzar hemos supuesto la respuesta más razonable y la hemos marcado con un código (S-01, S-02…). Están todas juntas en el @supuestos, para que nos digáis si estáis de acuerdo.

= Visión del producto

Antes de entrar en los detalles, esta es la idea de AñadaMaster en pocas líneas. Seguimos la plantilla del _elevator pitch_: lo que contaríamos en un minuto, el tiempo de un viaje en ascensor.

#vision-pitch(vision)

Dicho de otra forma: hoy, si el ordenador de la oficina falla, la bodega no puede tomar pedidos. Con AñadaMaster los pedidos, las facturas y la entrada de uva están en un sistema que sigue funcionando aunque falle un equipo, y que está hecho para cómo trabajáis vosotros.

= Mapa de stakeholders

Un _stakeholder_ es cualquier persona u organización a la que el proyecto le afecta, o que puede afectar al proyecto. Hemos identificado #stakeholders.data.stakeholders.len(). Los mostramos en los dos formatos habituales:

- *La cebolla* los ordena por lo cerca que tienen que estar del proyecto: en el centro, a los que es vital involucrar; fuera, a los que basta con informar. Además, los divide en decisores, clientes, influyentes y proveedores.
- *La matriz de poder e interés* nos dice cómo tratar con cada uno: a quién gestionar de cerca, a quién mantener satisfecho, a quién informar y a quién solo vigilar.

Cada número es el mismo stakeholder en las dos figuras y en la tabla. El color es su actitud hacia el proyecto.

#figure(
  grid(columns: (1fr, 1fr), column-gutter: 0.6cm, align: horizon,
    stakeholder-onion(stakeholders, side: 7.6cm, size: 6.6pt),
    stakeholder-grid(stakeholders, side: 7.2cm, size: 6.2pt)),
  caption: [Los stakeholders de AñadaMaster: la cebolla (izquierda) y la matriz de poder e interés (derecha). #stakeholder-legend(size: 7.5pt)],
) <stakeholders>

#stakeholder-table(stakeholders)

Lo que sacamos de este mapa:

- *Hay que gestionar de cerca a la dirección, a vuestro representante y a los administradores.* Con ellos validamos cada entrega. A los administradores les enseñaremos las pantallas de CoreBodega antes de la vendimia, que es cuando más se usa.
- *El personal de oficina tiene mucho interés pero poco poder.* Les mantendremos informados y les formaremos antes del cambio, para que el sistema nuevo no les haga ir más lentos al teléfono.
- *Hacienda y la protección de datos no participan en el día a día, pero pueden obligarnos a cambiar cosas.* Por eso las facturas y los datos personales se tienen en cuenta desde el diseño.

= Casos de uso

AñadaMaster son dos programas: *CoreReservas*, para los clientes, los pedidos y las facturas, y *CoreBodega*, para la entrada de uva y los empleados. Cada opción del menú es un caso de uso. Lo que se puede hacer dentro de cada opción (dar de alta, modificar, dar de baja…) está en su especificación.

Desde la propuesta inicial hemos cambiado algunas cosas: las facturas pueden juntar varios pedidos, la entrada de uva se registra por líneas (una por variedad) y nada que tenga historial se borra del todo.

== CoreReservas

#figure(usecase-diagram(reservas), caption: [Casos de uso de CoreReservas.])

#especificaciones(reservas)

== CoreBodega

#figure(usecase-diagram(bodega), caption: [Casos de uso de CoreBodega.])

#especificaciones(bodega)

== Supuestos pendientes de confirmar <supuestos>

Estas son las dudas que quedaron abiertas en la reunión y lo que hemos supuesto para cada una. Si alguna no es correcta, la cambiamos en la siguiente versión.

#tabla-supuestos()

= Modelo de dominio

El modelo de dominio recoge los conceptos de vuestro negocio y cómo se relacionan: qué datos tiene un pedido, a quién pertenece, qué lleva dentro… Todavía no habla de programación, por eso no lleva tipos de datos ni operaciones.

#class-legend()

== CoreReservas

#figure(class-diagram(dominio-reservas, max-height: 14cm), caption: [Modelo de dominio de CoreReservas.])

- Un *cliente* es residencial (con NIF) o industrial (con CIF y razón social). Por eso hay una clase para cada tipo, y las dos comparten lo común.
- Un *pedido* es de un cliente y tiene una o más *líneas*. Cada línea es un vino y una cantidad, y guarda el precio del momento, para que un cambio de precio no altere los pedidos antiguos. Si se borra el pedido, se borran sus líneas.
- Una *factura* junta uno o varios pedidos del mismo cliente, y cada pedido se factura una sola vez.
- El *estado* del pedido solo puede tomar los valores acordados en la reunión, más «anulado».

== CoreBodega

#figure(class-diagram(dominio-bodega, max-height: 14cm), caption: [Modelo de dominio de CoreBodega.])

- La *materia prima* es la entrada de un remolque. Su *detalle* son las líneas, una por variedad, con el peso y el grado de azúcar (S-05).
- Cada *variedad* tiene su grado mínimo. Si una línea no llega, se marca como no aceptada y esa uva va a abono.
- Cada operación deja un *registro*: quién la hizo, cuándo y sobre qué. Así se cumple lo que pide el encargo: que quede constancia de qué usuario hizo cada gestión.
- Los *empleados* son administradores o personal, igual que en los casos de uso, y son también los usuarios de los dos programas (S-01).

= Diseño

== Clases de diseño

El diagrama de diseño parte del modelo de dominio y añade lo que hace falta para programarlo: el tipo de cada dato, qué se puede hacer con cada clase y qué es público (+) o privado (-). Además aparece una *clase de control* por cada opción del menú, en verde. Es la que recibe lo que el usuario hace en la pantalla y coordina el trabajo, como se ve en los diagramas de secuencia.

#page(flipped: true)[
  #figure(class-diagram(diseno-reservas, max-height: 15.2cm), caption: [Diagrama de clases de diseño de CoreReservas.])
]
#page(flipped: true)[
  #figure(class-diagram(diseno-bodega, max-height: 15.2cm), caption: [Diagrama de clases de diseño de CoreBodega.])
]

Las pantallas no aparecen en estos diagramas para no cargarlos: hay una por opción del menú y solo hablan con su control. _DatosProducto_, _DatosCliente_ y las demás clases de datos son lo que se rellena en cada formulario.

== Estados del pedido

Un pedido pasa por varios estados desde que el cliente llama hasta que lo recibe. El diagrama recoge lo acordado en la reunión: se reserva, se confirma, se factura, se envía y se cierra. Solo se puede modificar o anular antes de facturarlo.

#figure(state-diagram(estados, max-scale: 1.0), caption: [Ciclo de vida de un pedido.])

= Diagramas de secuencia

Hay un diagrama por opción del menú. Cada uno muestra, paso a paso, qué pasa dentro del sistema cuando el usuario usa esa opción, con todas sus operaciones (alta, modificación, baja…) en fragmentos `alt`. Los mensajes están numerados en orden.

En todos aparecen las mismas piezas: el usuario, la *pantalla* (_boundary_), el *control* de esa opción, las *entidades* del modelo y la *base de datos*. Los recuadros `ref` remiten a otro caso de uso (por ejemplo, buscar un cliente), que no se repite en cada diagrama.

#for (i, s) in secuencias.enumerate() {
  pagebreak(weak: true)
  [== #s.opcion (#s.cu)]
  s.texto
  figure(sequence-diagram(s.d, max-height: 19.5cm), caption: [Secuencia de la opción #s.opcion (#s.cu).])
}

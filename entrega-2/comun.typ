// Piezas compartidas por el documento y las diapositivas de la Entrega 2:
// los diagramas (leídos de diagramas/) y los supuestos.
#import "/templates/lib.typ": *

// ---------------- Diagramas de se-ramify ----------------
#let reservas = json("/diagramas/usecase-casos-de-uso-corereservas-0f712f.json")
#let bodega = json("/diagramas/usecase-casos-de-uso-corebodega-b0c308.json")
#let dominio-reservas = json("/diagramas/class-modelo-de-dominio-corereservas-82b804.json")
#let dominio-bodega = json("/diagramas/class-modelo-de-dominio-corebodega-370276.json")
#let diseno-reservas = json("/diagramas/class-diseno-corereservas-b50d3f.json")
#let diseno-bodega = json("/diagramas/class-diseno-corebodega-a68a8d.json")
#let estados = json("/diagramas/state-ciclo-de-vida-del-pedido-0515f7.json")
#let stakeholders = json("/diagramas/stakeholder-stakeholders-de-anadamaster-16d39a.json")
#let vision = json("/diagramas/vision-vision-de-anadamaster-dbb3e0.json")

// Una secuencia por opción del menú, en el orden del menú
#let secuencias = (
  (cu: "CU-02", opcion: [Producto], d: json("/diagramas/sequence-producto-989c34.json"),
   texto: [Alta y modificación. El control valida los datos antes de crear o guardar el producto.]),
  (cu: "CU-03", opcion: [Cliente], d: json("/diagramas/sequence-cliente-56c282.json"),
   texto: [Alta, modificación y baja. En el alta se comprueba que el NIF o CIF no esté repetido; en la baja, si el cliente tiene pedidos, se marca como dado de baja en lugar de borrarlo (S-03).]),
  (cu: "CU-04", opcion: [Pedido], d: json("/diagramas/sequence-pedido-09bc30.json"), partir: "Modificar",
   texto: [Alta, confirmación, modificación, cambio a enviado o cerrado y anulación. Antes de modificar o anular, el pedido comprueba que todavía no está facturado.]),
  (cu: "CU-05", opcion: [Pedido Detalle], d: json("/diagramas/sequence-detalle-de-pedido-eb2658.json"),
   texto: [El usuario añade, cambia o quita líneas en pantalla, y todo se aplica a la vez con el botón «Aplicar cambios».]),
  (cu: "CU-06", opcion: [Factura], d: json("/diagramas/sequence-factura-a8354b.json"),
   texto: [Se eligen uno o varios pedidos confirmados del mismo cliente; la factura calcula sus importes, los pedidos pasan a facturados y la factura se guarda y se imprime.]),
  (cu: "CU-21", opcion: [MateriaPrima], d: json("/diagramas/sequence-materia-prima-aa59e3.json"),
   texto: [Ingresar y eliminar entradas de uva. Cada operación deja un registro con el administrador que la hizo (CU-26).]),
  (cu: "CU-22", opcion: [Detalle Materia Prima], d: json("/diagramas/sequence-detalle-materia-prima-7bf47b.json"),
   texto: [Una línea por variedad. Cada línea se compara con el grado mínimo de su variedad para saber si la uva se acepta o va a abono.]),
  (cu: "CU-23", opcion: [Personal], d: json("/diagramas/sequence-empleado-316de7.json"),
   texto: [Alta, modificación y baja de empleados. La baja es lógica (S-04): el empleado ya no puede entrar, pero su historial de operaciones se conserva.]),
)

// ---------------- Supuestos ----------------
// Dudas que quedaron abiertas en la reunión del 16/10 (acta NN-AM-ACT-01)
// y lo que hemos supuesto para poder modelar. Se confirmarán con el cliente.
#let supuestos = (
  ("S-01", [¿Cómo se identifican los trabajadores?], [Los empleados son los usuarios de los dos programas. Cada uno entra con su usuario y su contraseña.]),
  ("S-02", [¿Qué se hace con un vino que ya no se vende?], [Los productos no se borran porque aparecen en pedidos y facturas antiguos. Se marcan como inactivos y ya no se pueden pedir.]),
  ("S-03", [¿Se puede borrar un cliente con pedidos?], [Si no tiene pedidos, se borra. Si los tiene, se marca como dado de baja, porque sus facturas se tienen que conservar.]),
  ("S-04", [¿Qué pasa al dar de baja a un empleado?], [Se queda inactivo y ya no puede entrar, pero no se borra, para no perder quién hizo cada operación.]),
  ("S-05", [¿Qué es el detalle de la materia prima?], [La materia prima es la entrada de un remolque. Su detalle son las líneas: cada variedad con su peso y su grado de azúcar.]),
  ("S-06", [¿Quién da de alta al primer administrador?], [Neuranet, al instalar el sistema. A partir de ahí, los administradores dan de alta al resto.]),
  ("S-07", [¿Quién marca un pedido como enviado o cerrado?], [El personal, desde Pedido: enviado cuando sale de la bodega y cerrado cuando el cliente lo recibe.]),
  ("S-08", [¿Qué se guarda de cada operación de CoreBodega?], [El empleado, la fecha y la hora, el tipo de operación (alta, modificación o baja) y el registro afectado.]),
  ("S-09", [¿Por qué datos se busca?], [Clientes por NIF o CIF, nombre o código; pedidos por número, cliente o fecha; entradas de uva por número, fecha o procedencia; empleados por nombre, DNI o código.]),
  ("S-10", [¿Quién valida las operaciones de CoreBodega?], [El mismo administrador que las introduce: validar es el último paso antes de guardar.]),
  ("S-11", [¿El personal puede usar CoreBodega?], [No. CoreBodega es solo para administradores, como en la Entrega 1. Los administradores sí pueden usar CoreReservas.]),
  ("S-12", [¿El detalle del pedido se mete a la vez que el pedido?], [No. Primero se da de alta el pedido y después se le añaden las líneas desde Pedido Detalle, como en el menú del encargo.]),
  ("S-13", [PayPal, móvil o tablet en la bodega, producción], [Quedan fuera de esta primera versión. Se pueden añadir más adelante sin cambiar el modelo.]),
)

#let tabla-supuestos(size: 9pt) = {
  set text(size: size)
  neuranet-table(columns: (auto, 1fr, 1.6fr), inset: (x: 7pt, y: 5pt),
    header: ([Código], [Duda abierta], [Qué suponemos]),
    ..supuestos.map(((c, q, a)) => (text(font: monofont, size: size * 0.9, fill: brasa, c), q, a)).flatten())
}

// ---------------- Especificación de un caso de uso ----------------
#let especificacion(n, size: 8.8pt) = {
  let s = n.spec
  let lines(t) = t.split("\n").filter(l => l.trim() != "")
  let campo(nombre, cuerpo) = (text(weight: 700, fill: petroleo, nombre), cuerpo)
  block(breakable: false, width: 100%, below: 1.1em, {
    block(width: 100%, fill: petroleo, inset: (x: 9pt, y: 6pt), below: 0pt,
      text(fill: white, weight: 700, size: size * 1.08)[#text(font: monofont, fill: chispa)[#s.code] #h(4pt) #n.label.replace("\n", " ")])
    set text(size: size)
    set par(justify: false, leading: 0.5em)
    table(columns: (3.3cm, 1fr), stroke: (x, y) => (bottom: 0.4pt + hairline), inset: (x: 8pt, y: 5pt),
      fill: (x, y) => if x == 0 { niebla } else { white },
      ..campo([Actor principal], s.primaryActor),
      ..if s.at("secondaryActors", default: "") != "" { campo([Otros actores], s.secondaryActors) } else { () },
      ..campo([Descripción], s.description),
      ..campo([Precondiciones], lines(s.preconditions).join(linebreak())),
      ..campo([Disparador], s.trigger),
      ..campo([Flujo principal], enum(tight: true, spacing: 0.45em, ..lines(s.mainFlow))),
      ..campo([Flujos alternativos], list(tight: true, spacing: 0.45em, ..lines(s.alternativeFlows))),
      ..campo([Postcondiciones], s.postconditions),
    )
  })
}
#let especificaciones(d) = {
  for n in d.data.nodes.filter(n => n.type == "usecase").sorted(key: n => n.spec.code) { especificacion(n) }
}

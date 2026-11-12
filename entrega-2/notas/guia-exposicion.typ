// ============================================================
//  Guías para la exposición y la defensa de la Entrega 2: una por persona
//  Compilar desde la raíz del repo (una por persona):
//    typst compile --root . --font-path templates/fonts \
//      --input quien=diego entrega-2/notas/guia-exposicion.typ entrega-2/notas/guia-diego.pdf
//    (y lo mismo con quien=javier, quien=samuel, quien=itziar)
//  No empieza con «#show:» a propósito: así GitHub Actions no lo compila
//  sin persona (lo haría con compilar-todo.sh).
//  Las miniaturas salen de presentacion.pdf:
//    pdftoppm -r 90 -png entrega-2/presentacion.pdf entrega-2/notas/img/d
// ============================================================

#import "/templates/lib.typ": *


// Una diapositiva: miniatura a la izquierda; qué decir, por qué y posibles preguntas a la derecha
#let diapo(n, titulo, decir, porque: none, preguntas: ()) = block(breakable: false, width: 100%, below: 0.9cm, {
  grid(columns: (6.4cm, 1fr), column-gutter: 0.55cm, align: top,
    {
      block(stroke: 0.5pt + hairline, image("img/d-" + (if n < 10 { "0" } else { "" }) + str(n) + ".png", width: 100%))
    },
    {
      set par(justify: false, leading: 0.55em)
      text(font: headingfont, weight: 700, size: 11.5pt, fill: petroleo)[#text(fill: brasa)[#n] #h(3pt) #titulo]
      v(0.15cm)
      text(size: 8pt, weight: 700, fill: muted, tracking: 0.5pt)[QUÉ DECIR]
      v(0.05cm, weak: true)
      set text(size: 9.5pt)
      decir
      if porque != none {
        v(0.1cm)
        text(size: 8pt, weight: 700, fill: muted, tracking: 0.5pt)[POR QUÉ ESTÁ ASÍ]
        v(0.05cm, weak: true)
        porque
      }
    })
  if preguntas.len() > 0 {
    v(0.2cm)
    block(width: 100%, fill: niebla, inset: (x: 10pt, y: 7pt), stroke: (left: 3pt + brasa), {
      set text(size: 9pt); set par(justify: false)
      for (p, r) in preguntas { [*#p* #h(3pt) #r]; linebreak() }
    })
  }
})

#let pr(p, r) = block(breakable: false, below: 0.45cm, { text(weight: 700)[#p]; linebreak(); text(fill: rgb("#3B5359"))[#r] })


#let reparto = [
= Cómo nos repartimos

La exposición dura unos *10 minutos* (el enunciado pide entre 5 y 15). Presentan Diego y Javier, porque Itziar y Samuel ya presentaron la E1 y cada uno tiene que presentar alguna vez durante el curso. En las preguntas, cada uno responde de la parte que revisó.

#neuranet-table(columns: (auto, 1.3fr, 1.3fr), inset: (x: 8pt, y: 6pt),
  header: ([], [Exposición], [Responde en la defensa]),
  [*Diego*], [Diapositivas 1–9: visión, stakeholders, casos de uso y supuestos (≈ 5 min)], [La visión; las secuencias de Factura y de CoreBodega],
  [*Javier*], [Diapositivas 10–18: clases, estados y secuencias (≈ 5 min)], [Clases (dominio y diseño) y estados],
  [*Samuel*], [— (plan B: diapositivas 1–9)], [Casos de uso, fichas, supuestos y stakeholders],
  [*Itziar*], [—], [Secuencias de CoreReservas, decisiones generales y la E3],
)

#callout(title: [Plan B: si no viene Diego], accent: brasa)[
  - *Samuel* presenta las diapositivas 1–9. Es su parte como analista y la ha revisado él. Al empezar, dice que presenta en lugar de Diego (en la esquina de las diapositivas pone «Diego»).
  - *Javier* presenta lo mismo: diapositivas 10–18.
  - Las preguntas de Diego se reparten: la *visión*, Samuel; las *secuencias* de Factura y CoreBodega, Javier.
]

*Consejos para la exposición*
- No leáis las diapositivas: cada una tiene pocas palabras a propósito. Contad lo de «Qué decir» con vuestras palabras.
- Los diagramas grandes no se explican caja a caja: decid la idea y señalad dos o tres cosas.
- Si os preguntan algo que no sabéis, decid quién de nosotros lo lleva y que conteste esa persona.


]

#let diapos-1-9 = [
= Diapositivas 1–9 · visión, stakeholders y casos de uso

#diapo(1, [Portada], [
  - Buenos días. Somos *Neuranet* y presentamos la segunda entrega de *AñadaMaster* para *Bodegas Viña Alcorza*.
  - Presentamos Diego y Javier.
])

#diapo(2, [Índice], [
  - Cinco partes. Diego cuenta la visión, los stakeholders y los casos de uso; Javier, las clases, los estados y las secuencias.
])

#diapo(3, [AñadaMaster en un minuto], [
  - Es la *visión del producto* con la plantilla del *elevator pitch* del Tema 5: lo que contaríamos en un viaje en ascensor.
  - Leed la frase completa de seguido: *Para* la bodega, *que* hoy depende de un ordenador que se cae y no tiene facturación, AñadaMaster *es* un sistema de gestión para bodegas *que* reúne pedidos, facturas y entrada de uva. *A diferencia de* su aplicación actual o de un Excel, no se para si falla un equipo y entiende de vino.
], porque: [
  La rúbrica pide la visión «con el modelo elevator pitch», así que seguimos la plantilla de Moore campo a campo. El «a diferencia de» es lo que la distingue de una simple descripción.
], preguntas: (
  ([¿Dónde está la IA?], [Neuranet desarrolla con IA. AñadaMaster no es un producto de IA; en la entrega final daremos el material para que el cliente cambie su app con IA.]),
))

#diapo(4, [Quién está implicado], [
  - Hemos identificado *11 stakeholders* (el mínimo era 6).
  - Están en los *dos formatos del Tema 3*: la *cebolla* (izquierda) dice lo cerca que tienen que estar del proyecto; la *matriz* (derecha) cruza poder e interés.
  - Cada número es el mismo stakeholder en las dos figuras. El color es su actitud: verde a favor, gris neutral.
], porque: [
  Los dos formatos dicen cosas distintas: la cebolla, a quién involucrar; la matriz, cómo tratar a cada uno. Así no queda duda de cuál de los dos formatos quería el profesor.
])

#diapo(5, [Qué hacemos con cada uno], [
  - *Gestionar de cerca*: la dirección, su representante y los administradores. Validan cada entrega.
  - *Mantener informados*: personal de oficina, clientes y viticultores. Formación antes del cambio.
  - *Mantener satisfechos*: Hacienda y protección de datos. Tienen poder aunque no participen.
], preguntas: (
  ([¿Por qué Hacienda tiene tanto poder?], [Porque AñadaMaster será su primer sistema de facturación y Hacienda puede obligarnos a cambiarlo.]),
))

#diapo(6, [CoreReservas: 8 casos de uso], [
  - AñadaMaster son dos programas; este es el de clientes, pedidos y facturas.
  - *Una opción del menú = un caso de uso*. Alta, modificar y baja van dentro de su ficha.
  - El *Personal* es quien más lo usa; el *Administrador* hereda de él porque tiene los mismos permisos.
  - *include* = siempre (buscar cliente o pedido). *extend* = solo a veces (dar de alta al cliente si no existe al hacer el pedido).
], porque: [
  Generar factura ahora incluye *Buscar cliente* (antes, Buscar pedido) porque una factura puede juntar varios pedidos del mismo cliente.
])

#diapo(7, [CoreBodega: 7 casos de uso], [
  - Lo usa solo el *Administrador*.
  - Entrada de uva (materia prima), su detalle y los empleados.
  - *Registrar responsable* se incluye en todas las operaciones: queda quién hizo cada cosa, como pide el enunciado.
])

#diapo(8, [Cada caso de uso, especificado], [
  - Los *15 casos de uso* tienen su ficha completa en el documento: actor, precondiciones, disparador, pasos, flujos alternativos y postcondiciones.
  - Enseñad el ejemplo de *Generar factura*: elige pedidos confirmados de un cliente, la guarda, la imprime y los pedidos pasan a facturados.
])

#diapo(9, [Lo que hemos supuesto], [
  - En la reunión del 16 de octubre quedaron *dudas abiertas*. Para poder avanzar, hemos supuesto la respuesta más razonable y la hemos numerado (*S-01 a S-13*).
  - Ejemplo: *nada que tenga historial se borra del todo*. Un vino que ya no se vende, un cliente con pedidos o un empleado que se va se marcan como inactivos.
  - Se confirmarán con el cliente en la próxima reunión.
  - Cierre: «Javier os cuenta las clases y las secuencias».
])


]

#let diapos-10-18 = [
= Diapositivas 10–18 · clases, estados y secuencias

#diapo(10, [Modelo de dominio · CoreReservas], [
  - El *modelo de dominio* recoge los conceptos del negocio y cómo se relacionan. No lleva tipos ni operaciones: eso va en el diseño.
  - Cliente *residencial* (NIF) o *industrial* (CIF): herencia.
  - Un *pedido* tiene una o más *líneas*: un vino y una cantidad (composición).
  - Una *factura* junta uno o varios pedidos del mismo cliente.
], porque: [
  La línea guarda el precio del momento, para que un cambio de precio no altere los pedidos antiguos. Composición: si se borra el pedido, se borran sus líneas.
])

#diapo(11, [Modelo de dominio · CoreBodega], [
  - *MateriaPrima* es la entrada de un remolque; su *detalle* son las líneas, una por variedad, con peso y grado de azúcar.
  - Cada *variedad* tiene su grado mínimo: si una línea no llega, esa uva va a abono.
  - *RegistroOperacion* guarda quién hizo qué y cuándo.
  - *Empleado* → Administrador y Personal, igual que en los casos de uso.
])

#diapo(12, [Diseño · CoreReservas], [
  - Las mismas entidades, ahora con *tipos, visibilidad* (+ público, − privado) y *operaciones*.
  - En verde, una *clase de control* por opción del menú: recibe lo que hace el usuario en la pantalla y coordina el trabajo.
  - Las pantallas no salen para no cargar el diagrama: hay una por opción y solo hablan con su control.
], porque: [
  Es el estilo *boundary–control–entity* que usamos en las secuencias: cada mensaje de las secuencias es una operación de estas clases.
])

#diapo(13, [Diseño · CoreBodega], [
  - Tres controles, uno por opción del menú. Los tres crean un *RegistroOperacion* en cada alta, cambio o baja.
  - La contraseña se guarda como *hash*, no tal cual.
  - Las bajas son *lógicas*: el empleado deja de poder entrar, pero no se pierde quién hizo cada operación.
])

#diapo(14, [Ciclo de vida de un pedido], [
  - Es el *diagrama de estados* del pedido, con lo que acordamos con el cliente: reservado → confirmado → facturado → enviado → cerrado.
  - Solo se puede *modificar o anular antes de facturar*.
  - Dos estados finales: el pedido acaba *anulado* o *cerrado*.
], porque: [
  No lo pedía la entrega, pero aclara las reglas del pedido que se repiten en las fichas y en las secuencias.
])

#diapo(15, [Una secuencia por opción del menú], [
  - Hay *8 diagramas de secuencia*, uno por opción del menú; todos están en el documento.
  - Siempre el mismo camino: usuario → *pantalla* → *control* → *entidades* → *base de datos*.
  - Cada operación (alta, modificar, baja…) va en un fragmento *alt*. Un recuadro *ref* remite a otro caso de uso, como buscar un cliente.
])

#diapo(16, [Ejemplo: Factura], [
  - Se buscan los pedidos *confirmados* del cliente.
  - La factura junta *uno o varios* y calcula los importes.
  - Un *loop* pasa cada pedido a facturado; después se guarda y se imprime.
  - Si no hay ningún pedido que se pueda facturar, se avisa.
])

#diapo(17, [Ejemplo: Detalle Materia Prima], [
  - El administrador mete una línea por *variedad* del remolque.
  - Cada línea se compara con el *grado mínimo* de su variedad: si no llega, la uva va a abono.
  - Al final queda *registrado* quién lo hizo.
])

#diapo(18, [Gracias], [
  - «Soluciones de IA a tu medida». ¿Preguntas?
])


]

#let preg-intro = [
#pagebreak(weak: true)
= Tus preguntas de la defensa

Respuestas cortas a lo que pueden preguntar. Si la pregunta es de otra parte, que conteste quien la lleva (tabla de la primera página).


]

#let preg-samuel = [
== Samuel · casos de uso, fichas, supuestos y stakeholders
#pr([¿Por qué alta, modificar y baja no son casos de uso aparte?], [Un caso de uso por opción del menú, como pide el encargo. Las operaciones van en la ficha.])
#pr([¿Qué ha cambiado desde la E1?], [La factura junta varios pedidos y empieza buscando el cliente; el pedido se confirma y se marca como enviado o cerrado; la uva se registra por líneas; nada con historial se borra.])
#pr([¿Diferencia entre include y extend?], [include: siempre (buscar). extend: solo si se cumple una condición (el cliente no existe).])
#pr([¿Por qué hay supuestos?], [Son las dudas abiertas de la reunión. Para no parar, suponemos lo más razonable y lo confirmamos con el cliente.])
#pr([¿Por qué no se borra un cliente con pedidos?], [Sus facturas se tienen que conservar: se marca como dado de baja (S-03).])
#pr([¿Por qué dos formatos de stakeholders?], [Son los dos del Tema 3: la cebolla dice cuánto involucrarlos; la matriz, cómo tratarlos.])


]

#let preg-javier = [
== Javier · clases y estados
#pr([¿Dominio o diseño?], [Dominio: conceptos, sin tipos. Diseño: tipos, visibilidad, operaciones y controles.])
#pr([¿Por qué herencia en Cliente?], [Cada tipo tiene datos propios (NIF, o CIF y razón social). getDocumentoFiscal() es abstracto.])
#pr([¿Por qué composición entre Pedido y LineaPedido?], [Una línea no existe sin su pedido.])
#pr([¿Por qué Factura 0..1 — 1..\* Pedido?], [Una factura junta varios pedidos del mismo cliente; cada pedido se factura una sola vez.])
#pr([¿Por qué RegistroOperacion es una clase?], [El enunciado pide saber quién hizo cada gestión. Guarda quién, cuándo, el tipo y sobre qué.])
#pr([¿Por qué no salen las pantallas?], [Hay una por opción y solo hablan con su control. Salen en las secuencias.])
#pr([¿Enumerado o diagrama de estados?], [Los dos: el enumerado fija los valores; el diagrama, qué cambios se permiten.])


]

#let preg-diego = [
== Diego · visión y secuencias de Factura y CoreBodega
#pr([¿Qué plantilla usa la visión?], [La del elevator pitch de Moore (Tema 5).])
#pr([¿Contra qué os comparáis?], [Su aplicación actual (un ordenador que se cae, sin facturas) y los programas genéricos o Excel.])
#pr([Factura: ¿por qué hay un loop?], [Cada pedido de la factura pasa a facturado, uno a uno.])
#pr([Detalle MP: ¿quién decide si la uva vale?], [Cada línea se compara con el grado mínimo de su variedad.])
#pr([¿Por qué la baja de un empleado es lógica?], [Para no perder quién hizo cada operación (S-04).])


]

#let preg-itziar = [
== Itziar · secuencias de CoreReservas, decisiones generales y la E3
#pr([¿Por qué la pantalla pide confirmación?], [El enunciado dice que hay que confirmar los cambios: pedirConfirmacion() y confirmar().])
#pr([¿Por qué Pedido va en dos páginas?], [Es el mismo diagrama; tiene cinco operaciones y no cabía legible en una página.])
#pr([¿Se puede confirmar un pedido anulado?], [No: solo uno reservado. Si no, aviso.])
#pr([¿Se pueden cambiar las líneas de un pedido facturado?], [No: se avisa al cargarlo y no deja editar.])
#pr([¿Cómo os habéis organizado?], [Cada uno revisó su parte según su rol. Los diagramas están en se-ramify y todo en el repositorio.])
#pr([¿Qué viene en la E3?], [Modelo de desarrollo propio, backlog de épicas y el Proceso Unificado con Gantt y actas. Las dudas abiertas van a una segunda reunión con el cliente.])

]

#let quien = sys.inputs.at("quien", default: "itziar")
#let nombre = (diego: [Diego], javier: [Javier], samuel: [Samuel], itziar: [Itziar]).at(quien)
#let cuerpo = {
  if quien == "diego" { reparto + diapos-1-9 + preg-intro + preg-diego } else if quien == "javier" { reparto + diapos-10-18 + preg-intro + preg-javier } else if quien == "samuel" { reparto + preg-intro + preg-samuel + [#pagebreak() #callout(title: [Plan B], accent: brasa)[Si no viene Diego, presentas tú estas diapositivas. Al empezar, di que presentas en su lugar.]] + diapos-1-9 } else { reparto + preg-intro + preg-itziar + [#pagebreak() #callout(title: [Toda la exposición], accent: petroleo)[Las diapositivas de Diego y de Javier, para que tengas la visión completa y puedas cubrir a cualquiera.]] + diapos-1-9 + diapos-10-18 }
}

#neuranet-breve(
  doc-type: [Guía interna],
  title: [Exposición y defensa de la Entrega 2 · #nombre],
  client: [Equipo de Neuranet],
  project: [AñadaMaster],
  reference: "NN-AM-INT-02",
  date: "12 de noviembre de 2026",
  author: "Neuranet",
  confidential: true,
  contents: true,
  cuerpo,
)

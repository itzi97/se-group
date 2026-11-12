// ============================================================
//  Chuletas para la exposición y la defensa de la Entrega 2 (formato móvil)
//  Compilar desde la raíz del repo, una por persona:
//    typst compile --root . --font-path templates/fonts \
//      --input quien=diego entrega-2/notas/notas.typ entrega-2/notas/chuleta-diego.pdf
//    (y lo mismo con quien=javier, quien=samuel, quien=itziar)
//  Las miniaturas salen de presentacion.pdf:
//    pdftoppm -r 60 -png entrega-2/presentacion.pdf entrega-2/notas/img/d
// ============================================================

#import "/templates/lib.typ": petroleo, brasa, chispa, sinapsis, niebla, muted, headingfont, sansfont

#let quien = sys.inputs.at("quien", default: "diego")

#set page(width: 9cm, height: 16cm, margin: (x: 0.55cm, top: 0.5cm, bottom: 0.6cm), fill: white,
  footer: context align(center, text(size: 8pt, fill: muted)[#counter(page).display() / #counter(page).final().first()]))
#set text(font: sansfont, size: 15pt, fill: petroleo, lang: "es", hyphenate: false)
#set par(justify: false, leading: 0.5em)
#set list(marker: box(baseline: -0.25em, square(size: 0.32em, fill: chispa)), spacing: 0.95em, body-indent: 0.45em)

// Una página por diapositiva: miniatura, título y 3–4 puntos cortos
#let nota(n, titulo, puntos, siguiente: none) = page({
  grid(columns: (auto, 1fr), column-gutter: 6pt, align: horizon,
    box(fill: petroleo, inset: (x: 7pt, y: 4pt), text(fill: white, weight: 700, size: 12pt, font: headingfont)[#n]),
    text(font: headingfont, weight: 700, size: 15pt)[#titulo])
  v(0.25cm)
  block(stroke: 0.5pt + rgb("#C9D6D8"), image("img/d-" + (if n < 10 { "0" } else { "" }) + str(n) + ".png", width: 100%))
  v(0.35cm)
  puntos
  if siguiente != none {
    v(1fr)
    block(width: 100%, fill: niebla, inset: 8pt, stroke: (left: 3pt + brasa),
      text(size: 11.5pt, fill: brasa, weight: 600)[→ #siguiente])
  }
})

#let portada(nombre, partes, tiempo, nota-plan) = page(fill: petroleo, footer: none, {
  set text(fill: white)
  v(1fr)
  image("/templates/logo-full-white.svg", width: 5cm)
  v(0.5cm)
  text(font: headingfont, size: 22pt, weight: 700)[Chuleta de #nombre]
  v(0.2cm)
  text(size: 13pt, fill: rgb("#DCE4E5"))[AñadaMaster · Entrega 2]
  v(0.8cm)
  text(size: 13pt)[#partes]
  v(0.3cm)
  text(size: 13pt, fill: chispa, weight: 600)[#tiempo]
  v(1fr)
  text(size: 10pt, fill: rgb("#DCE4E5"))[#nota-plan]
})

// Página con texto (reparto, plan B, preguntas)
#let hoja(titulo, cuerpo) = page(header: text(font: headingfont, weight: 700, size: 15pt, fill: brasa)[#titulo],
  margin: (x: 0.55cm, top: 1.3cm, bottom: 0.7cm), { set text(size: 12.5pt); cuerpo })

#let pregunta(p, r) = block(width: 100%, below: 0.42cm, breakable: false, {
  text(weight: 700, size: 12.5pt)[#p]
  v(0.12cm, weak: true)
  text(size: 12pt, fill: rgb("#3B5359"))[#r]
})

// ---------------- Reparto (en todas) ----------------
#let reparto = hoja([Reparto], {
  block(below: 0.35cm, text(weight: 700)[Exposición (≈ 10 min)])
  [- *Diego*: diap. 1–9 · visión, stakeholders, casos de uso y supuestos (≈ 5 min)
   - *Javier*: diap. 10–18 · clases, estados y secuencias (≈ 5 min)]
  v(0.3cm)
  block(below: 0.35cm, text(weight: 700)[Preguntas: quién responde])
  [- *Samuel*: casos de uso, fichas, supuestos, stakeholders
   - *Javier*: clases (dominio y diseño), estados
   - *Diego*: visión; secuencias de Factura y CoreBodega
   - *Itziar*: secuencias de CoreReservas, decisiones generales, qué viene en la E3]
  v(0.3cm)
  block(width: 100%, fill: niebla, inset: 8pt, stroke: (left: 3pt + brasa), text(size: 11.5pt)[
    *Si no viene Diego (plan B):* Samuel presenta las diap. 1–9 (es su parte como analista). Javier, igual. Las preguntas de Diego: la visión, Samuel; sus secuencias, Javier.])
})

// ---------------- Diapositivas 1–9 (Diego; Samuel en el plan B) ----------------
#let parte-1(quien-presenta, otro) = {
  nota(1, [Portada], [
    - Buenos días. Somos *Neuranet*
    - Segunda entrega de *AñadaMaster* para *Bodegas Viña Alcorza*
    - Presentamos *#quien-presenta* y *Javier*
  ])
  nota(2, [Índice], [
    - Cinco partes
    - Yo: *visión, stakeholders y casos de uso*
    - Javier: *clases, estados y secuencias*
  ])
  nota(3, [AñadaMaster en un minuto], [
    - Plantilla del *elevator pitch* (Tema 5)
    - *Para* la bodega, *que* depende de un ordenador que se cae y no factura
    - *Es* un sistema de gestión para bodegas: *CoreReservas* + *CoreBodega*
    - *A diferencia de* su app actual o un Excel: no se para y entiende de vino
  ])
  nota(4, [Quién está implicado], [
    - *11 stakeholders*, el mismo número en las dos figuras
    - *Cebolla*: lo cerca que tienen que estar
    - *Matriz*: poder frente a interés
    - Color = *actitud* (a favor / neutral)
  ])
  nota(5, [Qué hacemos con cada uno], [
    - *De cerca*: dirección, su representante, administradores
    - *Informados*: personal de oficina, clientes, viticultores
    - *Satisfechos*: Hacienda y protección de datos
  ])
  nota(6, [CoreReservas], [
    - Una *opción del menú* = un caso de uso
    - *Personal*; el *Administrador* hereda (mismos permisos)
    - *include*: buscar cliente / pedido
    - *extend*: alta de cliente si no existe al pedir
  ])
  nota(7, [CoreBodega], [
    - Solo el *Administrador*
    - Materia prima, su detalle y empleados
    - *Registrar responsable*: queda quién hizo qué
  ])
  nota(8, [Fichas], [
    - *15 casos de uso*, todos con su ficha
    - Actor, precondiciones, *pasos*, alternativos, postcondiciones
    - Ejemplo: *Generar factura*, con varios pedidos
  ])
  nota(9, [Supuestos], [
    - Dudas que quedaron *abiertas* en la reunión
    - Hemos supuesto lo más razonable: *S-01 a S-13*
    - Ejemplo: *nada con historial se borra del todo*
    - Se confirman con el cliente
  ], siguiente: [Javier os cuenta las clases y las secuencias])
}

// ---------------- Diapositivas 10–18 (Javier) ----------------
#let parte-2 = {
  nota(10, [Dominio · CoreReservas], [
    - Los *conceptos del negocio*, sin tipos ni métodos
    - Cliente *residencial* (NIF) o *industrial* (CIF)
    - Pedido con *1..\* líneas* (composición)
    - Una *factura junta 1..\* pedidos*
  ])
  nota(11, [Dominio · CoreBodega], [
    - *MateriaPrima* = un remolque; *detalle* = una línea por variedad
    - *Variedad* tiene su grado mínimo
    - *RegistroOperacion*: quién, cuándo, qué
    - *Empleado* → Administrador / Personal
  ])
  nota(12, [Diseño · CoreReservas], [
    - Mismas entidades + *tipos, visibilidad, operaciones*
    - En verde: un *control* por opción del menú
    - Las pantallas no salen: solo hablan con su control
  ])
  nota(13, [Diseño · CoreBodega], [
    - Tres controles; los tres crean un *RegistroOperacion*
    - Contraseña guardada como *hash*
    - Bajas *lógicas*: no se pierde el historial
  ])
  nota(14, [Ciclo de vida del pedido], [
    - Reservado → Confirmado → Facturado → Enviado → Cerrado
    - *Modificar y anular*: solo antes de facturar
    - Dos finales: *anulado* o *cerrado*
  ])
  nota(15, [Una secuencia por opción], [
    - *8 diagramas*, uno por opción del menú
    - Usuario → *pantalla* → *control* → *entidades* → *BD*
    - Cada operación en un *alt*; *ref* = otro caso de uso
  ])
  nota(16, [Ejemplo: Factura], [
    - Busca los pedidos *confirmados* del cliente
    - La factura junta *uno o varios* y calcula importes
    - Cada pedido pasa a *facturado*; se guarda e *imprime*
  ])
  nota(17, [Ejemplo: Detalle MP], [
    - Una línea por *variedad*
    - Cada una se compara con el *grado mínimo*
    - Si no llega: la uva va a *abono*
    - Queda *registrado* quién lo hizo
  ])
  nota(18, [Gracias], [
    - Lema: *Soluciones de IA a tu medida*
    - *¿Preguntas?*
  ])
}

// ---------------- Preguntas por persona ----------------
#let preguntas-samuel = hoja([Si te preguntan… (Samuel)], {
  pregunta([¿Por qué alta, modificar y baja no son casos de uso aparte?], [Un caso de uso por opción del menú. Las operaciones van en la ficha.])
  pregunta([¿Qué ha cambiado desde la E1?], [Factura con varios pedidos (empieza buscando el cliente). Confirmar, enviado y cerrado. Uva por líneas. Nada con historial se borra.])
  pregunta([¿include o extend?], [include: siempre (buscar). extend: solo con condición (el cliente no existe).])
  pregunta([¿Por qué supuestos?], [Son las dudas abiertas de la reunión. Para no parar, suponemos y lo confirmamos con el cliente.])
  pregunta([¿Por qué no se borra un cliente con pedidos?], [Sus facturas se tienen que conservar. Se marca como dado de baja (S-03).])
  pregunta([¿Por qué dos formatos de stakeholders?], [Son los dos del Tema 3: la cebolla dice cuánto involucrarlos; la matriz, cómo tratarlos.])
  pregunta([¿Por qué Hacienda tiene tanto poder?], [No participa, pero puede obligarnos a cambiar la facturación.])
})
#let preguntas-javier = hoja([Si te preguntan… (Javier)], {
  pregunta([¿Dominio o diseño?], [Dominio: conceptos, sin tipos. Diseño: tipos, visibilidad, operaciones y controles.])
  pregunta([¿Por qué herencia en Cliente?], [Cada tipo tiene datos propios (NIF / CIF y razón social). getDocumentoFiscal() es abstracto.])
  pregunta([¿Por qué composición en Pedido–Línea?], [Una línea no existe sin su pedido: si se borra el pedido, se borran sus líneas.])
  pregunta([¿Por qué Factura 0..1 — 1..\* Pedido?], [Una factura junta varios pedidos del mismo cliente; cada pedido se factura una vez.])
  pregunta([¿Por qué una clase RegistroOperacion?], [El enunciado pide saber quién hizo cada gestión. Guarda quién, cuándo, tipo y sobre qué.])
  pregunta([¿Por qué no están las pantallas?], [Hay una por opción y solo hablan con su control. Salen en las secuencias.])
  pregunta([¿Enum o diagrama de estados?], [Los dos: el enum fija los valores; el diagrama, qué cambios se permiten.])
})
#let preguntas-diego = hoja([Si te preguntan… (Diego)], {
  pregunta([¿Qué plantilla usa la visión?], [La de Moore (Tema 5): para / que / el producto / es / que / a diferencia de.])
  pregunta([¿Dónde está la IA en AñadaMaster?], [Neuranet desarrolla con IA. En la entrega final damos el material para que el cliente cambie su app con IA.])
  pregunta([¿Contra qué os comparáis?], [Su app actual (un ordenador que se cae, sin facturas) y los programas genéricos o Excel.])
  pregunta([Factura: ¿por qué un loop?], [Cada pedido de la factura pasa a facturado, uno a uno.])
  pregunta([Detalle MP: ¿quién decide si la uva vale?], [La línea se evalúa con el grado mínimo de su variedad.])
  pregunta([¿Por qué la baja de empleado es lógica?], [Para no perder quién hizo cada operación (S-04).])
})
#let preguntas-itziar = hoja([Si te preguntan… (Itziar)], {
  pregunta([¿Por qué la pantalla pide confirmación?], [El enunciado pide confirmar los cambios: pedirConfirmacion() y confirmar().])
  pregunta([¿Por qué Pedido va en dos partes?], [Es el mismo diagrama: tiene 5 operaciones y no cabía legible en una página.])
  pregunta([¿Se puede confirmar un pedido anulado?], [No: solo si está reservado. Si no, aviso.])
  pregunta([¿Se cambian líneas de un pedido facturado?], [No: se avisa al cargarlo y no deja editar.])
  pregunta([¿Cómo os habéis organizado?], [Cada uno revisó su parte según su rol; diagramas en se-ramify y todo en el repo.])
  pregunta([¿Qué viene en la E3?], [Modelo de desarrollo propio, backlog y PUD con Gantt y actas. Las dudas abiertas, a una segunda reunión.])
})

// ---------------- Cada chuleta ----------------
#if quien == "diego" {
  portada([Diego], [Diapositivas 1–9: \ visión, stakeholders y casos de uso], [≈ 5 minutos], [Una página por diapositiva. Al final, el reparto y respuestas a posibles preguntas.])
  parte-1([Diego], [Javier])
  reparto
  preguntas-diego
} else if quien == "javier" {
  portada([Javier], [Diapositivas 10–18: \ clases, estados y secuencias], [≈ 5 minutos], [Una página por diapositiva. Al final, el reparto y respuestas a posibles preguntas.])
  parte-2
  reparto
  preguntas-javier
} else if quien == "samuel" {
  portada([Samuel], [Respondes: casos de uso, fichas, supuestos y stakeholders. \ Plan B: diapositivas 1–9], [Plan B ≈ 5 minutos], [Primero el reparto y tus preguntas. Después, por si no viene Diego, sus diapositivas.])
  reparto
  preguntas-samuel
  parte-1([Samuel], [Javier])
} else {
  portada([Itziar], [Respondes: secuencias de CoreReservas, decisiones generales y la E3. \ Entregas en Blackboard], [Hoy, antes de las 23:55], [El reparto, el plan B y tus preguntas.])
  reparto
  preguntas-itziar
}

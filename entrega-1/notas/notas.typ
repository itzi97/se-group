// ============================================================
//  Chuletas para la exposición de la Entrega 1 (formato móvil)
//  Compilar desde la raíz del repo:
//    typst compile --root . --font-path templates/fonts \
//      --input quien=itziar entrega-1/notas/notas.typ entrega-1/notas/chuleta-itziar.pdf
//    (y lo mismo con quien=sam)
//  Las miniaturas salen de presentacion.pdf:
//    pdftoppm -r 60 -png entrega-1/presentacion.pdf entrega-1/notas/img/d
// ============================================================

#import "/templates/lib.typ": petroleo, brasa, chispa, sinapsis, niebla, muted, headingfont, sansfont

#let quien = sys.inputs.at("quien", default: "itziar")

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

// Portada de la chuleta
#let portada(nombre, partes, tiempo) = page(fill: petroleo, footer: none, {
  set text(fill: white)
  v(1fr)
  image("/templates/logo-full-white.svg", width: 5cm)
  v(0.5cm)
  text(font: headingfont, size: 22pt, weight: 700)[Chuleta de #nombre]
  v(0.2cm)
  text(size: 13pt, fill: rgb("#DCE4E5"))[AñadaMaster · Entrega 1]
  v(0.8cm)
  text(size: 13pt)[#partes]
  v(0.3cm)
  text(size: 13pt, fill: chispa, weight: 600)[#tiempo]
  v(1fr)
  text(size: 10pt, fill: rgb("#DCE4E5"))[Una página por diapositiva. Al final, respuestas a posibles preguntas.]
})

// ---------------- Itziar: diapositivas 1–8 ----------------
#let itziar = {
  portada([Itziar], [Diapositivas 1–8: \ empresa, negocio y organización], [≈ 5 minutos])

  nota(1, [Portada], [
    - Buenos días. Somos *Neuranet*
    - Propuesta inicial de *AñadaMaster* para *Bodegas Viña Alcorza*
    - Presentamos *Itziar* y *Sam*
  ])
  nota(2, [Índice], [
    - Cuatro partes
    - Yo: *empresa, negocio y organización*
    - Sam: *casos de uso*
  ])
  nota(3, [Somos Neuranet], [
    - *neura* = redes neuronales, *net* = red
    - Software de gestión *a medida* para pymes
    - Desarrollamos con *IA*: LLM, aprendizaje automático
    - Madrid, *4 personas*
  ])
  nota(4, [Valores], [
    - *Innovación*: probamos lo nuevo, nos quedamos con lo que ayuda
    - *Integridad*: los datos del cliente son suyos
    - *Flexibilidad*: el software se adapta a la empresa
  ])
  nota(5, [Marca], [
    - La «N» = *red neuronal*: entrada → neurona → salida
    - Necesidad del cliente → nuestro trabajo → software
    - La «a» repite la neurona
    - Lema: *Soluciones de IA a tu medida*
  ])
  nota(6, [Modelo de negocio], [
    - *Pymes* con hojas de cálculo o programas viejos
    - Software a medida, *más rápido con IA*
    - *Precio cerrado*: sin sorpresas
    - *Cuota mensual*: soporte y actualizaciones
  ])
  nota(7, [Lienzo], [
    - Resume todo el modelo
    - *Coste principal*: salarios
    - *Socios*: proveedores de IA y nube
    - *Relación*: un solo contacto
  ])
  nota(8, [Quién hace qué], [
    - *Mixta*: un solo jefe hacia el cliente, áreas a la par dentro
    - *Yo*: dirijo y hablo con el cliente
    - *Sam*: requisitos y casos de uso
    - *Javier*: arquitectura y TCO · *Diego*: desarrollo con IA y pruebas
    - Híbrido en Madrid · *Proceso Unificado*
  ], siguiente: [Sam os cuenta los casos de uso])
}

// ---------------- Sam: diapositivas 9–13 ----------------
#let sam = {
  portada([Sam], [Diapositivas 9–13: \ casos de uso y reunión], [≈ 4 minutos])

  nota(9, [Cómo los planteamos], [
    - *2 programas*, 2 diagramas: usuarios distintos
    - *Una opción del menú = un caso de uso*
    - Alta, modificar, baja van *dentro*
    - *include*: siempre · *extend*: solo a veces
  ])
  nota(10, [CoreReservas], [
    - *Personal* lo usa; *Administrador* hereda (mismos permisos)
    - Producto, cliente, pedido, detalle, *factura*
    - Buscar cliente / pedido = *include*
    - Cliente nuevo al pedir = *extend*
  ])
  nota(11, [CoreBodega], [
    - Solo el *Administrador*
    - *Materia prima*: no se modifica
    - Empleado = opción «Personal» del menú
    - *Registrar responsable*: queda quién hizo qué
  ])
  nota(12, [Cambios tras la reunión], [
    - Imprimir → *Generar factura* (se guarda)
    - Pedido: solo se *anula antes de facturar*
    - Cliente: *residencial o industrial*, NIF/CIF
    - Uva: *peso, variedad, azúcar*. Sin devoluciones
  ])
  nota(13, [Gracias], [
    - Lema: *Soluciones de IA a tu medida*
    - *¿Preguntas?*
  ])
}

// ---------------- Posibles preguntas (las dos chuletas) ----------------
#let pregunta(p, r) = block(width: 100%, below: 0.42cm, breakable: false, {
  text(weight: 700, size: 12.5pt)[#p]
  v(0.12cm, weak: true)
  text(size: 12pt, fill: rgb("#3B5359"))[#r]
})
#let preguntas = {
  set page(header: text(font: headingfont, weight: 700, size: 15pt, fill: brasa)[Si os preguntan…], margin: (x: 0.55cm, top: 1.3cm, bottom: 0.7cm))
  pregunta([¿Por qué no un solo diagrama?], [Son dos programas con usuarios distintos. Juntos no se leen.])
  pregunta([¿Por qué el Admin hereda de Personal?], [En CoreReservas tienen los mismos permisos.])
  pregunta([¿Por qué el cliente no es actor?], [No usa el programa: llama y el personal apunta el pedido.])
  pregunta([¿Dónde están alta, modificar, baja?], [Dentro de cada caso de uso, en su especificación (ficheros de `diagramas/`).])
  pregunta([¿Y el TCO?], [Lo prepara Javier para la siguiente entrega: local vs nube a 3 años.])
  pregunta([¿Qué queda pendiente con el cliente?], [Cómo se identifican los usuarios, si el personal usa CoreBodega, PayPal, horario y móvil o tablet.])
  pregunta([¿Por qué Proceso Unificado?], [Lo usamos en este proyecto. Al acabar lo comparamos con otras metodologías.])
}

#if quien == "sam" { sam } else { itziar }
#preguntas

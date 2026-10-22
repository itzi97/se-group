// ============================================================
//  neuranet-ramify.typ — dibuja diagramas de se-ramify con el estilo
//  de las plantillas de Neuranet.
//
//  Lee el fichero JSON de se-ramify (los mismos nombres, códigos y
//  relaciones que ves en la app) y lo maqueta para que quepa en la
//  página:
//    * actores a la izquierda; los que heredan de otro, debajo de él;
//    * casos de uso principales en un arco alrededor del actor;
//    * casos de uso incluidos o extendidos a la derecha, a la altura
//      media de quien los usa;
//    * cada relación lleva su estereotipo («include» o «extend»).
//
//    #import "/templates/neuranet-ramify.typ": usecase-diagram
//    #usecase-diagram(json("/diagramas/usecase-….json"))
//
//  Ruta con "/" al principio = relativa a la raíz del repositorio.
// ============================================================

#import "neuranet.typ": petroleo, brasa, chispa, sinapsis, niebla, ink, muted, headingfont, sansfont

#let usecase-diagram(
  d,                       // el diagrama ya leído: json("/diagramas/….json")
  size: 8.5pt,             // tamaño del texto de los casos de uso
  row-gap: 11pt,           // separación vertical entre casos de uso
  col-gap: 2.3cm,          // separación entre la columna principal y la de incluidos
  actor-gap: 2.0cm,        // separación entre actores y el límite del sistema
  pad: 0.55cm,             // margen interior del límite del sistema
  show-codes: true,        // código CU-xx encima del nombre
  v-pad: 1.0,              // aire vertical dentro de cada elipse (menos = más compacto)
  labels: true,            // estereotipo en cada relación
  legend: true,
) = layout(avail => context {
  let nodes = d.data.nodes
  let edges = d.data.edges
  let byid = (:)
  for n in nodes { byid.insert(n.id, n) }
  let code(n) = if "spec" in n and n.spec != none and "code" in n.spec { n.spec.code } else { "" }
  let label-of(n) = n.label.replace("\n", " ")

  // ---- clasificar ----
  let assoc = edges.filter(e => e.type == "association")
  let rel = edges.filter(e => e.type == "include" or e.type == "extend")
  let gen = edges.filter(e => e.type == "generalization")
  let actors = nodes.filter(n => n.type == "actor")
  let ucs = nodes.filter(n => n.type == "usecase")
  let is-actor(id) = byid.at(id).type == "actor"
  let primary-ids = assoc.map(e => if is-actor(e.from) { e.to } else { e.from }).dedup()
  let primary = ucs.filter(n => n.id in primary-ids)
  let secondary = ucs.filter(n => n.id not in primary-ids)
  let is-primary(id) = id in primary-ids
  let main-ids = assoc.map(e => if is-actor(e.from) { e.from } else { e.to }).dedup()
  let main-actors = actors.filter(a => a.id in main-ids)
  let child-actors = actors.filter(a => a.id not in main-ids)
  let boundary = nodes.find(n => n.type == "boundary")

  // ---- medidas (en pt, como números) ----
  let pt(l) = l / 1pt
  let S = pt(size)
  let lab(n) = {
    set par(leading: 0.35em, justify: false)
    set align(center)
    let c = code(n)
    if show-codes and c != "" { text(size: size * 0.78, fill: muted, font: sansfont)[#c]; linebreak() }
    text(size: size, fill: ink, font: sansfont)[#label-of(n)]
  }
  let ell-w(ns) = calc.max(..ns.map(n => pt(measure(text(size: size, font: sansfont, label-of(n))).width)), 60) + 3.6 * S
  let w1 = ell-w(primary)
  let w2 = if secondary.len() > 0 { ell-w(secondary) } else { 0 }
  let eh = calc.max(..ucs.map(n => pt(measure(box(width: w1 * 1pt, lab(n))).height))) + v-pad * 2.4 * S
  let gap = pt(row-gap)
  let actor-h = 36.0
  let aw = calc.max(..actors.map(a => pt(measure(text(size: size, weight: 700, a.label)).width)), 40) + 8

  // ---- posiciones verticales ----
  let title-h = S * 2.6
  let ytop = pt(pad) + title-h
  let ys = (:)
  for (i, n) in primary.enumerate() { ys.insert(n.id, ytop + i * (eh + gap) + eh / 2) }
  let body-h = calc.max(primary.len() * (eh + gap) - gap, 3 * actor-h)
  let wanted = secondary.map(n => {
    let from = rel.filter(e => e.to == n.id or e.from == n.id)
      .map(e => if e.to == n.id { e.from } else { e.to })
      .filter(id => id in ys).map(id => ys.at(id))
    (n: n, y: if from.len() > 0 { from.sum() / from.len() } else { ytop + body-h / 2 })
  }).sorted(key: p => p.y)
  let placed = ()
  for p in wanted {
    let y = p.y
    if placed.len() > 0 { y = calc.max(y, placed.last().y + eh + 2 * gap) }
    placed.push((n: p.n, y: y))
  }
  if placed.len() > 0 {
    let over = placed.last().y + eh / 2 - (ytop + body-h)
    if over > 0 { placed = placed.map(p => (n: p.n, y: calc.max(ytop + eh / 2, p.y - over))) }
  }
  for p in placed { ys.insert(p.n.id, p.y) }
  let box-h = ytop + body-h + pt(pad)

  // ---- posiciones horizontales ----
  let ax = aw / 2
  let bx = aw + pt(actor-gap)
  let x1 = bx + pt(pad) + w1 / 2
  let mid0 = ytop + body-h / 2
  let n-act = main-actors.len() + child-actors.len()
  let step = actor-h + S * 5
  let ya = mid0                                    // el actor principal, a media altura; los que heredan, debajo
  let half = calc.max(..primary.map(n => calc.abs(ys.at(n.id) - ya)), 1)
  // arco suave alrededor del actor: las líneas llegan sin cruzar otras elipses
  let arc = if primary.len() > 4 { w1 * 0.34 } else { 0 }
  let xs = (:)
  for n in primary { xs.insert(n.id, x1 + arc * (1 - calc.pow((ys.at(n.id) - ya) / half, 2))) }
  // «extend» / «include» entre dos casos principales: se dibuja por la derecha
  let inner = rel.filter(e => is-primary(e.from) and is-primary(e.to))
  let route-x = x1 + arc + w1 / 2 + (if inner.len() > 0 { S * 2.2 } else { 0 })
  let x2 = route-x + pt(col-gap) + w2 / 2
  for p in placed { xs.insert(p.n.id, x2) }
  let bw = (if secondary.len() > 0 { x2 + w2 / 2 } else { route-x }) + pt(pad) - bx
  let W = bx + bw
  // actores: los principales centrados; los que heredan, debajo
  let apos = (:)
  for (i, a) in (main-actors + child-actors).enumerate() {
    apos.insert(a.id, (x: ax, y: ya + i * step))
  }
  let H = box-h + (if legend { S * 3.2 } else { 0 })

  // ---- geometría ----
  let P(x, y) = (x * 1pt, y * 1pt)
  let wid(id) = if is-primary(id) { w1 } else { w2 }
  let ell-edge(id, tx, ty) = {
    let cx = xs.at(id); let cy = ys.at(id); let w = wid(id)
    let dx = tx - cx; let dy = ty - cy
    let t = 1 / calc.sqrt((dx * dx) / calc.pow(w / 2, 2) + (dy * dy) / calc.pow(eh / 2, 2))
    (cx + dx * t, cy + dy * t)
  }
  let ln(a, b, dash: none, paint: petroleo, th: 0.7pt) = place(top + left,
    line(start: P(..a), end: P(..b), stroke: (paint: paint, thickness: th, dash: dash)))
  let arrow-open(a, b, paint: petroleo) = {
    let dx = b.at(0) - a.at(0); let dy = b.at(1) - a.at(1); let L = calc.sqrt(dx * dx + dy * dy)
    let ux = dx / L; let uy = dy / L; let s = 6.0
    for sgn in (1, -1) {
      let px = b.at(0) - s * (ux * calc.cos(25deg) - sgn * uy * calc.sin(25deg))
      let py = b.at(1) - s * (uy * calc.cos(25deg) + sgn * ux * calc.sin(25deg))
      ln(b, (px, py), paint: paint, th: 0.8pt)
    }
  }
  let triangle(a, b) = {
    let dx = b.at(0) - a.at(0); let dy = b.at(1) - a.at(1); let L = calc.sqrt(dx * dx + dy * dy)
    let ux = dx / L; let uy = dy / L; let s = 9.0; let h = 5.0
    let bx0 = b.at(0) - s * ux; let by0 = b.at(1) - s * uy
    place(top + left, polygon(fill: white, stroke: 0.8pt + petroleo,
      P(..b), P(bx0 - h * uy, by0 + h * ux), P(bx0 + h * uy, by0 - h * ux)))
  }
  let tag(x, y, body, paint) = {
    let c = box(fill: niebla, inset: (x: 2pt, y: 1pt), text(size: size * 0.8, fill: paint, weight: 600, body))
    let m = measure(c)
    place(top + left, dx: x * 1pt - m.width / 2, dy: y * 1pt - m.height / 2, c)
  }
  let style(e) = if e.type == "extend" { (paint: sinapsis, name: [«extend»]) } else { (paint: brasa, name: [«include»]) }
  let actor-fig(a) = {
    let p = apos.at(a.id); let x = p.x; let y = p.y - actor-h / 2
    ln((x, y + 11), (x, y + 23), th: 1pt)
    ln((x - 9, y + 15), (x + 9, y + 15), th: 1pt)
    ln((x, y + 23), (x - 7, y + 34), th: 1pt)
    ln((x, y + 23), (x + 7, y + 34), th: 1pt)
    place(top + left, dx: (x - 5.5) * 1pt, dy: y * 1pt, circle(radius: 5.5pt, stroke: 1pt + petroleo, fill: white))
    place(top + left, dx: (x - aw / 2) * 1pt, dy: (y + actor-h + 3) * 1pt,
      box(width: aw * 1pt, align(center, text(size: size, weight: 700, fill: petroleo, a.label))))
  }

  let drawing = box(width: W * 1pt, height: H * 1pt, {
    // límite del sistema
    place(top + left, dx: bx * 1pt, dy: 0pt,
      rect(width: bw * 1pt, height: box-h * 1pt, fill: niebla, stroke: 0.9pt + petroleo))
    place(top + left, dx: (bx + pt(pad)) * 1pt, dy: pt(pad) * 0.75 * 1pt,
      text(size: size * 1.1, weight: 700, font: headingfont, fill: petroleo,
        if boundary != none { boundary.label } else { d.title }))
    // actor → caso de uso
    for e in assoc {
      let (a, u) = if is-actor(e.from) { (e.from, e.to) } else { (e.to, e.from) }
      if a in apos and u in ys {
        let s = (apos.at(a).x + 12, apos.at(a).y - 3)
        ln(s, ell-edge(u, s.at(0), s.at(1)), th: 0.6pt)
      }
    }
    // herencia entre actores (el hijo, debajo, apunta al padre)
    for e in gen {
      if e.from in apos and e.to in apos {
        let c = apos.at(e.from); let p = apos.at(e.to)
        let s = (c.x, c.y - actor-h / 2 - 2); let t = (p.x, p.y + actor-h / 2 + S * 1.6)
        ln(s, t, th: 0.8pt)
        triangle(s, t)
      }
    }
    // «include» / «extend» hacia la columna derecha
    let outer = rel.filter(e => not (is-primary(e.from) and is-primary(e.to)))
    let labelled = ()
    for tgt in outer.map(e => e.to + e.type).dedup() {
      let g = outer.filter(e => e.to + e.type == tgt).sorted(key: e => ys.at(e.from, default: 0))
      labelled.push(g.at(calc.quo(g.len() - 1, 2)).id)
    }
    for e in outer {
      if e.from in ys and e.to in ys {
        let st = style(e)
        let s = ell-edge(e.from, xs.at(e.to), ys.at(e.to))
        let t = ell-edge(e.to, xs.at(e.from), ys.at(e.from))
        ln(s, t, dash: "dashed", paint: st.paint, th: 0.65pt)
        arrow-open(s, t, paint: st.paint)
        if labels and e.id in labelled {
          let f = 0.5
          tag(s.at(0) + (t.at(0) - s.at(0)) * f, s.at(1) + (t.at(1) - s.at(1)) * f, st.name, st.paint)
        }
      }
    }
    // «include» / «extend» entre dos casos principales: por la derecha
    for (i, e) in inner.enumerate() {
      let st = style(e)
      let xr = route-x - i * 4
      let a = (xs.at(e.from) + w1 / 2, ys.at(e.from))
      let b = (xs.at(e.to) + w1 / 2, ys.at(e.to))
      ln(a, (xr, a.at(1)), dash: "dashed", paint: st.paint, th: 0.65pt)
      ln((xr, a.at(1)), (xr, b.at(1)), dash: "dashed", paint: st.paint, th: 0.65pt)
      ln((xr, b.at(1)), b, dash: "dashed", paint: st.paint, th: 0.65pt)
      arrow-open((xr, b.at(1)), b, paint: st.paint)
      if labels {
        let ym = (a.at(1) + b.at(1)) / 2
        place(top + left, dx: (xr + 4) * 1pt, dy: (ym - S) * 1pt, box(fill: niebla, inset: 1.5pt, {
          set par(leading: 0.3em)
          text(size: size * 0.8, fill: st.paint, weight: 600, st.name)
          if "label" in e and e.label != "" { linebreak(); text(size: size * 0.72, fill: muted)[\[#e.label\]] }
        }))
      }
    }
    // casos de uso
    for n in ucs {
      let w = wid(n.id)
      place(top + left, dx: (xs.at(n.id) - w / 2) * 1pt, dy: (ys.at(n.id) - eh / 2) * 1pt,
        box(width: w * 1pt, height: eh * 1pt, {
          place(ellipse(width: 100%, height: 100%, fill: white, stroke: 0.9pt + petroleo))
          align(center + horizon, box(width: (w - S * 2.6) * 1pt, lab(n)))
        }))
    }
    for a in actors { if a.id in apos { actor-fig(a) } }
    // leyenda
    if legend {
      let y = box-h + S * 1.7
      let item(x, paint, name) = {
        ln((x, y), (x + 24, y), dash: "dashed", paint: paint, th: 0.65pt)
        arrow-open((x, y), (x + 24, y), paint: paint)
        place(top + left, dx: (x + 30) * 1pt, dy: (y - S * 0.62) * 1pt, text(size: size * 0.85, fill: muted, name))
      }
      item(bx, brasa, [«include»: siempre se ejecuta])
      if rel.any(e => e.type == "extend") { item(bx + S * 20, sinapsis, [«extend»: solo si se cumple la condición]) }
    }
  })
  let f = calc.min(1, pt(avail.width) / W)
  if f < 1 { align(center, scale(x: f * 100%, y: f * 100%, reflow: true, drawing)) } else { align(center, drawing) }
})

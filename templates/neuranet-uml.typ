// ============================================================
//  neuranet-uml.typ — dibuja más diagramas de se-ramify con el
//  estilo de Neuranet: clases, estados, secuencia, stakeholders y visión.
//
//    #import "/templates/neuranet-uml.typ": *
//    #class-diagram(json("/diagramas/class-….json"))
//    #state-diagram(json("/diagramas/state-….json"))
//    #sequence-diagram(json("/diagramas/sequence-….json"))
//    #stakeholder-grid(json("/diagramas/stakeholder-….json"))
//    #stakeholder-onion(json("/diagramas/stakeholder-….json"))
//    #vision-pitch(json("/diagramas/vision-….json"))
//
//  Clases y estados usan las posiciones guardadas en se-ramify (x, y),
//  así que el diagrama se ve con la misma distribución que en la app.
//  La secuencia se maqueta sola a partir de los mensajes.
//  Todos se escalan para caber en el ancho (y alto, si se indica).
// ============================================================

#import "neuranet.typ": petroleo, brasa, chispa, sinapsis, niebla, ink, muted, hairline, headingfont, sansfont, monofont

// ---------------------------------------------------------------- geometría
#let _P(x, y) = (x * 1pt, y * 1pt)
#let _ln(a, b, paint: petroleo, th: 0.7pt, dash: none) = place(top + left,
  line(start: _P(..a), end: _P(..b), stroke: (paint: paint, thickness: th, dash: dash)))
#let _unit(a, b) = {
  let dx = b.at(0) - a.at(0); let dy = b.at(1) - a.at(1)
  let L = calc.max(calc.sqrt(dx * dx + dy * dy), 0.001)
  (dx / L, dy / L, L)
}
// Punta de flecha abierta en b, viniendo de a
#let _arrow-open(a, b, paint: petroleo, s: 6.5) = {
  let (ux, uy, _) = _unit(a, b)
  for sgn in (1, -1) {
    let px = b.at(0) - s * (ux * calc.cos(26deg) - sgn * uy * calc.sin(26deg))
    let py = b.at(1) - s * (uy * calc.cos(26deg) + sgn * ux * calc.sin(26deg))
    _ln(b, (px, py), paint: paint, th: 0.8pt)
  }
}
#let _arrow-filled(a, b, paint: petroleo, s: 7.0, h: 3.0) = {
  let (ux, uy, _) = _unit(a, b)
  let bx = b.at(0) - s * ux; let by = b.at(1) - s * uy
  place(top + left, polygon(fill: paint, stroke: none,
    _P(..b), _P(bx - h * uy, by + h * ux), _P(bx + h * uy, by - h * ux)))
}
#let _triangle(a, b, paint: petroleo) = {
  let (ux, uy, _) = _unit(a, b)
  let s = 10.0; let h = 5.5
  let bx = b.at(0) - s * ux; let by = b.at(1) - s * uy
  place(top + left, polygon(fill: white, stroke: 0.8pt + paint,
    _P(..b), _P(bx - h * uy, by + h * ux), _P(bx + h * uy, by - h * ux)))
}
// Rombo en a (apuntando hacia fuera de la línea a→b)
#let _diamond(a, b, filled: false, paint: petroleo) = {
  let (ux, uy, _) = _unit(a, b)
  let s = 7.0; let h = 4.0
  let m = (a.at(0) + s * ux, a.at(1) + s * uy)
  let e = (a.at(0) + 2 * s * ux, a.at(1) + 2 * s * uy)
  place(top + left, polygon(fill: if filled { paint } else { white }, stroke: 0.8pt + paint,
    _P(..a), _P(m.at(0) - h * uy, m.at(1) + h * ux), _P(..e), _P(m.at(0) + h * uy, m.at(1) - h * ux)))
}
// Corte del segmento centro→objetivo con el borde de un rectángulo
#let _rect-edge(r, tx, ty) = {
  let cx = r.x + r.w / 2; let cy = r.y + r.h / 2
  let dx = tx - cx; let dy = ty - cy
  if calc.abs(dx) < 0.001 and calc.abs(dy) < 0.001 { return (cx, cy) }
  let t = calc.min(
    if calc.abs(dx) > 0.001 { (r.w / 2) / calc.abs(dx) } else { 1e9 },
    if calc.abs(dy) > 0.001 { (r.h / 2) / calc.abs(dy) } else { 1e9 })
  (cx + dx * t, cy + dy * t)
}
// Extremos de una relación entre dos cajas: recta vertical u horizontal si
// se solapan en x o en y; si no, de centro a centro.
#let _endpoints(a, b) = {
  let ox0 = calc.max(a.x, b.x); let ox1 = calc.min(a.x + a.w, b.x + b.w)
  let oy0 = calc.max(a.y, b.y); let oy1 = calc.min(a.y + a.h, b.y + b.h)
  if ox1 - ox0 > 12 {
    let x = (ox0 + ox1) / 2
    if a.y + a.h <= b.y { ((x, a.y + a.h), (x, b.y)) } else { ((x, a.y), (x, b.y + b.h)) }
  } else if oy1 - oy0 > 12 {
    let y = (oy0 + oy1) / 2
    if a.x + a.w <= b.x { ((a.x + a.w, y), (b.x, y)) } else { ((a.x, y), (b.x + b.w, y)) }
  } else {
    let ca = (a.x + a.w / 2, a.y + a.h / 2); let cb = (b.x + b.w / 2, b.y + b.h / 2)
    (_rect-edge(a, ..cb), _rect-edge(b, ..ca))
  }
}
#let _fit(W, H, avail, max-scale, max-height, body) = {
  // max-scale: none = tamaño natural, para que quien lo use lo escale
  // (las diapositivas lo amplían hasta llenar el hueco que tienen)
  if max-scale == none { return body }
  let f = calc.min(max-scale, avail.width / 1pt / W)
  if max-height != none { f = calc.min(f, max-height / 1pt / H) }
  align(center, scale(x: f * 100%, y: f * 100%, reflow: true, body))
}
#let _label(x, y, body, size, fill: muted, bg: white) = place(top + left, dx: x * 1pt, dy: y * 1pt,
  place(center + horizon, box(fill: bg, inset: (x: 1.5pt, y: 1pt), text(size: size, fill: fill, body))))

// ============================================================ clases y estados
#let _graph(d, size, unit, avail, max-scale, max-height, compact: true) = {
  let nodes = d.data.nodes
  let edges = d.data.edges
  let S = size / 1pt
  let boxes = (:)
  let contents = (:)
  let mono(s) = text(font: sansfont, size: size, fill: ink, s)

  // ---- contenido y tamaño de cada nodo ----
  let class-box(n) = {
    let st = n.at("stereotype", default: none)
    let accent = if "color" in n { rgb(n.color) } else { petroleo }
    let attrs = n.at("attrs", default: ())
    let ops = n.at("ops", default: ())
    let is-enum = n.type == "enum"
    let pad = (x: S * 0.7 * 1pt, y: S * 0.45 * 1pt)
    let head-body = {
      set align(center); set par(leading: 0.3em, justify: false)
      if st != none { text(size: size * 0.85, fill: muted)[«#st»]; linebreak() }
      text(size: size * 1.08, weight: 700, fill: petroleo, font: sansfont,
        style: if n.at("abstract", default: false) { "italic" } else { "normal" }, n.label)
      if n.at("abstract", default: false) { linebreak(); text(size: size * 0.8, fill: muted)[{abstract}] }
    }
    let comp-body(lines) = {
      set align(left); set par(leading: 0.35em, justify: false)
      for (i, l) in lines.enumerate() {
        let it = if l.ends-with("{abstract}") { emph(l.replace(" {abstract}", "")) } else { l }
        mono(it); if i < lines.len() - 1 { linebreak() }
      }
    }
    let comps = ()
    if attrs.len() > 0 or (not is-enum and st != "control") { comps.push(attrs) }
    if ops.len() > 0 { comps.push(ops) }
    let w = calc.max(measure(block(inset: pad, head-body)).width / 1pt,
      ..comps.map(c => measure(block(inset: pad, comp-body(c))).width / 1pt), S * 9)
    let parts = (block(width: w * 1pt, inset: pad, fill: if st == "control" { accent.lighten(85%) } else { niebla }, head-body),)
    for c in comps {
      parts.push(line(length: w * 1pt, stroke: 0.6pt + accent))
      parts.push(block(width: w * 1pt, inset: pad, height: if c.len() == 0 { S * 1.2 * 1pt } else { auto }, comp-body(c)))
    }
    block(fill: white, stroke: 0.9pt + accent, breakable: false, stack(..parts))
  }
  let state-box(n) = {
    let attrs = n.at("attrs", default: ())
    let name = text(size: size * 1.05, weight: 700, fill: petroleo, n.label)
    let acts = { set par(leading: 0.35em, justify: false); for (i, a) in attrs.enumerate() { text(size: size * 0.9, fill: ink, a); if i < attrs.len() - 1 { linebreak() } } }
    let w = calc.max(measure(name).width / 1pt, if attrs.len() > 0 { measure(acts).width / 1pt } else { 0 }) + S * 2.2
    block(width: w * 1pt, fill: niebla, stroke: 0.9pt + petroleo, radius: S * 1.1 * 1pt, breakable: false,
      inset: (x: S * 1.1 * 1pt, y: S * 0.7 * 1pt), {
        align(center, name)
        if attrs.len() > 0 {
          v(S * 0.35 * 1pt, weak: true)
          line(length: 100%, stroke: 0.5pt + hairline.darken(15%))
          v(S * 0.25 * 1pt, weak: true)
          acts
        }
      })
  }
  let note-box(n) = {
    let w = n.at("w", default: 160) * unit
    block(width: w * 1pt, fill: rgb("#FFF8E1"), stroke: 0.6pt + rgb("#C9A227"), inset: S * 0.7 * 1pt, breakable: false,
      text(size: size * 0.9, fill: ink, n.label))
  }
  for n in nodes {
    let c = if n.type in ("class", "interface", "enum") { class-box(n) }
      else if n.type == "state" { state-box(n) }
      else if n.type == "note" { note-box(n) }
      else if n.type == "initial" { circle(radius: 5.5pt, fill: petroleo, stroke: none) }
      else if n.type == "final" { circle(radius: 7pt, fill: white, stroke: 1pt + petroleo, inset: 0pt, align(center + horizon, circle(radius: 4pt, fill: petroleo, stroke: none))) }
      else if n.type == "choice" { rotate(45deg, square(size: 12pt, fill: white, stroke: 0.9pt + petroleo)) }
      else { none }
    if c != none {
      let m = measure(c)
      contents.insert(n.id, c)
      boxes.insert(n.id, (x: n.x * unit, y: n.y * unit, w: m.width / 1pt, h: m.height / 1pt))
    }
  }
  // ---- compactar: acercar las cajas todo lo posible (por separado en x y en y)
  // dejando solo el hueco que necesitan las líneas y sus etiquetas ----
  if compact {
    let ids = boxes.keys()
    let raw = (:)
    for n in nodes { if n.id in boxes { raw.insert(n.id, (x: n.x, y: n.y)) } }
    // hueco mínimo entre dos cajas unidas: lo que mida su etiqueta (o las multiplicidades)
    let linked = (:)
    for e in edges {
      let lw = measure(text(size: size * 0.9, e.at("label", default: ""))).width / 1pt + S * 3
      for k in (e.from + "|" + e.to, e.to + "|" + e.from) { linked.insert(k, calc.max(linked.at(k, default: 0), lw)) }
    }
    let selfloop = edges.filter(e => e.from == e.to).map(e => e.from)
    let gx(a, b) = { let k = a + "|" + b; if k in linked { calc.max(S * 7, linked.at(k)) } else { S * 3.5 } }
    let gy(a, b) = if (a + "|" + b) in linked { S * 7.5 } else { S * 2.6 }
    // 1) vertical: cada caja sube hasta la de encima con la que coincide en horizontal
    let fin = (:)
    for id in ids.sorted(key: id => raw.at(id).y) {
      let b = boxes.at(id)
      let x0 = raw.at(id).x * unit; let x1 = x0 + b.w
      let top = if id in selfloop { S * 3.2 } else { 0 }
      for (m, f) in fin {
        let mb = boxes.at(m); let mx0 = raw.at(m).x * unit
        let below-linked = (m + "|" + id) in linked and raw.at(id).y > raw.at(m).y + 40
        if below-linked or (mx0 < x1 + S * 2 and x0 < mx0 + mb.w + S * 2) {
          top = calc.max(top, f.y + mb.h + gy(m, id) + (if id in selfloop { S * 3.2 } else { 0 }))
        }
      }
      fin.insert(id, (x: 0, y: top))
    }
    // 2) horizontal: cada caja se arrima a la de su izquierda con la que coincide en vertical
    let placed = (:)
    let xkey(id) = {
      let p = edges.find(e => e.type == "generalization" and e.from == id)
      if p != none and p.to in raw and raw.at(id).x >= raw.at(p.to).x - 100 { calc.max(raw.at(id).x, raw.at(p.to).x + 1) } else { raw.at(id).x }
    }
    for id in ids.sorted(key: xkey) {
      let b = boxes.at(id); let y0 = fin.at(id).y; let y1 = y0 + b.h
      let left = 0
      for (m, f) in placed {
        let mb = boxes.at(m)
        if fin.at(m).y < y1 + S * 1.5 and y0 < fin.at(m).y + mb.h + S * 1.5 {
          left = calc.max(left, f + mb.w + gx(m, id))
        }
      }
      // una subclase no se queda a la izquierda de su clase padre
      for e in edges.filter(e => e.type == "generalization" and e.from == id and e.to in placed) {
        if raw.at(id).x >= raw.at(e.to).x - 100 { left = calc.max(left, placed.at(e.to)) }
      }
      placed.insert(id, left)
    }
    for id in ids {
      let b = boxes.at(id)
      boxes.insert(id, (x: placed.at(id), y: fin.at(id).y, w: b.w, h: b.h))
    }
  }
  // paquetes y estados compuestos: rodean los nodos que tienen dentro
  let containers = ()
  for n in nodes.filter(n => n.type in ("package", "composite")) {
    let inside = nodes.filter(m => m.id in boxes and m.x >= n.x and m.y >= n.y
      and m.x <= n.x + n.at("w", default: 0) and m.y <= n.y + n.at("h", default: 0))
    if inside.len() > 0 {
      let bs = inside.map(m => boxes.at(m.id))
      let pad = S * 1.6
      let x0 = calc.min(..bs.map(b => b.x)) - pad
      let y0 = calc.min(..bs.map(b => b.y)) - pad * 1.2
      let x1 = calc.max(..bs.map(b => b.x + b.w)) + pad
      let y1 = calc.max(..bs.map(b => b.y + b.h)) + pad
      containers.push((n: n, x: x0, y: y0, w: x1 - x0, h: y1 - y0))
    }
  }
  // ---- límites del dibujo ----
  let all = boxes.values() + containers.map(c => (x: c.x, y: c.y - S * 1.9, w: c.w, h: c.h + S * 1.9))
  let mx = calc.min(..all.map(b => b.x)) - S * 3
  let my = calc.min(..all.map(b => b.y)) - S * 3
  let W = calc.max(..all.map(b => b.x + b.w)) - mx + S * 3
  let H = calc.max(..all.map(b => b.y + b.h)) - my + S * 3
  let B(id) = { let b = boxes.at(id); (x: b.x - mx, y: b.y - my, w: b.w, h: b.h) }

  let drawing = box(width: W * 1pt, height: H * 1pt, {
    for c in containers {
      let x = c.x - mx; let y = c.y - my
      let tab = text(size: size * 0.95, weight: 700, fill: petroleo, c.n.label)
      let tw = measure(tab).width / 1pt + S * 1.6
      if c.n.type == "package" {
        place(top + left, dx: x * 1pt, dy: (y - S * 1.9) * 1pt,
          rect(width: tw * 1pt, height: S * 1.9 * 1pt, fill: niebla, stroke: 0.8pt + muted, inset: (x: S * 0.8 * 1pt, y: 0pt), align(horizon, tab)))
        place(top + left, dx: x * 1pt, dy: y * 1pt, rect(width: c.w * 1pt, height: c.h * 1pt, stroke: 0.8pt + muted))
      } else {
        place(top + left, dx: x * 1pt, dy: y * 1pt, rect(width: c.w * 1pt, height: c.h * 1pt, radius: S * 1pt, stroke: 0.8pt + petroleo,
          inset: S * 0.6 * 1pt, tab))
      }
    }
    // relaciones
    for e in edges {
      if e.from in boxes and e.to in boxes {
        let a = B(e.from); let b = B(e.to)
        let dashed = e.type in ("dependency", "realization", "noteLink")
        let paint = if "color" in e { rgb(e.color) } else if e.type == "dependency" { muted } else { petroleo }
        let lab = e.at("label", default: "")
        if e.from == e.to {
          // transición sobre sí mismo: un bucle encima de la caja
          let x0 = a.x + a.w * 0.62; let x1 = a.x + a.w * 0.86; let y0 = a.y; let up = S * 2.6
          _ln((x0, y0), (x0, y0 - up), paint: paint); _ln((x0, y0 - up), (x1, y0 - up), paint: paint)
          _ln((x1, y0 - up), (x1, y0), paint: paint); _arrow-filled((x1, y0 - up), (x1, y0), paint: paint)
          if lab != "" { _label((x0 + x1) / 2, y0 - up - S * 0.9, lab, size * 0.9, fill: ink, bg: white) }
        } else {
          let (p, q) = _endpoints(a, b)
          _ln(p, q, paint: paint, th: 0.75pt, dash: if dashed { "dashed" } else { none })
          if e.type == "generalization" or e.type == "realization" { _triangle(p, q, paint: paint) }
          else if e.type in ("directed", "dependency") { _arrow-open(p, q, paint: paint) }
          else if e.type == "transition" { _arrow-filled(p, q, paint: paint) }
          if e.type == "composition" { _diamond(p, q, filled: true, paint: paint) }
          if e.type == "aggregation" { _diamond(p, q, paint: paint) }
          let (ux, uy, L) = _unit(p, q)
          let off = S * 1.0
          let side(t, s) = (p.at(0) + ux * t - uy * s, p.at(1) + uy * t + ux * s)
          let fl = e.at("fromLabel", default: ""); let tl = e.at("toLabel", default: "")
          if fl != "" { let pt = side(S * 2.6, off); _label(pt.at(0), pt.at(1), fl, size * 0.92, fill: brasa, bg: none) }
          if tl != "" { let pt = side(L - S * 2.6, off); _label(pt.at(0), pt.at(1), tl, size * 0.92, fill: brasa, bg: none) }
          if lab != "" {
            let pt = side(L / 2, if e.type == "transition" { 0 } else { -off * 1.1 })
            _label(pt.at(0), pt.at(1), if e.type == "transition" { lab } else { emph(lab) }, size * 0.9,
              fill: if e.type == "transition" { ink } else { muted }, bg: white)
          }
        }
      }
    }
    for n in nodes {
      if n.id in contents {
        let b = B(n.id)
        if n.type == "note" {
          for e in edges.filter(e => e.type == "noteLink" and (e.from == n.id or e.to == n.id)) {}
        }
        place(top + left, dx: b.x * 1pt, dy: b.y * 1pt, contents.at(n.id))
      }
    }
  })
  _fit(W, H, avail, max-scale, max-height, drawing)
}

#let class-diagram(d, size: 7.6pt, unit: 0.72, max-scale: 2.0, max-height: none) = layout(avail => context
  _graph(d, size, unit, avail, max-scale, max-height))

#let state-diagram(d, size: 8.5pt, unit: 0.72, max-scale: 2.2, max-height: none) = layout(avail => context
  _graph(d, size, unit, avail, max-scale, max-height, compact: false))

// Leyenda de la notación de clases (relaciones)
#let class-legend(size: 7.5pt) = {
  let item(kind, name) = box(width: 5.2cm, height: 12pt, {
    let a = (2, 6); let b = (34, 6)
    if kind == "composition" { _ln(a, b); _diamond(a, b, filled: true) }
    else if kind == "generalization" { _ln(a, b); _triangle(a, b) }
    else if kind == "directed" { _ln(a, b); _arrow-open(a, b) }
    else if kind == "dependency" { _ln(a, b, paint: muted, dash: "dashed"); _arrow-open(a, b, paint: muted) }
    else { _ln(a, b) }
    place(top + left, dx: 40pt, dy: 1pt, text(size: size, fill: muted, name))
  })
  grid(columns: 3, row-gutter: 6pt, column-gutter: 4pt,
    item("association", [Asociación]), item("composition", [Composición (rombo en el todo)]),
    item("generalization", [Herencia]), item("directed", [Asociación dirigida]),
    item("dependency", [Dependencia («usa»)]), box(height: 12pt, text(size: size, fill: brasa)[1, 0..\*, 1..\* · multiplicidad]))
}

// ============================================================ secuencia
#let _head(kind, name, size) = {
  let S = size / 1pt
  let icon = if kind == "actor" {
    box(width: 20pt, height: 26pt, {
      place(top + left, dx: 5pt, dy: 0pt, circle(radius: 5pt, stroke: 1pt + petroleo, fill: white))
      _ln((10, 10), (10, 19), th: 1pt); _ln((3, 13), (17, 13), th: 1pt)
      _ln((10, 19), (4, 26), th: 1pt); _ln((10, 19), (16, 26), th: 1pt)
    })
  } else if kind == "boundary" {
    box(width: 30pt, height: 22pt, {
      _ln((2, 3), (2, 19), th: 1pt); _ln((2, 11), (9, 11), th: 1pt)
      place(top + left, dx: 9pt, dy: 1pt, circle(radius: 10pt, stroke: 1pt + petroleo, fill: niebla))
    })
  } else if kind == "control" {
    box(width: 22pt, height: 22pt, {
      place(top + left, dx: 1pt, dy: 1pt, circle(radius: 10pt, stroke: 1pt + sinapsis, fill: sinapsis.lighten(85%)))
      _ln((11, 1), (15, -2.5), paint: sinapsis, th: 1pt); _ln((11, 1), (15, 4.5), paint: sinapsis, th: 1pt)
    })
  } else if kind == "entity" {
    box(width: 22pt, height: 22pt, {
      place(top + left, dx: 1pt, dy: 0pt, circle(radius: 10pt, stroke: 1pt + petroleo, fill: niebla))
      _ln((1, 21.5), (21, 21.5), th: 1pt)
    })
  } else if kind == "database" {
    box(width: 22pt, height: 24pt, {
      place(top + left, dx: 1pt, dy: 3pt, rect(width: 20pt, height: 18pt, fill: niebla, stroke: none))
      _ln((1, 3), (1, 21), th: 1pt); _ln((21, 3), (21, 21), th: 1pt)
      place(top + left, dx: 1pt, dy: 0pt, ellipse(width: 20pt, height: 6pt, stroke: 1pt + petroleo, fill: niebla))
      place(top + left, dx: 1pt, dy: 18pt, box(width: 20pt, height: 6pt, clip: true,
        place(top + left, dy: -0pt, ellipse(width: 20pt, height: 6pt, stroke: 1pt + petroleo))))
    })
  } else { none }
  let lab = text(size: size, weight: 700, fill: if kind == "control" { sinapsis } else { petroleo }, name)
  if icon == none {
    block(stroke: 0.9pt + petroleo, fill: niebla, inset: (x: S * 0.7 * 1pt, y: S * 0.5 * 1pt), lab)
  } else {
    stack(dir: ttb, spacing: 3pt, align(center, icon), align(center, lab))
  }
}

#let sequence-diagram(d, size: 7.8pt, max-scale: 1.4, max-height: none, numbered: auto, number-from: 1) = layout(avail => context {
  let S = size / 1pt
  let parts = d.data.participants
  let items = d.data.items
  let num = if numbered == auto { d.data.at("autonumber", default: true) } else { numbered }
  let col = (:)
  for (i, p) in parts.enumerate() { col.insert(p.id, i) }
  let n = parts.len()
  let tw(s) = measure(text(size: size, s)).width / 1pt
  let th(s) = measure(text(size: size, s)).height / 1pt

  // ---- textos de los mensajes, con número ----
  let k = number-from - 1
  let labels = ()
  for it in items {
    if it.t == "msg" {
      k += 1
      let pre = if num { str(k) + ". " } else { "" }
      let body = if it.style == "create" { "«create» " + it.text } else { it.text }
      labels.push(pre + body)
    } else { labels.push(none) }
  }
  // ---- columnas ----
  let heads = parts.map(p => _head(p.kind, p.name, size))
  let hw = heads.map(h => measure(h).width / 1pt)
  let hh = calc.max(..heads.map(h => measure(h).height / 1pt))
  let gaps = range(calc.max(n - 1, 0)).map(i => (hw.at(i) + hw.at(i + 1)) / 2 + S * 3.2)
  let right-extra = 0
  for (i, it) in items.enumerate() {
    if it.t == "msg" {
      let a = col.at(it.from); let b = col.at(it.to)
      let w = tw(labels.at(i)) + S * 2.4
      if a == b {
        let w2 = w + S * 3.5
        if a < n - 1 { gaps.at(a) = calc.max(gaps.at(a), w2) } else { right-extra = calc.max(right-extra, w2) }
      } else {
        let lo = calc.min(a, b); let hi = calc.max(a, b)
        let have = range(lo, hi).map(j => gaps.at(j)).sum()
        if have < w { for j in range(lo, hi) { gaps.at(j) += (w - have) / (hi - lo) } }
      }
    }
  }
  let margin = S * 4.5
  let xs = (margin + hw.at(0) / 2,)
  for g in gaps { xs.push(xs.last() + g) }
  let W0 = xs.last() + hw.last() / 2 + calc.max(margin, right-extra)

  // ---- qué columnas toca cada fragmento ----
  let span = (:)
  let open-stack = ()
  for (i, it) in items.enumerate() {
    if it.t == "open" { open-stack.push(i); span.insert(str(i), (lo: 99, hi: -1, self: false)) }
    else if it.t == "close" { let o = open-stack.pop()
      // un fragmento vacío (ref) va del actor al control
      let s = span.at(str(o))
      if s.hi < 0 { span.insert(str(o), (lo: 0, hi: calc.min(2, n - 1), self: false)) }
      for p in open-stack { let t = span.at(str(p)); let s2 = span.at(str(o))
        span.insert(str(p), (lo: calc.min(t.lo, s2.lo), hi: calc.max(t.hi, s2.hi), self: t.self or s2.self)) } }
    else if it.t == "msg" or it.t == "note" {
      let cs = if it.t == "msg" { (col.at(it.from), col.at(it.to)) } else { it.over.map(o => col.at(o)) }
      let selfmax = it.t == "msg" and it.from == it.to
      for p in open-stack { let t = span.at(str(p))
        span.insert(str(p), (lo: calc.min(t.lo, ..cs), hi: calc.max(t.hi, ..cs),
          self: t.self or (selfmax and cs.at(0) >= t.hi))) }
    }
  }

  // ---- recorrido: posiciones verticales ----
  let y = hh + S * 2.2
  let row = S * 2.35
  let frames = ()     // (i, lo, hi, depth, y0, y1, op, guard, elses)
  let fstack = ()     // índices en frames
  let msgs = ()       // (i, y)
  let notes = ()
  let acts = ()       // (col, y0, y1, depth)
  let call = ((p: parts.at(0).id, y: y, d: 0),)   // pila de llamadas (el actor abajo)
  let snaps = ()
  for (i, it) in items.enumerate() {
    if it.t == "msg" {
      let a = col.at(it.from); let b = col.at(it.to)
      let selfm = a == b
      y += row + (if selfm { S * 0.4 } else { 0 })
      // devuelve el control a quien envía: se cierran las activaciones de encima
      let idx = call.len() - 1
      while idx > 0 and call.at(idx).p != it.from { idx -= 1 }
      if call.at(idx).p == it.from {
        while call.len() - 1 > idx {
          let c = call.pop()
          if parts.at(col.at(c.p)).kind != "actor" { acts.push((col.at(c.p), c.y, y - S * 1.1, c.d)) }
        }
      }
      if it.style == "reply" {
        // quien responde termina
        if call.len() > 1 and call.last().p == it.from {
          let c = call.pop()
          if parts.at(col.at(c.p)).kind != "actor" { acts.push((col.at(c.p), c.y, y, c.d)) }
        }
      } else if it.style == "sync" {
        let depth = call.filter(c => c.p == it.to).len()
        if selfm {
          acts.push((b, y + S * 0.2, y + S * 1.6, depth))
        } else {
          call.push((p: it.to, y: y, d: depth))
        }
      }
      msgs.push((i: i, y: y, a: a, b: b, selfm: selfm))
      if selfm { y += S * 1.6 }
    } else if it.t == "open" {
      if it.op == "ref" {
        y += S * 1.1
        frames.push((i: i, depth: fstack.len(), y0: y, y1: y + S * 2.6, op: "ref", guard: it.guard, elses: ()))
        fstack.push(frames.len() - 1)
        y += S * 2.6
      } else {
        y += S * 1.2
        frames.push((i: i, depth: fstack.len(), y0: y, y1: 0, op: it.op, guard: it.guard, elses: ()))
        fstack.push(frames.len() - 1)
        snaps.push(call)
        y += S * 1.6
      }
    } else if it.t == "else" {
      y += S * 1.2
      let f = fstack.last()
      let fr = frames.at(f)
      fr.elses.push((y: y, guard: it.guard))
      frames.at(f) = fr
      // cada rama empieza con la pila de llamadas del principio del fragmento
      let snap = snaps.last()
      while call.len() > snap.len() { let c = call.pop()
        if parts.at(col.at(c.p)).kind != "actor" { acts.push((col.at(c.p), c.y, y - S * 0.4, c.d)) } }
      y += S * 1.6
    } else if it.t == "close" {
      let f = fstack.pop()
      let fr = frames.at(f)
      if fr.op != "ref" {
        y += S * 0.9
        fr.y1 = y
        frames.at(f) = fr
        let snap = snaps.pop()
        while call.len() > snap.len() { let c = call.pop()
          if parts.at(col.at(c.p)).kind != "actor" { acts.push((col.at(c.p), c.y, y - S * 0.4, c.d)) } }
      }
    } else if it.t == "note" {
      y += S * 1.4
      let txt = text(size: size * 0.92, fill: ink, it.text)
      let m = measure(txt)
      notes.push((i: i, y: y, cols: it.over.map(o => col.at(o)), body: txt, w: m.width / 1pt, h: m.height / 1pt))
      y += m.height / 1pt + S * 0.9
    }
  }
  y += row
  while call.len() > 1 { let c = call.pop()
    if parts.at(col.at(c.p)).kind != "actor" { acts.push((col.at(c.p), c.y, y - S * 0.8, c.d)) } }
  let H = y + S * 1.5
  let W = W0

  let drawing = box(width: W * 1pt, height: H * 1pt, {
    // cabeceras y líneas de vida
    for (j, p) in parts.enumerate() {
      place(top + left, dx: (xs.at(j) - hw.at(j) / 2) * 1pt, dy: (hh - measure(heads.at(j)).height / 1pt) * 1pt, heads.at(j))
      _ln((xs.at(j), hh + S * 0.5), (xs.at(j), H - S * 0.5), paint: hairline.darken(25%), th: 0.7pt, dash: "dashed")
    }
    let draw-frame(f, pass) = {
      let s = span.at(str(f.i))
      let inset = S * 1.6 + (2 - calc.min(f.depth, 2)) * S * 0.9
      let x0 = xs.at(s.lo) - S * 2.6 - (if f.op == "ref" { 0 } else { (3 - calc.min(f.depth, 3)) * S * 0.7 })
      let x1 = xs.at(s.hi) + S * 2.6 + (if s.self { S * 9 } else { 0 }) + (if f.op == "ref" { 0 } else { (3 - calc.min(f.depth, 3)) * S * 0.7 })
      x1 = calc.min(x1, W - S * 0.5)
      let tag = text(size: size * 0.9, weight: 700, fill: white, f.op)
      let tgw = measure(tag).width / 1pt + S * 1.4
      if f.op == "ref" {
        let lab = text(size: size, fill: petroleo, weight: 600, f.guard)
        x1 = calc.max(x1, x0 + tgw + measure(lab).width / 1pt + S * 4)
        if pass == 1 {
        place(top + left, dx: x0 * 1pt, dy: f.y0 * 1pt, rect(width: (x1 - x0) * 1pt, height: (f.y1 - f.y0) * 1pt, fill: white, stroke: 0.8pt + petroleo))
        place(top + left, dx: x0 * 1pt, dy: f.y0 * 1pt, box(fill: petroleo, inset: (x: S * 0.7 * 1pt, y: S * 0.3 * 1pt), tag))
        place(top + left, dx: (x0 + tgw) * 1pt, dy: f.y0 * 1pt, box(width: (x1 - x0 - tgw) * 1pt, height: (f.y1 - f.y0) * 1pt, align(center + horizon, lab)))
        }
      } else {
        let paint = if f.op == "alt" { brasa } else if f.op == "loop" { sinapsis } else { petroleo }
        let gw = calc.max(measure(text(size: size * 0.92, weight: 600)[\[#f.guard\]]).width / 1pt,
          ..f.elses.map(e => measure(text(size: size * 0.92, weight: 600)[\[#e.guard\]]).width / 1pt - tgw))
        x1 = calc.max(x1, x0 + tgw + gw + S * 2)
        if pass == 0 { place(top + left, dx: x0 * 1pt, dy: f.y0 * 1pt, rect(width: (x1 - x0) * 1pt, height: (f.y1 - f.y0) * 1pt, stroke: 0.8pt + paint)) }
        if pass == 1 {
        place(top + left, dx: x0 * 1pt, dy: f.y0 * 1pt, box(fill: paint, inset: (x: S * 0.7 * 1pt, y: S * 0.3 * 1pt),
          text(size: size * 0.9, weight: 700, fill: white, f.op)))
        place(top + left, dx: (x0 + tgw + S * 0.4) * 1pt, dy: (f.y0 + S * 0.15) * 1pt, box(fill: white, inset: (x: S * 0.25 * 1pt, y: S * 0.12 * 1pt), text(size: size * 0.92, weight: 600, fill: paint)[\[#f.guard\]]))
        for e in f.elses {
          _ln((x0, e.y), (x1, e.y), paint: paint, th: 0.7pt, dash: "dashed")
          place(top + left, dx: (x0 + S * 0.5) * 1pt, dy: (e.y + S * 0.2) * 1pt, box(fill: white, inset: (x: S * 0.25 * 1pt, y: S * 0.12 * 1pt), text(size: size * 0.92, weight: 600, fill: paint)[\[#e.guard\]]))
        }
        }
      }
    }
    for f in frames { draw-frame(f, 0) }
    // activaciones
    for a in acts {
      let x = xs.at(a.at(0)) - 3.5 + a.at(3) * 3.5
      if a.at(2) > a.at(1) {
        place(top + left, dx: x * 1pt, dy: a.at(1) * 1pt, rect(width: 7pt, height: (a.at(2) - a.at(1)) * 1pt, fill: white, stroke: 0.7pt + petroleo))
      }
    }
    for f in frames { draw-frame(f, 1) }
    // mensajes
    for m in msgs {
      let it = items.at(m.i)
      let lab = text(size: size, fill: if it.style == "reply" { muted } else { ink }, labels.at(m.i))
      let paint = if it.style == "reply" { muted } else { petroleo }
      let dash = if it.style in ("reply", "create") { "dashed" } else { none }
      if m.selfm {
        let x = xs.at(m.a) + 3.5; let y0 = m.y; let w = S * 2.6
        _ln((x, y0), (x + w, y0), paint: paint); _ln((x + w, y0), (x + w, y0 + S * 1.4), paint: paint)
        _ln((x + w, y0 + S * 1.4), (x + 7, y0 + S * 1.4), paint: paint)
        _arrow-filled((x + w, y0 + S * 1.4), (x + 7, y0 + S * 1.4), paint: paint)
        place(top + left, dx: (x + w + S * 0.6) * 1pt, dy: (y0 - S * 0.2) * 1pt, lab)
      } else {
        let dir = if m.b > m.a { 1 } else { -1 }
        let off(j) = if parts.at(j).kind == "actor" { 0 } else { 3.5 }
        let p = (xs.at(m.a) + dir * off(m.a), m.y)
        let q = (xs.at(m.b) - dir * off(m.b), m.y)
        _ln(p, q, paint: paint, th: 0.75pt, dash: dash)
        if it.style == "sync" { _arrow-filled(p, q, paint: paint) } else { _arrow-open(p, q, paint: paint) }
        if it.style == "destroy" {
          _ln((q.at(0) - 5, m.y - 5), (q.at(0) + 5, m.y + 5), th: 1.2pt); _ln((q.at(0) - 5, m.y + 5), (q.at(0) + 5, m.y - 5), th: 1.2pt)
        }
        let lw = measure(lab).width / 1pt
        let lx = (p.at(0) + q.at(0)) / 2 - lw / 2
        place(top + left, dx: lx * 1pt, dy: (m.y - S * 1.45) * 1pt, lab)
      }
    }
    // notas
    for nt in notes {
      let lo = calc.min(..nt.cols); let hi = calc.max(..nt.cols)
      let w = calc.max(nt.w + S * 1.6, xs.at(hi) - xs.at(lo) + S * 3)
      let cx = (xs.at(lo) + xs.at(hi)) / 2
      place(top + left, dx: (cx - w / 2) * 1pt, dy: (nt.y - S * 0.5) * 1pt,
        block(width: w * 1pt, fill: rgb("#FFF8E1"), stroke: 0.6pt + rgb("#C9A227"), inset: S * 0.5 * 1pt, align(center, nt.body)))
    }
  })
  _fit(W, H, avail, max-scale, max-height, drawing)
})

// ============================================================ stakeholders
#let _att-color(a) = if a == "supporter" { sinapsis } else if a == "critic" { brasa } else { muted }
#let _dot(i, a, r: 7pt, size: 7pt) = circle(radius: r, fill: _att-color(a), stroke: 0.8pt + white,
  inset: 0pt, align(center + horizon, text(size: size, weight: 700, fill: white, str(i))))

// Matriz poder / interés (Tema 3): cuatro cuadrantes
#let stakeholder-grid(d, side: 11cm, names: true, size: 7.5pt) = context {
  let st = d.data.stakeholders
  let s = side / 1pt
  let L = 26.0   // margen para los ejes
  let q(x, y, title, sub, fill) = place(top + left, dx: (L + x) * 1pt, dy: y * 1pt,
    rect(width: s / 2 * 1pt, height: s / 2 * 1pt, fill: fill, stroke: 0.6pt + white, inset: 7pt, {
      set par(leading: 0.3em)
      text(size: size * 1.15, weight: 700, fill: petroleo, title); linebreak()
      text(size: size * 0.95, fill: muted, sub)
    }))
  box(width: (s + L + 4) * 1pt, height: (s + L) * 1pt, {
    q(0, 0, [Mantener satisfechos], [Context setters · blockers], rgb("#EEF4F4"))
    q(s / 2, 0, [Gestionar de cerca], [Champions · drivers], rgb("#FCE9E1"))
    q(0, s / 2, [Monitorizar], [Crowd · bystanders], niebla)
    q(s / 2, s / 2, [Mantener informados], [Defenders · subjects], rgb("#E6F2EF"))
    _ln((L, s), (L + s, s), th: 1pt); _arrow-filled((L, s), (L + s + 2, s))
    _ln((L, s), (L, 0), th: 1pt); _arrow-filled((L, s), (L, -2))
    place(top + left, dx: (L + s / 2 - 20) * 1pt, dy: (s + 6) * 1pt, text(size: size * 1.1, weight: 700, fill: petroleo)[Interés →])
    place(top + left, dx: 2pt, dy: (s / 2 + 40) * 1pt, rotate(-90deg, origin: top + left, text(size: size * 1.1, weight: 700, fill: petroleo)[Poder / influencia →]))
    for (i, x) in st.enumerate() {
      let px = L + x.interest * s; let py = s - x.power * s
      place(top + left, dx: (px - 7) * 1pt, dy: (py - 7) * 1pt, _dot(i + 1, x.attitude))
      if names {
        let t = text(size: size * 0.92, fill: ink, x.name)
        let w = measure(t).width / 1pt
        let flip = px + 10 + w > L + s - 2
        place(top + left, dx: (if flip { px - 10 - w } else { px + 10 }) * 1pt, dy: (py - 4.5) * 1pt, t)
      }
    }
  })
}

// La cebolla (Tema 3): anillos según cuánto hay que involucrarlos y
// cuatro sectores (decisores, clientes, influyentes, proveedores)
#let stakeholder-onion(d, side: 11cm, size: 7.5pt) = context {
  let st = d.data.stakeholders
  let s = side / 1pt
  let c = s / 2
  let R = (s * 0.17, s * 0.27, s * 0.37, s * 0.47)
  let fills = (rgb("#FCE9E1"), rgb("#F6EFE9"), rgb("#EEF4F4"), niebla)
  let ring-names = ([Vital involucrarlos], [Necesario involucrarlos], [Bien involucrarlos], [Informar por cortesía])
  box(width: s * 1pt, height: s * 1pt, {
    for r in range(3, -1, step: -1) {
      place(top + left, dx: (c - R.at(r)) * 1pt, dy: (c - R.at(r)) * 1pt,
        circle(radius: R.at(r) * 1pt, fill: fills.at(r), stroke: 0.7pt + hairline.darken(20%)))
    }
    _ln((c - R.at(3), c), (c + R.at(3), c), paint: hairline.darken(30%), th: 0.6pt, dash: "dashed")
    _ln((c, c - R.at(3)), (c, c + R.at(3)), paint: hairline.darken(30%), th: 0.6pt, dash: "dashed")
    place(top + left, dx: (c - 28) * 1pt, dy: (c - 9) * 1pt, box(width: 56pt, height: 18pt, fill: petroleo, radius: 9pt,
      align(center + horizon, text(size: size * 0.95, weight: 700, fill: white, d.data.product))))
    // sectores: decisores arriba a la izquierda, clientes arriba a la derecha,
    // influyentes abajo a la derecha, proveedores abajo a la izquierda
    let sectors = (decisores: (180deg, 270deg), clientes: (270deg, 360deg), influyentes: (0deg, 90deg), proveedores: (90deg, 180deg))
    let corner = (decisores: (0, 0), clientes: (s, 0), influyentes: (s, s), proveedores: (0, s))
    for (k, v) in corner {
      let t = text(size: size * 1.2, weight: 700, fill: brasa, upper(k))
      let w = measure(t).width / 1pt
      place(top + left, dx: (if v.at(0) > 0 { v.at(0) - w } else { 0 }) * 1pt, dy: (if v.at(1) > 0 { v.at(1) - 10 } else { 0 }) * 1pt, t)
    }
    // anillos: el nombre de cada uno arriba, en el eje
    for r in range(4) {
      let r0 = if r == 0 { 9.0 } else { R.at(r - 1) }
      let t = text(size: size * 0.75, fill: muted, ring-names.at(r))
      let w = measure(t).width / 1pt
      place(top + left, dx: (c + 3) * 1pt, dy: (c - (r0 + R.at(r)) / 2 - (if r == 0 { -6 } else { 3 })) * 1pt, t)
    }
    for (k, ang) in sectors {
      for r in range(4) {
        let grp = st.enumerate().filter(((i, x)) => x.sector == k and x.ring == r)
        let r0 = if r == 0 { 34.0 } else { R.at(r - 1) }
        let rad = (r0 + R.at(r)) / 2
        for (j, (i, x)) in grp.enumerate() {
          let a = ang.at(0) + (ang.at(1) - ang.at(0)) * (j + 1) / (grp.len() + 1)
          let px = c + rad * calc.cos(a); let py = c + rad * calc.sin(a)
          place(top + left, dx: (px - 7) * 1pt, dy: (py - 7) * 1pt, _dot(i + 1, x.attitude))
        }
      }
    }
  })
}

// Leyenda de colores (actitud)
#let stakeholder-legend(size: 8pt) = {
  let it(a, name) = box(inset: (right: 12pt), { box(baseline: 2pt, circle(radius: 4.5pt, fill: _att-color(a), stroke: none)); h(4pt); text(size: size, fill: muted, name) })
  it("supporter", [A favor]); it("neutral", [Neutral]); it("critic", [En contra o con reservas])
}

// Tabla de stakeholders con número, sector, anillo y notas
#let stakeholder-table(d, size: 8.5pt) = {
  let rings = ("Vital", "Necesario", "Bien", "Cortesía")
  set text(size: size)
  table(columns: (auto, 1.25fr, 0.8fr, auto, 2.4fr), stroke: none, inset: (x: 6pt, y: 5pt),
    fill: (_, y) => if y == 0 { petroleo } else if calc.odd(y) { rgb("#EEF4F4") } else { white },
    align: (center, left, left, left, left),
    table.header(..([N.º], [Stakeholder], [Sector], [Involucrar], [Qué le importa y cómo lo gestionamos]).map(h => text(fill: white, weight: 700, h))),
    ..d.data.stakeholders.enumerate().map(((i, x)) => (
      _dot(i + 1, x.attitude, r: 6pt, size: 6.5pt),
      [*#x.name* \ #text(fill: muted, size: size * 0.92, x.role)],
      upper(x.sector.first()) + x.sector.slice(1),
      rings.at(x.ring),
      x.notes,
    )).flatten())
}

// ============================================================ visión
#let vision-pitch(d, size: 11pt) = {
  let v = d.data
  let hl(c, body) = text(fill: c, weight: 700, body)
  let row(k, body) = (text(font: headingfont, weight: 700, fill: brasa, size: size * 0.92, k), text(size: size, body))
  block(width: 100%, fill: niebla, stroke: (left: 4pt + chispa), inset: (x: 16pt, y: 14pt), breakable: false, align(left,
    grid(columns: (auto, 1fr), column-gutter: 14pt, row-gutter: 9pt, align: left + top,
      ..row([Para], v.forWho),
      ..row([que], v.who),
      ..row([el producto], hl(petroleo, v.product)),
      ..row([es], v.isA),
      ..row([que], v.that),
      ..row([A diferencia de], v.unlike),
      ..row([nuestro producto], v.ourProduct),
    )))
}

// Parte una secuencia larga en dos, por una rama («else») del fragmento
// principal. Devuelve (parte1, parte2, mensajes de la parte 1): el mismo
// diagrama en dos trozos; la segunda parte vuelve a abrir el fragmento.
#let split-sequence(d, guard) = {
  let items = d.data.items
  let depth = 0
  let cut = none
  let op = none
  for (i, it) in items.enumerate() {
    if it.t == "open" and it.op != "ref" { if depth == 0 { op = it.op }; depth += 1 }
    else if it.t == "close" and depth > 0 and not (i > 0 and items.at(i - 1).t == "open" and items.at(i - 1).op == "ref") { depth -= 1 }
    else if it.t == "else" and depth == 1 and it.guard == guard { cut = i }
  }
  let a = items.slice(0, cut) + ((id: "cut-close", t: "close"),)
  let b = ((id: "cut-open", t: "open", op: op, guard: guard),) + items.slice(cut + 1)
  let n1 = a.filter(it => it.t == "msg").len()
  let with-items(its) = { let dd = d; let data = d.data; data.items = its; dd.data = data; dd }
  (with-items(a), with-items(b), n1)
}

// Parte una secuencia por la mitad (o por el mensaje `at`): la primera parte
// cierra los fragmentos que quedan abiertos y la segunda los vuelve a abrir
// con «(sigue)». Sirve para ponerla en dos columnas en una diapositiva.
#let halve-sequence(d, at: auto) = {
  let items = d.data.items
  let msgs = items.enumerate().filter(((i, it)) => it.t == "msg").map(((i, it)) => i)
  // punto de corte: el mensaje más cercano a la mitad con menos fragmentos abiertos
  let depth-at = (:)
  let stack = ()
  for (i, it) in items.enumerate() {
    depth-at.insert(str(i), stack.len())
    if it.t == "open" { stack.push(it) } else if it.t == "close" and stack.len() > 0 { let _ = stack.pop() }
  }
  let mid = msgs.at(calc.quo(msgs.len(), 2))
  let cut = if at != auto { at } else {
    // alto aproximado de cada elemento (mensajes y fragmentos), para cortar por la mitad del alto
    let h(it) = if it.t == "msg" { 3 } else if it.t == "note" { 4 } else if it.t == "open" and it.op == "ref" { 5 } else { 2 }
    let total = items.map(h).sum()
    let acc = 0
    let before = (:)
    for (i, it) in items.enumerate() { before.insert(str(i), acc); acc += h(it) }
    let score(i) = calc.abs(before.at(str(i)) - total / 2) + depth-at.at(str(i)) * 2
    let best = msgs.at(0)
    for i in msgs { if score(i) < score(best) and items.at(i).style != "reply" { best = i } }
    best
  }
  let open = ()
  for it in items.slice(0, cut) {
    if it.t == "open" { open.push(it) }
    else if it.t == "close" and open.len() > 0 { let _ = open.pop() }
    else if it.t == "else" and open.len() > 0 { let o = open.pop(); o.guard = it.guard; open.push(o) }
  }
  let a = items.slice(0, cut) + open.map(o => (id: "c", t: "close"))
  let b = open.map(o => (id: "o", t: "open", op: o.op, guard: o.guard + " (sigue)")) + items.slice(cut)
  let n1 = a.filter(it => it.t == "msg").len()
  let with-items(its) = { let dd = d; let data = d.data; data.items = its; dd.data = data; dd }
  (with-items(a), with-items(b), n1)
}

// Secuencia en dos columnas (para diapositivas): mismo tamaño en las dos
#let sequence-two-columns(d, size: 8.5pt, gutter: 1.2cm) = {
  let (a, b, n) = halve-sequence(d)
  grid(columns: 2, column-gutter: gutter, align: top,
    sequence-diagram(a, size: size, max-scale: none),
    grid.vline(stroke: (paint: hairline, dash: "dashed")),
    sequence-diagram(b, size: size, max-scale: none, number-from: n + 1))
}

// ============================================================
//  U-tad COMPACT ASSIGNMENT / problem-set template (Typst)
//
//  For short deliverables -- a handful of questions, ~2-5 pages. Unlike
//  utad.typ's report template there is NO cover page and NO separate
//  contents page: page 1 opens with a compact masthead (logo, title,
//  info box, rule), and the content flows straight on. Chapters do not
//  start new pages.
//
//  Usage:
//    #import "neuranet-assignment.typ": *
//    #show: assignment.with(
//      title: [Problem Set 3],
//      subtitle: [Series and Fourier Transforms],   // optional
//      subject: [Mathematical Analysis],
//      teacher: [Teacher Name],
//      author: "Neuranet",
//      date: "May 24, 2026",
//      contents: true,          // optional inline contents list
//    )
//
//    = Question 1
//    ...
//
//  It re-exports everything from utad.typ, so the whole brand toolkit --
//  `callout`, `note`, `important`, `exercise`, `prompt`/`response`,
//  `neuranet-table` -- is available in an assignment too, same look as the
//  report. (The report-only report extras live in neuranet-report.typ.)
// ============================================================

#import "neuranet.typ": *

// Compact TWO-COLUMN info box for the assignment header: the fields are
// split into two side-by-side label|value mini-tables (first half left,
// second half right), with tighter row padding than the report cover's
// single-column box -- so the same details take about half the height.
// Bold muted-grey labels, navy values; empty fields are skipped.
#let compact-info(pairs) = {
  let rows = pairs.filter(p => p.at(1) != none)
  let half = calc.ceil(rows.len() / 2)
  let mini(rs) = table(
    columns: (auto, auto),
    align: (right + top, left + top),
    inset: (x, y) => (left: if x == 0 { 0pt } else { 9pt }, right: 0pt, top: 2.5pt, bottom: 2.5pt),
    stroke: none,
    ..rs.map(p => (
      text(fill: muted, weight: 700)[#p.at(0)],
      text(fill: petroleo)[#p.at(1)],
    )).flatten()
  )
  grid(
    columns: (auto, auto),
    column-gutter: 1.4cm,
    mini(rows.slice(0, half)),
    mini(rows.slice(half)),
  )
}

#let neuranet-breve(
  title: [Título del documento],
  doc-type: [Nota técnica],       // tipo: Acta de reunión, Nota técnica, Presupuesto…
  subtitle: none,                 // línea opcional bajo el título
  client: none,
  project: none,
  reference: none,                // p. ej. "NN-AM-ACT-01"
  version: none,
  status: none,
  date: none,
  author: "Neuranet",             // quién lo prepara
  confidential: true,
  extra: (),                      // filas extra para la ficha: (([Lugar], [Online]),)
  logo-variant: "full",           // "full" | "mark" | "none"
  contents: false,                // índice corto bajo la cabecera
  lang: "es",
  body,
) = {
  // ---- logo ----
  let logo-block = if logo-variant == "mark" {
    image("logo-mark.svg", width: 1.3cm)
  } else if logo-variant == "wordmark" {
    image("logo-wordmark.svg", width: 2.5cm)
  } else if logo-variant == "full" {
    image("logo-full.svg", width: 4.4cm)
  } else { none }

  // See utad.typ: Typst can't detect a missing file, so logo-variant "none"
  // (or "text") is the single switch that avoids every logo image -- masthead
  // AND footer -- so the assignment builds with no logo assets present.
  let bare = logo-variant == "none" or logo-variant == "text"

  set document(
    title: to-plain-string(title),   // content -> string; see utad.typ
    author: author,
  )
  set text(font: sansfont, size: 10.5pt, fill: ink, lang: lang)
  set par(justify: true, leading: 0.64em, spacing: 0.8em)
  set list(marker: nn-list-markers)   // squared, on-identity (see utad.typ)
  show link: set text(fill: brasa)
  set heading(numbering: "1.1")

  // heading number: light-blue number + gap, same as the report
  let hnum(it) = context {
    if it.numbering != none {
      text(fill: brasa)[#numbering(it.numbering, ..counter(heading).at(it.location()))]
      h(0.45em)
    }
  }
  // COMPACT headings: no page breaks (a 2-5 page doc flows continuously),
  // modest sizes. Level-1 keeps the house-style navy underline rule.
  show heading.where(level: 1): it => block(above: 1.2em, below: 0.7em, sticky: true, {
    set text(fill: petroleo, size: 13.5pt, weight: 700, font: headingfont)
    stack(spacing: 5pt,
      { hnum(it); it.body },
      line(length: 100%, stroke: 0.5pt + petroleo),
    )
  })
  show heading.where(level: 2): it => block(above: 1em, below: 0.55em, sticky: true, {
    set text(fill: petroleo, size: 12pt, weight: 700, font: headingfont)
    hnum(it); it.body
  })
  show heading.where(level: 3): it => block(above: 0.85em, below: 0.5em, sticky: true, {
    set text(fill: petroleo, size: 11pt, weight: 700, font: headingfont)
    hnum(it); it.body
  })

  // code -- same look as the report, line numbers in a grey gutter
  show raw.where(block: true): it => block(
    width: 100%, fill: codebg, radius: 0pt, inset: 9pt,
    stroke: 0.6pt + hairline, above: 0.8em, below: 0.8em,
  )[
    #set text(size: 8.6pt, font: monofont)
    #show raw.line: ln => {
      box(width: 1.6em, align(right, text(fill: muted)[#ln.number]))
      h(0.9em)
      ln.body
    }
    #it
  ]
  show raw.where(block: false): it => box(
    fill: rgb("#EBF0F0"), inset: (x: 3pt), outset: (y: 3pt), radius: 0pt,
  )[#text(size: 0.92em, font: monofont, fill: ink)[#it]]

  set figure(gap: 8pt)
  show figure.caption: set text(size: 9pt, fill: muted)

  // outline styling (used only if `contents: true`) -- compact, inline
  set outline(depth: 2, indent: auto)
  let toc-entry(it, w, color: petroleo) = link(it.element.location(), it.indented(
    text(fill: brasa, weight: w, font: headingfont)[#it.prefix()],
    text(fill: color, weight: w, font: headingfont)[#it.inner()],
  ))
  show outline.entry.where(level: 1): it => { v(4pt, weak: true); toc-entry(it, 600, color: petroleo) }
  show outline.entry.where(level: 2): it => { v(2pt, weak: true); toc-entry(it, 400, color: muted) }

  // ---- page: normal margins, simple header/footer, NO cover ----
  set page(
    paper: "a4",
    margin: (x: 2.5cm, top: 2.2cm, bottom: 2cm),
    header: context {
      if counter(page).get().first() > 1 {
        set text(size: 8.5pt, fill: muted)
        let right-bits = (client, reference).filter(x => x != none)
        grid(columns: (1fr, auto), align: (left + horizon, right + horizon),
          { if not bare { box(baseline: 20%, image("logo-mark.svg", height: 10pt)); h(6pt) }; title },
          right-bits.join([ · ]))
        v(4pt)
        line(length: 100%, stroke: 0.5pt + rgb("#C9D6D8"))
      }
    },
    footer: context {
      set text(size: 8.5pt, fill: muted)
      line(length: 100%, stroke: 0.5pt + hairline)
      v(2pt)
      grid(columns: (1fr, auto, 1fr), align: (left + horizon, center + horizon, right + horizon),
        [Neuranet#if version != none [ · v#version]],
        if confidential { text(fill: brasa, weight: 700, tracking: 0.6pt, size: 7.5pt)[CONFIDENCIAL] },
        [Página #counter(page).display() de #counter(page).final().first()],
      )
    },
    numbering: "1",
  )

  // ============ COMPACT MASTHEAD (top of page 1) ============
  // Title (left) and logo (right) share one line; a compact two-column
  // info box sits below, then the navy rule -- a tight header that leaves
  // the page for the actual content.
  block(width: 100%, breakable: false, {
    set par(justify: false)
    set text(hyphenate: false)
    place(top + left, dy: -2.2cm, dx: -2.5cm, rect(width: 21cm, height: 0.25cm, fill: petroleo))
    place(top + left, dy: -1.95cm, dx: -2.5cm, rect(width: 21cm, height: 0.06cm, fill: chispa))
    grid(
      columns: (1fr, auto),
      align: (left + bottom, right + top),
      column-gutter: 0.8cm,
      {
        if doc-type != none {
          text(size: 9.5pt, fill: brasa, weight: 600, tracking: 1.1pt, font: headingfont)[#upper(doc-type)]
          v(0.15cm)
        }
        text(size: 20pt, weight: 700, fill: petroleo, font: headingfont)[#title]
      },
      logo-block,
    )
    if subtitle != none {
      v(0.1cm)
      text(size: 11.5pt, weight: 500, fill: muted, font: headingfont)[#subtitle]
    }
    v(0.42cm)
    compact-info((
      ([Cliente], client),
      ([Proyecto], project),
      ([Referencia], reference),
      ([Versión], version),
      ([Estado], status),
      ([Fecha], date),
      ([Preparado por], author),
      ..extra,
    ))
    v(0.45cm)
    line(length: 100%, stroke: 1pt + petroleo)
  })
  v(0.4cm)

  // ---- optional inline contents (never on its own page) ----
  if contents {
    block(breakable: false, {
      text(size: 12pt, weight: 700, fill: petroleo, font: headingfont)[Índice]
      v(0.18cm)
      outline(title: none)
    })
    v(0.35cm)
    line(length: 100%, stroke: 0.5pt + hairline)
    v(0.4cm)
  }

  body
}

// Alias con el nombre original de la plantilla de partida.
#let assignment = neuranet-breve

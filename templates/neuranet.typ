// ============================================================
//  Neuranet — plantilla de documentos (Typst)
//  Versión con la marca de Neuranet de la plantilla utad-templates
//  (misma estructura y componentes; cambian logo, colores, fuentes y textos).
//  Import it with:  #import "neuranet.typ": *
//  Then:            #show: neuranet-doc.with(title: [...], author: "...", ...)
// ============================================================

// ---------- Brand palette (edit here to retune) ----------
// Paleta de Neuranet (ver entrega-1/marca/MARCA.md)
#let petroleo = rgb("#12343B")   // PRINCIPAL: logotipo, títulos, tablas, bordes
#let brasa    = rgb("#C2410C")   // ACENTO para texto: números de apartado, enlaces, subtítulos (5,2:1 sobre blanco)
#let chispa   = rgb("#FF6A3D")   // ACENTO gráfico: la neurona del logo, marcas y barras. Nunca texto pequeño sobre blanco
#let sinapsis = rgb("#2E8B7A")   // SECUNDARIO para diagramas
#let niebla   = rgb("#F4F7F7")   // fondo claro
#let ink       = rgb("#1A2B30")   // body text
#let muted     = rgb("#5A6E73")   // headers/footers, captions
#let hairline  = rgb("#DCE4E5")
#let callbg    = rgb("#EEF3F3")   // callout background
#let codebg    = rgb("#F4F7F7")   // code background

// Fuentes de Neuranet: Sora (títulos), IBM Plex Sans (texto), IBM Plex Mono
// (código). Van incluidas en templates/fonts: compila con
// `--font-path templates/fonts` (lo hace compilar.sh) o instálalas.
// Original note -- Fonts. Matched to the LaTeX side (Poppins headings / Carlito body, via
// fontspec there) so a reader flipping between the two templates sees the
// same typeface, not just the same palette. Install both with
// `scripts/install-fonts.sh` (see the README).
//
// These are single families on purpose: Typst warns "unknown font family"
// for EVERY family in a stack that isn't installed, so a cross-platform
// fallback list (Helvetica Neue / Arial / …) prints noisy warnings on every
// compile even when Poppins/Carlito are present. `DejaVu Sans Mono` is one
// of Typst's built-in fonts, so it's always available. If you DO see
// "unknown font family: Poppins" (or Carlito), the fonts aren't installed —
// run the font script.
#let headingfont = "Sora"
#let sansfont = "IBM Plex Sans"
#let monofont = "IBM Plex Mono"

// Flatten content to a plain string, for `set document(title: ...)` (PDF
// metadata / viewer tab). Callers pass `title: [markup]`, which is content,
// not a string -- the old `if type(title) == str` guard therefore always
// fell through to a generic "U-tad document" fallback, so every report
// showed the same wrong title in a viewer tab and file listing. This walks
// the usual content shapes (text, sequences, wrapped bodies) and joins the
// text runs. Observed: with `title: [Image Classification with CNNs]`, pypdf
// read back "U-tad document" before and the real title after.
#let to-plain-string(it) = {
  if it == none { "" }
  else if type(it) == str { it }
  else if type(it) == content {
    if it.has("text") { it.text }
    else if it.has("children") { it.children.map(to-plain-string).join("") }
    else if it.has("body") { to-plain-string(it.body) }
    else if it.has("child") { to-plain-string(it.child) }
    else { "" }
  } else { str(it) }
}

// Squared, on-identity list markers -- the parity match to the LaTeX
// \setlist squares. Typst's default nested markers are •, then a dash (‣/-)
// at deeper levels, which is the same off-identity dash the LaTeX side had.
// Small filled squares instead: navy (dominant) at level 1, the blue accent
// at level 2, grey at level 3. Fed to `set list(marker: ...)` in each
// template's setup (neuranet-doc and assignment).
#let nn-sqmark(c, s) = box(baseline: 0.02em, square(size: s, fill: c, stroke: none))
#let nn-list-markers = (
  nn-sqmark(petroleo, 0.30em),
  nn-sqmark(chispa, 0.26em),
  nn-sqmark(muted, 0.24em),
)

// ---------- A text U-tad wordmark (fallback when no logo image) ----------
#let nn-wordmark = align(center)[
  #box(fill: petroleo, inset: (x: 11pt, y: 7pt), radius: 0pt,
    text(fill: white, weight: 700, size: 21pt)[Neuranet])
]

// ============================================================
//  Callouts
// ============================================================
#let callout(body, title: none, accent: petroleo, bg: callbg) = block(
  width: 100%, fill: bg, radius: 0pt, inset: (x: 11pt, y: 9pt), breakable: false,
  stroke: (left: 3pt + accent), above: 0.75em, below: 0.75em,
)[
  // force left alignment so the box reads correctly even inside a centred
  // context (e.g. a centre-aligned slide)
  #set align(left)
  #if title != none [ #text(weight: 700, fill: accent)[#title]#v(3pt, weak: false) ]
  #body
]

// Inline-titled variants that match the report's AI boxes
#let prompt(body) = block(
  width: 100%, fill: callbg, radius: 0pt, inset: (x: 11pt, y: 9pt),
  stroke: (left: 3pt + petroleo), above: 0.75em, below: 0.75em,
)[#text(weight: 700)[Prompt: ]#text(style: "italic")[#body]]

#let response(body) = block(
  width: 100%, fill: callbg, radius: 0pt, inset: (x: 11pt, y: 9pt),
  stroke: (left: 3pt + petroleo), above: 0.75em, below: 0.75em,
)[#text(weight: 700)[Respuesta: ]#body]

#let note(body, title: "Nota") = callout(body, title: title, accent: brasa)

// The navy-accent sibling of note(): same left-border callout shape as the
// blue note/callout boxes, but keyed to the dark-navy accent instead of the
// bright blue -- navy title, navy left rule, and a LIGHT navy-tint
// background (rgb("#E2EBEC"), a lightened version of the navy ink, cooler
// and greyer than the note box's light-blue #eef2f8 so the two read as
// distinct-but-related). Used for the one or two notices per document that
// should carry the heavier navy accent rather than the everyday blue one.
// (Was a solid navy fill with reversed white text; changed to match the
// light callout family so all the status boxes share one visual language.)
#let important(body, title: "Importante") = callout(
  body, title: title, accent: petroleo, bg: rgb("#E2EBEC"),
)

// ============================================================
//  Titled exercise / problem box
// ============================================================
#let exercise(title, body) = block(
  width: 100%, above: 1.2em, below: 1em, breakable: true,
  stroke: 0.6pt + hairline, radius: 0pt, clip: true,
)[
  #stack(
    block(fill: petroleo, inset: (x: 11pt, y: 6pt), width: 100%,
      text(fill: white, weight: 700)[#title]),
    block(inset: (x: 11pt, y: 9pt), width: 100%, body),
  )
]

// ============================================================
//  Question / Solution convention (for solution sets)
// ============================================================
// For a solutions document -- one where you restate the given problem and
// then work it -- put the verbatim problem statement in `question[...]` and
// let your worked answer flow underneath, opened with `solution`. The box
// is a LIGHT tinted panel with a navy left rule and a small "QUESTION"
// eyebrow: enough to set the given task apart from your work, without the
// heavy dark bar of `exercise()` (which would double up under a numbered
// "Exercise N" heading). Pair with a numbered level-1 heading per item.
#let question(body, label: "Enunciado") = block(
  width: 100%, fill: rgb("#EEF3F3"), radius: 0pt, inset: (x: 11pt, y: 9pt),
  stroke: (left: 3pt + petroleo), above: 0.75em, below: 0.9em, breakable: true,
)[
  #text(weight: 700, fill: muted, size: 0.78em)[#upper(label)]
  #v(3pt, weak: true)
  #body
]

// Run-in "Solution." lead-in for the worked answer under a question box.
// Use inline for a prose answer (`#solution[The radius is ...]`) or just as
// a label before block content (code, displayed math): `#solution[]` then
// the blocks on following lines.
#let solution(body) = { text(weight: 700, fill: petroleo)[Solución.]; if body != [] { [ ]; body } }

// ============================================================
//  Helper tables
// ============================================================
// A striped table with a navy header row.
#let neuranet-table(columns: auto, header: (), cell-align: left,
    inset: (x: 10pt, y: 8pt), ..rows) = { set par(justify: false); table(
  columns: columns,
  // explicit cell alignment so an outer centred context (e.g. a centre-
  // aligned slide) doesn't centre the cells; pass a function for per-column
  // control, e.g. (col, row) => if col == 0 { left } else { center }
  align: cell-align,
  stroke: none,
  // cell padding — bump `inset` (esp. the y value) for roomier rows on slides
  inset: inset,
  // Zebra stripe is #eef3fc -- the exact same tint as the LaTeX side's
  // utadlight zebra row, so a table looks identical across the two
  // templates. (Was #f5f8fc here, noticeably fainter than LaTeX's stripe;
  // synced so the striping reads with the same strength in both.)
  fill: (_, y) => if y == 0 { petroleo } else if calc.odd(y) { rgb("#EEF4F4") } else { white },
  table.header(..header.map(h => text(fill: white, weight: 700)[#h])),
  ..rows.pos(),
) }

// A cover metadata table (right-aligned blue labels | values), like the notes cover.
#let info-table(..pairs) = align(center, table(
  columns: 2, stroke: none, align: (right, left), inset: (x: 8pt, y: 3pt),
  ..pairs.pos().map(p => (text(fill: petroleo, weight: 600)[#p.at(0)], [#p.at(1)])).flatten(),
))

// Cover metadata block: bold muted-grey labels (right-aligned, same grey
// as the "ACADEMIC DIVISION" eyebrow above), then values in navy
// (left-aligned) -- a clean two-column "spec sheet", no divider rule.
//
// The label column is `auto` (width of the widest label), and the label
// cell's LEFT inset is 0, so the widest label sits exactly on the page's
// left margin -- the block anchors on the same left edge as the logo and
// title above it (the cover's organizing principle) instead of floating
// inset. The value column carries the only horizontal gap (its 14pt left
// inset), so label and value are cleanly separated by whitespace alone.
// (Skips empty fields.)
#let cover-info(pairs) = table(
  columns: (auto, 1fr),
  align: (right + top, left + top),
  inset: (x, y) => (
    left: if x == 0 { 0pt } else { 14pt },
    right: 0pt,
    top: 5pt, bottom: 5pt,
  ),
  stroke: none,
  ..pairs.filter(p => p.at(1) != none).map(p => (
    text(fill: muted, weight: 700)[#p.at(0)],
    text(fill: petroleo)[#p.at(1)],
  )).flatten()
)

// ============================================================
//  The main document template
// ============================================================
// ============================================================
//  Evolution-chain diagram
// ============================================================
// A horizontal chain of small labelled boxes connected by arrows —
// used for "version 1 -> version 2 -> ... " style progressions.
// Each item is (version-label, description, style), where style is
// one of "start" (muted grey, for a received/legacy starting point),
// "mid" (light navy-tinted, in-progress), or "final" (solid navy,
// the arrived-at/highlighted endpoint). Mirrors the LaTeX report's
// schema-evolution-chain TikZ diagrams.
#let evo-box(version, label, style: "mid") = {
  let (bg, fg, bd) = if style == "start" {
    (white, muted, muted)
  } else if style == "final" {
    (petroleo, white, petroleo)
  } else {
    (rgb("#EEF3F3"), petroleo, petroleo)
  }
  box(
    width: 100%, height: 1.5cm,
    fill: bg, stroke: 1pt + bd, radius: 0pt, inset: 5pt,
    align(center + horizon)[
      #text(fill: fg, size: 10pt, weight: 700)[#version] \
      #v(1pt, weak: true)
      #text(fill: fg, size: 8.5pt)[#label]
    ],
  )
}

// Small helper: split an array into chunks of at most `n` items.
#let chunk(arr, n) = {
  let out = ()
  let i = 0
  while i < arr.len() {
    out.push(arr.slice(i, calc.min(i + n, arr.len())))
    i += n
  }
  out
}

// Boxes get `1fr` columns (so Typst divides the available width equally
// among however many items are in that row) and arrows get `auto`
// columns (small, fixed). This is the important part: never give the
// boxes a fixed absolute width, or they'll overlap/overflow instead of
// shrinking to fit. `per-row` controls how many boxes share one row
// before wrapping to the next -- keep this low enough (3-4) that each
// box stays wide enough for its label not to wrap into a cramped tower
// of single words.
#let evolution-chain(..items, per-row: 4) = {
  let parts = items.pos()
  let rows = chunk(parts, per-row)
  stack(spacing: 7pt, ..rows.map(row-items => align(center, {
    let n = row-items.len()
    let cols = ()
    for i in range(n) {
      cols.push(1fr)
      if i < n - 1 { cols.push(auto) }
    }
    grid(
      columns: cols,
      column-gutter: 3pt,
      align: horizon,
      ..row-items.enumerate().map(((i, it)) => {
        let b = evo-box(it.at(0), it.at(1), style: it.at(2, default: "mid"))
        if i == 0 { (b,) } else { (text(fill: muted, size: 13pt)[→], b) }
      }).flatten()
    )
  })))
}

#let neuranet-doc(
  title: [Título del documento],
  doc-type: [Propuesta técnica],   // tipo de documento: Propuesta técnica, Especificación de requisitos, Informe…
  subtitle: none,                  // línea opcional bajo el título
  client: none,                    // cliente, p. ej. [Bodegas …]
  project: none,                   // proyecto, p. ej. [AñadaMaster]
  reference: none,                 // referencia interna, p. ej. "NN-AM-001"
  version: "1.0",
  status: none,                    // p. ej. [Borrador] | [En revisión] | [Final]
  date: none,
  author: "Neuranet",              // quién lo prepara (personas de Neuranet)
  confidential: true,              // marca «Confidencial» en portada y pie
  variant: "full",                 // logo: "full" | "mark" | "text" | "none"
  logo: none,                      // ruta a otro logo; sustituye a `variant`
  logo-width: auto,
  lang: "es",
  short-title: auto,               // título en la cabecera; por defecto, `title`
  chapter-break: true,             // cada capítulo (=) empieza en una página nueva; false = texto seguido
  body,
) = {
  let short = if short-title == auto { title } else { short-title }

  // Whether this document uses the (trademarked, non-MIT) logo image assets.
  // Typst has NO file-existence check and NO try/catch -- unlike the LaTeX
  // side, which wraps every logo in \IfFileExists and silently degrades to a
  // bare cover -- so a fresh clone (or a fork that stripped the U-tad marks)
  // cannot auto-detect missing SVGs; it would hard-fail at the first image().
  // Instead, `variant: "none"` (or "text") is a single, documented switch
  // that avoids EVERY logo image in the document -- the cover below AND the
  // page footer's mark -- so the template builds with no asset files present.
  // "text" stands in a text "U-tad" wordmark; "none" omits the mark entirely.
  let bare = variant == "none" or variant == "text"

  // Pick the cover logo — DARK ink, since it now sits standalone in the
  // white body (masthead-style), not on a navy band.
  let logo-block = if logo != none {
    image(logo, width: if logo-width == auto { 4.5cm } else { logo-width })
  } else if variant == "mark" {
    image("logo-mark.svg", width: if logo-width == auto { 1.4cm } else { logo-width })
  } else if variant == "wordmark" {
    image("logo-wordmark.svg", width: if logo-width == auto { 5cm } else { logo-width })
  } else if variant == "full" {
    // Full lockup: mark + wordmark + "University of Technology, Arts &
    // Design" tagline. Wider than the bare wordmark, so its default width
    // is larger to keep the mark itself a comparable size.
    image("logo-full.svg", width: if logo-width == auto { 7cm } else { logo-width })
  } else if variant == "text" {
    text(fill: petroleo, weight: 700, size: 21pt)[Neuranet]
  } else { none }

  set document(title: to-plain-string(title), author: author)
  set text(font: sansfont, size: 10.5pt, fill: ink, lang: lang)
  set par(justify: true, leading: 0.64em, spacing: 0.8em)
  set list(marker: nn-list-markers)   // squared, on-identity (see utad.typ)
  show link: set text(fill: brasa)
  set heading(numbering: "1.1")

  // --- Heading styles: light-blue number + dark title, kept with the content ---
  let hnum(it) = context {
    if it.numbering != none {
      text(fill: brasa)[#numbering(it.numbering, ..counter(heading).at(it.location()))]
      h(0.45em)
    }
  }
  // Heading scale + spacing matched to the LaTeX side (\Huge chapter /
  // \Large section / \large subsection = ~24 / 14 / 12pt) so the two
  // templates share one heading hierarchy. Level-1 headings also start a
  // new page (weak pagebreak, so no blank page when already at the top) --
  // the report convention the LaTeX `report` class applies, giving each
  // top-level section its own opening page. Sizes below body (10.5pt) are
  // avoided so every level stays clearly above running text.
  show heading.where(level: 1): it => {
    if chapter-break { pagebreak(weak: true) }
    block(above: if chapter-break { 0pt } else { 30pt }, below: if chapter-break { 26pt } else { 18pt }, sticky: true, {
      set text(fill: petroleo, size: if chapter-break { 24pt } else { 20pt }, weight: 700, font: headingfont)
      stack(spacing: 9pt,
        { hnum(it); it.body },
        line(length: 100%, stroke: 0.5pt + petroleo),   // discrete dark divider
      )
    })
  }
  show heading.where(level: 2): it => block(above: 17pt, below: 10pt, sticky: true, {
    set text(fill: petroleo, size: 14pt, weight: 700, font: headingfont)
    hnum(it); it.body
  })
  show heading.where(level: 3): it => block(above: 13pt, below: 8pt, sticky: true, {
    set text(fill: petroleo, size: 12pt, weight: 700, font: headingfont)
    hnum(it); it.body
  })
  // Fourth level (====): the parity match to the LaTeX \subsubsection. One
  // step down again (11pt), navy Poppins bold, led by a small blue square
  // (the list-marker accent) instead of a number -- so it reads as a
  // lightweight "named phase" for breaking up a long run. No hnum(): the
  // outline is capped at depth 3 (above), so like the LaTeX 4th level this
  // stays out of the contents and carries no number.
  show heading.where(level: 4): it => block(above: 11pt, below: 4pt, sticky: true, {
    set text(fill: petroleo, size: 11pt, weight: 700, font: headingfont)
    box(baseline: 0.02em, square(size: 0.30em, fill: chispa, stroke: none))
    h(0.5em)
    it.body
  })

  // --- Code ---
  // Block code carries line numbers down the left in a small grey gutter
  // (matching the LaTeX `numbers=left` listing). `raw.line` gives each
  // line its number + body; the number is right-aligned in a fixed-width
  // box so the gutter edge stays straight regardless of digit count.
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
  // Inline code always sits on its own light-grey chip, even when the
  // surrounding paragraph text has been set to white (e.g. inside the
  // dark-navy `important()` box) -- so it must force its own dark text
  // color rather than inherit, or it renders as invisible white-on-light-
  // grey. Confirmed by rendering `important()` with inline code in it.
  show raw.where(block: false): it => box(
    fill: rgb("#EBF0F0"), inset: (x: 3pt), outset: (y: 3pt), radius: 0pt,
  )[#text(size: 0.92em, font: monofont, fill: ink)[#it]]

  // --- Figures / outline ---
  set figure(gap: 8pt)
  show figure.caption: set text(size: 9pt, fill: muted)
  set outline(depth: 3, indent: auto)
  // TOC: light-blue number + title, styled to match the LaTeX side's
  // tocloft setup -- chapter-level entries bold navy headingfont (like
  // \cftchapfont), section/subsection entries a lighter, unbolded grey
  // (like \cftsecfont / \cftsubsecfont) -- plus generous spacing between
  // top-level entries so the list reads with the same rhythm as the
  // LaTeX contents page instead of feeling cramped.
  let toc-entry(it, w, color: petroleo) = link(it.element.location(), it.indented(
    text(fill: brasa, weight: w, font: headingfont)[#it.prefix()],
    text(fill: color, weight: w, font: headingfont)[#it.inner()],
  ))
  // Sub-entries right under their parent (the first child -- its heading
  // counter's last component is 1) sit close to it; later siblings get
  // more room between each other -- otherwise every level-2/3 entry gets
  // the same gap and the list either reads as "parent floating far from
  // its own children" or "every entry mashed together", never both right.
  let is-first-child(it) = {
    let nums = counter(heading).at(it.element.location())
    nums.len() > 0 and nums.last() == 1
  }
  show outline.entry.where(level: 1): it => { v(14pt, weak: true); toc-entry(it, 700, color: petroleo) }
  show outline.entry.where(level: 2): it => {
    v(if is-first-child(it) { 5pt } else { 9pt }, weak: true)
    toc-entry(it, 400, color: muted)
  }
  show outline.entry.where(level: 3): it => {
    v(if is-first-child(it) { 4pt } else { 7pt }, weak: true)
    toc-entry(it, 400, color: muted)
  }

  // ---------------- PORTADA ----------------
  // Documento de empresa: logo y marca de confidencialidad arriba; tipo de
  // documento, título y «Preparado para» en el centro; ficha del documento
  // abajo; banda de marca al pie.
  page(margin: 0pt, header: none, footer: none, numbering: none)[
    #place(top, rect(width: 100%, height: 0.35cm, fill: petroleo))
    #place(top, dy: 0.35cm, rect(width: 100%, height: 0.08cm, fill: chispa))
    #place(bottom, rect(width: 100%, height: 1.1cm, fill: petroleo,
      pad(x: 2.5cm, align(horizon, grid(columns: (1fr, auto),
        text(size: 8.5pt, fill: white, weight: 600, font: headingfont)[Neuranet],
        if confidential { text(size: 8pt, fill: chispa, weight: 700, tracking: 0.8pt)[CONFIDENCIAL] },
      )))))
    #pad(left: 2.5cm, right: 2.5cm, top: 2.4cm, bottom: 3.1cm)[
      #grid(columns: (1fr, auto), align: (left + horizon, right + horizon),
        logo-block,
        if confidential { box(stroke: 0.8pt + brasa, inset: (x: 7pt, y: 4pt),
          text(size: 7.5pt, fill: brasa, weight: 700, tracking: 0.8pt)[CONFIDENCIAL]) },
      )
      #v(1.15fr)
      #[
        #set par(spacing: 0pt, justify: false)
        #set text(hyphenate: false)
        #if doc-type != none [
          #text(size: 11pt, fill: brasa, weight: 600, tracking: 1.2pt, font: headingfont)[#upper(doc-type)]
          #v(0.5cm)
        ]
        #text(size: 32pt, weight: 700, fill: petroleo, font: headingfont)[#title]
        #if subtitle != none [
          #v(0.5cm)
          #text(size: 14pt, fill: muted, font: headingfont)[#subtitle]
        ]
        #if client != none [
          #v(1.3cm)
          #text(size: 9pt, fill: muted, weight: 700, tracking: 0.8pt)[PREPARADO PARA]
          #v(0.25cm)
          #text(size: 16pt, fill: petroleo, weight: 600, font: headingfont)[#client]
        ]
      ]
      #v(1fr)
      #line(length: 100%, stroke: 1pt + petroleo)
      #v(0.45cm)
      #cover-info((
        ([Proyecto], project),
        ([Referencia], reference),
        ([Versión], version),
        ([Estado], status),
        ([Fecha], date),
        ([Preparado por], author.split(" · ").map(x => [#x]).join(linebreak())),
      ))
    ]
  ]

  // ---------------- MAIN PAGES ----------------
  set page(
    paper: "a4",
    margin: (x: 2.5cm, top: 2.5cm, bottom: 2cm),
    // Page 1 of the body is the front-matter contents page: keep it clean
    // (no running header, no footer/page number), the same treatment as the
    // cover and the LaTeX `\utadcontents`. The header/footer appear from the
    // first numbered content page (page 2) onward.
    header: context if here().page() > 2 {  // portada = 1, índice = 2: sin cabecera
      set text(size: 8.5pt, fill: muted)
      // Izquierda: símbolo + título corto. Derecha: cliente · referencia.
      let right-bits = (client, reference).filter(x => x != none)
      grid(columns: (1fr, auto), align: (left + horizon, right + horizon),
        {
          if not bare { box(baseline: 20%, image("logo-mark.svg", height: 10pt)); h(6pt) }
          short
        },
        right-bits.join([ · ]),
      )
      v(5pt)
      line(length: 100%, stroke: 0.5pt + rgb("#C9D6D8"))
    },
    footer: context if here().page() > 2 {
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
  counter(page).update(1)
  body
}

// Clean front-matter contents page: the table of contents as the first body
// page, which the template keeps free of the running header and footer/page
// number (see the page setup above) -- the same front-matter treatment as
// the cover, matching the LaTeX `\utadcontents`. Use this in the report body
// in place of a bare `#outline(...)`; content that follows starts on the
// first numbered page (page 2). Keep the TOC to a single page for the clean
// treatment to cover all of it.
#let neuranet-outline(title: [Índice], ..args) = {
  outline(title: title, ..args.named(), ..args.pos())
  pagebreak(weak: true)
}

// ============================================================
//  Control del documento (tabla de versiones)
// ============================================================
// Típica de los documentos para clientes. Cada fila: (versión, fecha, autor, cambios).
//   #version-history(
//     ("1.0", "22/10/2026", "Nombre", [Primera versión]),
//   )
#let version-history(..rows, title: [Control de versiones]) = block(breakable: false, {
  text(size: 12pt, weight: 700, fill: petroleo, font: headingfont)[#title]
  v(0.2cm)
  neuranet-table(
    columns: (auto, auto, auto, 1fr),
    header: ([Versión], [Fecha], [Autor], [Cambios]),
    ..rows.pos().flatten(),
  )
})

// ============================================================
//  Tarjetas de la misma altura
// ============================================================
// Una fila de tarjetas (valores, servicios, cifras…) que siempre miden lo
// mismo, aunque el texto de cada una sea de distinta longitud.
//   #cards(
//     (title: [Innovación], body: [...], accent: brasa),
//     (title: [Integridad], body: [...], accent: petroleo),
//   )
// columns: cuántas por fila (por defecto, todas en una fila).
#let cards(..items, columns: none, gutter: 10pt, inset: (x: 12pt, y: 11pt), title-size: 1.05em) = layout(size => {
  let its = items.pos()
  let n = if columns == none { its.len() } else { columns }
  let w = (size.width - gutter * (n - 1)) / n
  let card(it, h) = block(width: w, height: h, fill: callbg, inset: inset, radius: 0pt,
    stroke: (top: 3pt + it.at("accent", default: petroleo)), breakable: false, {
      set align(left + top)
      set par(justify: false)
      text(font: headingfont, weight: 700, fill: it.at("accent", default: petroleo), size: title-size, it.title)
      v(0.55em, weak: true)
      it.body
    })
  let h = calc.max(..its.map(it => measure(card(it, auto)).height))
  grid(columns: (w,) * n, gutter: gutter, ..its.map(it => card(it, h)))
})

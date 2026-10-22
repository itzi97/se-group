// Aggregated entrypoint for the @local/utad package: re-exports the base
// template (utad.typ) plus the report extras, the assignment template, and
// the slide theme — so a document can `#import "@local/utad:0.1.0": *` and
// get the whole toolkit: neuranet-doc, assignment, the slide functions,
// callouts, tables, and all diagrams.
#import "neuranet.typ": *
// evolution-chain now lives in utad.typ (above via *); report extras only.
#import "neuranet-report.typ": weeklog, reference-list, timeline, orgchart, org-node
#import "neuranet-assignment.typ": neuranet-breve, assignment, compact-info
#import "neuranet-slides.typ": title-slide, section-slide, section-tag, slide, focus-slide, slide-columns, agenda-slide, stat, no-logo-slides
#import "neuranet-ramify.typ": usecase-diagram

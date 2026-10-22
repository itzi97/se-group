// ============================================================
//  Neuranet — ACTA DE REUNIÓN
//
//  Una por cada reunión con el cliente (o reunión interna).
//  1. Copia este fichero, p. ej. a entrega-1/acta-reunion-01.typ
//  2. Rellena y compila desde la raíz del repositorio:
//       ./templates/compilar.sh entrega-1/acta-reunion-01.typ
// ============================================================

#import "/templates/lib.typ": *

#show: neuranet-breve.with(
  doc-type: [Acta de reunión],
  title: [Reunión de toma de requisitos],
  client: [Nombre del cliente],
  project: [AñadaMaster],
  reference: "NN-AM-ACT-01",
  date: "22 de octubre de 2026",
  author: "Nombre (secretario/a)",
  extra: (
    ([Hora], [00:00 – 00:00]),
    ([Lugar], [Presencial / online]),
  ),
)

= Asistentes
#neuranet-table(
  columns: (1fr, 1fr, 1fr),
  header: ([Nombre], [Organización], [Rol]),
  [Nombre], [Cliente], [Rol],
  [Nombre], [Neuranet], [Rol],
)

= Orden del día
+ Primer punto
+ Segundo punto

= Desarrollo y acuerdos
== Primer punto
Resumen de lo hablado.

*Acuerdo:* lo que se decidió.

= Dudas abiertas
- Pregunta pendiente de respuesta.

= Acciones
#neuranet-table(
  columns: (1fr, auto, auto),
  header: ([Acción], [Responsable], [Fecha límite]),
  [Descripción de la acción], [Nombre], [dd/mm/aaaa],
)

= Próxima reunión
Fecha prevista y objetivo.

// ============================================================
//  Acta de la reunión con el cliente · 16 de octubre de 2026
//  Compilar desde la raíz del repo:
//    ./templates/compilar.sh entrega-1/acta-reunion-01.typ
// ============================================================

#import "/templates/lib.typ": *

#show: neuranet-breve.with(
  doc-type: [Acta de reunión],
  title: [Toma de requisitos de AñadaMaster],
  client: [Bodegas Viña Alcorza],
  project: [AñadaMaster],
  reference: "NN-AM-ACT-01",
  date: "16 de octubre de 2026",
  author: "Itziar Morales Rodriguez",
)

= Asistentes
#neuranet-table(
  columns: (1fr, 1fr),
  header: ([Nombre], [Organización y cargo]),
  [Representante de la bodega], [Bodegas Viña Alcorza],
  [Itziar Morales Rodriguez], [Neuranet · CEO & Project Manager],
  [Samuel Porta Boylan], [Neuranet · Business Analyst],
  [Javier Cejuela García], [Neuranet · Software Architect],
  [Diego Herrera Rodríguez], [Neuranet · Lead Developer (AI & QA)],
)

= Orden del día
+ El negocio y el problema que resuelve AñadaMaster
+ Cómo se usará el sistema
+ Datos e infraestructura

= Lo que nos contó el cliente

== El negocio
- Hoy el proceso es artesanal, con varios ordenadores y mucho mantenimiento. Falla con frecuencia.
- Es una empresa familiar y antigua. Prefiere un sistema de uso interno, sin abrirse al exterior.
- Tiene cientos de clientes. Cada uno tiene su ficha: puede ser residencial o industrial y se identifica por su NIF o CIF.
- Los proveedores (botellas, papel…) se quedan fuera del sistema.
- AñadaMaster será su primer sistema de facturación.

== La bodega
- La vendimia dura 2 o 3 semanas al año. Solo entra uva local.
- Cuando llega un remolque se pesa y se comprueba la calidad con el grado de azúcar, que depende de la variedad. Si no llega al mínimo, la uva se tira y se usa como abono.
- No hay devoluciones.
- Después se embotella, se encorcha y se etiqueta. La «salida» es el producto embotellado que se envía a quien lo pide.

== Los pedidos
- Un pedido se reserva, se confirma, se factura, se envía y se cierra.
- Se puede cancelar hasta que se factura.
- Algunos clientes pagan habitualmente con PayPal; está por ver si se incluye.

== Uso e infraestructura
- En la empresa trabajan unas 30 personas, de las que 12 a 15 son fijas.
- Hay 5 líneas de teléfono que pueden recibir pedidos a la vez, más el administrador: unas 8 personas usarán el sistema al mismo tiempo.
- El sistema no debe caerse nunca. Hoy hacen copias de seguridad en un disco duro externo.

= Acuerdos
- La primera versión incluye lo que describe el encargo inicial. La producción de vino queda para versiones posteriores.
- _Imprimir factura_ pasa a ser _Generar factura_: la factura se guarda en el sistema y se imprime.
- Los pedidos tendrán los estados reservado, confirmado, facturado, enviado y cerrado, y solo se podrán anular antes de facturarlos.
- La ficha de cliente recogerá el tipo (residencial o industrial) y el NIF o CIF.
- La entrada de uva registrará el peso, la variedad y el grado de azúcar. La eliminación de materia prima es para la uva que se tira, no para devoluciones.

= Dudas abiertas
- Cómo se identifican los trabajadores y quién da de alta al primer administrador.
- Si el personal puede usar CoreBodega o solo los administradores.
- Si se puede borrar un cliente con pedidos y si hay que conservar su historial.
- Si se usará algún móvil o tablet en la bodega para registrar la materia prima.
- Presupuesto orientativo y preferencia entre equipos propios o en la nube.
- Qué horario de disponibilidad necesitan: el encargo habla de 9 a 18 h, de lunes a viernes, y en la reunión se pidió que no se caiga nunca.

= Acciones
#neuranet-table(
  columns: (1fr, auto, auto),
  header: ([Acción], [Responsable], [Fecha límite]),
  [Actualizar los casos de uso con los acuerdos], [Samuel Porta Boylan], [22/10/2026],
  [Llevar las dudas abiertas a la próxima reunión], [Itziar Morales Rodriguez], [Próxima reunión],
  [Tener en cuenta usuarios simultáneos, disponibilidad y copias de seguridad en la arquitectura y el TCO], [Javier Cejuela García], [Próxima entrega],
)

= Próxima reunión
Fecha por confirmar con el cliente. Objetivo: resolver las dudas abiertas.

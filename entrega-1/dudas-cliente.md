# Dudas para el cliente · Casos de uso de AñadaMaster

Salieron al modelar los casos de uso de la Entrega 1 (diagramas en [`../diagramas/`](../diagramas/)). Los códigos son los de los diagramas agrupados (un caso de uso por opción del menú). Las respuestas de la reunión del **16 de octubre de 2026** están en el acta ([`acta-reunion-01.typ`](acta-reunion-01.typ)).

## Resueltas en la reunión

| # | Duda | Respuesta | Cambio en los casos de uso |
|---|---|---|---|
| 5 | Datos de cliente y de materia prima | Cliente residencial o industrial, con NIF o CIF. Uva: peso del remolque, variedad y grado de azúcar | CU-03, CU-21 |
| 8 | Anular un pedido | Se puede cancelar hasta que se factura | CU-04 |
| 9 | Factura | Es su primer sistema de facturación: la factura se guarda | *Imprimir factura* pasa a *Generar factura* (CU-06) |
| 11 | Salida de materia prima | La salida es el producto embotellado que se envía al cliente | Ninguno |
| 15 | Producción | En versiones posteriores, no en la primera | Ninguno |
| — | Devoluciones | No hay. La uva que no llega al grado mínimo se tira y se usa como abono | CU-21 |
| — | Ciclo del pedido | Reservado › confirmado › facturado › enviado › cerrado | CU-04, CU-06 |

## Pendientes

1. **Identificación.** ¿Cómo se identifican los trabajadores? ¿Quién da de alta al primer administrador?
2. **Administrador y Personal.** ¿El Personal puede usar CoreBodega?
3. **Personal = usuarios.** ¿Los empleados de CoreBodega son los usuarios del sistema? ¿Qué es el «código de la empresa»?
4. **Producto sin baja.** ¿Qué se hace con un vino que ya no se vende?
6. **Baja de cliente con pedidos.** ¿Se puede borrar? ¿Hay que conservar su historial?
7. **Pedido y Pedido Detalle.** ¿El detalle se introduce después de crear el pedido o a la vez?
10. **Búsquedas.** ¿Por qué datos se busca un cliente o un pedido (NIF o CIF, nombre…)?
12. **Detalle de materia prima.** ¿Qué es y qué datos tiene?
13. **Validar.** ¿Valida el mismo administrador que introduce la operación?
14. **Registro del responsable.** ¿Se guarda también la fecha y la hora? ¿Alguien consulta ese registro?
16. **Dispositivo móvil.** ¿Se usará un móvil o tablet en la bodega?
— **PayPal.** Algunos clientes pagan con PayPal. ¿Hay que incluirlo?
— **Disponibilidad.** El encargo habla de 9 a 18 h, de lunes a viernes, y en la reunión se pidió que no se caiga nunca. ¿Qué horario hay que garantizar?

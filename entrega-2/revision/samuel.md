# Revisión · Samuel · Casos de uso, supuestos y stakeholders

En cada punto: `✅`, o `❌` y qué cambiarías.

## Casos de uso (documento, apartado 4, pp. 4–10)

Los diagramas son los de la E1. Cambio: **CU-06 Generar factura ahora incluye CU-07 Buscar cliente** (antes, Buscar pedido), porque una factura junta varios pedidos de un cliente.

- [ ] El cambio de CU-06 en el diagrama de CoreReservas (p. 5):
  > 

Especificaciones. Las he actualizado con lo que decidimos. Mira sobre todo las que cambian:

- [ ] CU-02 Gestionar producto: los productos no se borran, se marcan como inactivos (S-02):
  > 
- [ ] CU-03 Gestionar cliente: si el cliente tiene pedidos, la baja es lógica (S-03):
  > 
- [ ] CU-04 Gestionar pedido: ahora tiene Confirmar, Cambiar estado (enviado y cerrado) y Anular pasa a «anulado» en lugar de borrar:
  > 
- [ ] CU-05 Gestionar detalle de pedido: no se cambian las líneas de un pedido facturado:
  > 
- [ ] CU-06 Generar factura: una factura con uno o varios pedidos confirmados del mismo cliente:
  > 
- [ ] CU-21 Gestionar materia prima: es la entrada del remolque (fecha, procedencia, matrícula, descripción); el peso, la variedad y el grado pasan al detalle:
  > 
- [ ] CU-22 Ingresar detalle de materia prima: una línea por variedad; si el grado no llega al mínimo, la línea no se acepta:
  > 
- [ ] CU-23 Gestionar empleado: se indica el rol y la baja es lógica (S-04):
  > 
- [ ] Las demás (CU-01, CU-07, CU-08, CU-20, CU-24, CU-25, CU-26): solo cambian los criterios de búsqueda y lo que guarda el registro:
  > 

## Supuestos (apartado 4.3, pp. 11–12)

Son las dudas abiertas de la reunión del 16/10 y lo que suponemos. ¿Estás de acuerdo con cada uno?

- [ ] S-01 Los empleados son los usuarios:
  > 
- [ ] S-02 Productos inactivos en vez de borrarlos:
  > 
- [ ] S-03 Baja lógica de clientes con pedidos:
  > 
- [ ] S-04 Baja lógica de empleados:
  > 
- [ ] S-05 Detalle de materia prima = líneas por variedad:
  > 
- [ ] S-06 Neuranet da de alta al primer administrador:
  > 
- [ ] S-07 El personal marca enviado y cerrado:
  > 
- [ ] S-08 Qué se guarda en el registro de operaciones:
  > 
- [ ] S-09 Criterios de búsqueda:
  > 
- [ ] S-10 Valida el mismo administrador:
  > 
- [ ] S-11 CoreBodega solo para administradores:
  > 
- [ ] S-12 El detalle del pedido se mete después del pedido:
  > 
- [ ] S-13 PayPal, móvil y producción fuera de esta versión:
  > 
- [ ] ¿Falta alguna duda?
  > 

## Mapa de stakeholders (apartado 3, pp. 3–4)

Hay 11, en los dos formatos del Tema 3 (cebolla y matriz poder/interés) y una tabla.

- [ ] ¿Sobra o falta alguno?
  > 
- [ ] Posición en la matriz (poder e interés) de cada uno:
  > 
- [ ] Anillo y sector de la cebolla de cada uno:
  > 
- [ ] Actitud (a favor / neutral / en contra):
  > 
- [ ] Textos de la tabla («Qué le importa y cómo lo gestionamos»):
  > 
- [ ] Las tres conclusiones debajo de la tabla:
  > 

## Otros comentarios
> 

# Dudas para el cliente · Casos de uso de AñadaMaster

Salen de modelar los casos de uso de la Entrega 1 (diagramas en [`../diagramas/`](../diagramas/)). Son cosas que el enunciado no aclara. **En los diagramas no se ha inventado nada de esto**: donde hacía falta una decisión, se ha dejado lo mínimo que dice el enunciado. Las páginas son las del PDF.
Para la reunión con el cliente; las respuestas van al acta.

## Usuarios y acceso

1. **Identificación.** El enunciado exige que en CoreBodega quede registrado qué usuario hace cada gestión (p. 5), pero no dice cómo se identifican los usuarios. Hemos puesto un caso de uso *Iniciar sesión* en cada Core. ¿Cómo se identifican (usuario y contraseña, código de empleado…)? ¿Hace falta también en CoreReservas?
2. **Administrador y Personal.** Tienen «los mismos privilegios» (p. 4), pero en CoreBodega «el trabajador que interactúa son los administradores». ¿El Personal puede usar CoreBodega o no debe tener acceso?
3. **Personal = usuarios.** Los empleados que se dan de alta en CoreBodega (opción Personal), ¿son los mismos que luego usan el sistema? ¿Qué es exactamente el «código de la empresa» que se pide al registrarlos?

## CoreReservas

4. **Producto sin baja.** El enunciado solo permite dar de alta y modificar productos (p. 4). ¿Qué se hace con un vino que ya no se vende?
5. **Datos.** ¿Qué datos tienen un producto, un cliente y un pedido? Las especificaciones dicen solo «los datos», sin campos.
6. **Baja de cliente con pedidos.** Si un cliente tiene pedidos abiertos, ¿se puede eliminar? ¿Qué pasa con sus pedidos?
7. **Pedido y Pedido Detalle.** Son opciones distintas del menú. ¿El detalle (productos y cantidades) se introduce después de crear el pedido, o en el mismo momento? ¿Qué datos se cambian al «modificar pedido» si la cantidad y el producto se cambian en el detalle?
8. **Anular un pedido.** Al eliminarlo, ¿se borran también sus líneas de detalle? ¿Se puede modificar o anular un pedido que ya tiene factura?
9. **Factura.** El enunciado dice que la factura «la realiza» el personal y que un botón la imprime (p. 4). ¿Se guarda en el sistema o solo se imprime? ¿Qué datos lleva (importes, impuestos…)?
10. **Búsquedas.** ¿Por qué datos se busca un cliente o un pedido?

## CoreBodega

11. **Salida de materia prima.** El enunciado dice que CoreBodega registra la entrada **y la salida** de productos (uvas) (p. 4), pero la opción MateriaPrima solo permite ingresar y eliminar por devolución. ¿Cómo se registra el consumo de uva en la producción?
12. **Detalle de materia prima.** ¿Qué es y qué datos tiene? ¿Va siempre asociado a una materia prima ya ingresada? Si se elimina esa materia prima (devolución), ¿qué pasa con su detalle? ¿Se puede eliminar un detalle?
13. **Validar.** Cada operación de CoreBodega «hay que validarla» para que sea efectiva (p. 5). ¿La valida el mismo administrador que la introduce, o tiene que hacerlo otra persona? ¿Es lo mismo que «confirmar» en CoreReservas?
14. **Registro del responsable.** Además del usuario, ¿hay que guardar la fecha y la hora? ¿Alguien tiene que consultar ese registro (un informe, un listado)?
15. **Producción.** La descripción habla de registrar «la producción de los diferentes vinos» (p. 3), pero ninguna opción de los dos Cores la cubre. ¿Entra en este proyecto?
16. **Dispositivo móvil.** El apartado de *vibe coding* menciona un dispositivo móvil para registrar y evaluar la materia prima (p. 7). No aparece en ningún otro sitio. ¿Existe? ¿Forma parte de AñadaMaster?

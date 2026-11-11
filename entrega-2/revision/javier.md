# Revisión · Javier · Clases y estados

En cada punto: `✅`, o `❌` y qué cambiarías. Los diagramas también se pueden abrir en se-ramify (carpeta `diagramas/`), pero las correcciones pásalas aquí escritas.

## Modelo de dominio (apartado 5, pp. 12–14)

Sin tipos ni operaciones. Leyenda de las relaciones en la p. 12.

### CoreReservas
- [ ] Clases y atributos (Cliente, ClienteResidencial, ClienteIndustrial, Pedido, LineaPedido, Producto, Factura, EstadoPedido):
  > 
- [ ] Herencia de Cliente (residencial con NIF, industrial con CIF):
  > 
- [ ] Factura 0..1 — 1..* Pedido (una factura junta varios pedidos; cada pedido se factura una vez):
  > 
- [ ] Pedido ◆ LineaPedido (composición) y LineaPedido → Producto:
  > 
- [ ] Cliente 1 — 0..* Factura («recibe»):
  > 
- [ ] Multiplicidades:
  > 

### CoreBodega
- [ ] MateriaPrima (entrada del remolque) ◆ DetalleMateriaPrima (líneas por variedad):
  > 
- [ ] Variedad con su grado mínimo:
  > 
- [ ] RegistroOperacion y TipoOperacion:
  > 
- [ ] Empleado abstracto → Administrador y Personal:
  > 
- [ ] Multiplicidades:
  > 

## Clases de diseño (apartado 6.1, pp. 15–16, en horizontal)

Entidades con tipos, visibilidad y operaciones, más una clase de control por opción del menú (en verde). Las pantallas no se dibujan.

- [ ] CoreReservas: tipos y operaciones de las entidades:
  > 
- [ ] CoreReservas: los 5 controles y sus operaciones:
  > 
- [ ] CoreBodega: tipos y operaciones de las entidades:
  > 
- [ ] CoreBodega: los 3 controles y sus operaciones:
  > 
- [ ] Clases de datos de formulario (DatosProducto, DatosCliente, CambioLinea…) sin dibujar, solo explicadas en el texto:
  > 
- [ ] ¿Se lee bien? (tamaño, distribución, cruces de líneas):
  > 

## Diagrama de estados del pedido (apartado 6.2, p. 17)

- [ ] Estados: reservado › confirmado › facturado › enviado › cerrado, y anulado:
  > 
- [ ] Transiciones y eventos (confirmar, generarFactura, marcarEnviado, cerrar, anular, modificar):
  > 
- [ ] Solo se modifica o anula antes de facturar:
  > 

## Otros comentarios
> 

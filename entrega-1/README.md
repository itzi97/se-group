# Entrega 1 · Definición de empresa y casos de uso

> **Fecha límite: jueves 22 oct 2026, 23:55 · Blackboard · 1 solo intento · 10 pts**
> Lo que se entregue tarde **no se evalúa**. En Blackboard hay un intento *en curso* abierto desde el 16 oct: hay que **enviarlo**, no basta con guardarlo.

Fuentes: [`enunciado.md`](enunciado.md) (texto de la actividad en Blackboard) · [`../Enunciado Caso Práctico.pdf`](<../Enunciado Caso Práctico.pdf>) (V 2.0; las páginas citadas son del PDF) · diapositivas de presentación de la asignatura (diap. 14–15) · Tema 3.
Resumen visual de todo el caso práctico: [`../RESUMEN-ENUNCIADO.md`](../RESUMEN-ENUNCIADO.md).

> [!WARNING]
> **Blackboard y el PDF no coinciden.** Para la E1, el PDF (p. 10) pide *empresa + TCO* y deja los casos de uso para la E2.
> La actividad de Blackboard (la que se entrega hoy) pide *empresa + diagramas UML de casos de uso*.
> Esta checklist sigue **Blackboard**. El TCO no se pide en la E1, pero sigue en el proyecto: hay que preguntar a Jorge en qué entrega va ahora.

## Cómo se puntúa (rúbrica de Blackboard)

| Parte | Peso | Qué se mira |
|---|---|---|
| 1 · Empresa | 25 % | Originalidad y calidad del contenido |
| 2 · Casos de uso | 25 % | Calidad del contenido |
| 3 · Documentación y presentación | 25 % | Medios, originalidad, capacidad de transmitir |
| 4 · Exposición en clase | 25 % | Cómo lo contáis |

Además se aplican las reglas generales (PDF pp. 13–14; diap. 15): **si falta algún apartado, no se aprueba** (completitud). Las decisiones se valoran **razonadas**. Nada de relleno ni adornos. Una mala redacción u ortografía puede quitar **hasta un 20 %**.

---

## ✅ Checklist

### Parte 1 · La empresa (25 %)

Contexto (PDF p. 3): sois una **empresa de desarrollo de software recién creada** que da componentes software a sus clientes y que todavía no sabe qué metodología le va mejor.

- [x] **Nombre** de la empresa
- [x] **Marca**: logotipo e identidad visual (colores, tipografía, eslogan si lo hay). Usadla igual en el documento y en las diapositivas.
- [x] **Modelo de negocio**: a quién vendéis, qué valor aportáis, cómo lo entregáis y cómo ganáis dinero. Una herramienta habitual es el *Business Model Canvas* (conocimiento general, no viene en las diapositivas).
- [x] **Jerarquía**: organigrama de la empresa (lo pide el PDF en la p. 3)
- [x] **Asignación de roles** de **los cuatro miembros**: quién es quién y qué hace cada uno
- [x] Explicar **por qué** habéis elegido ese nombre, ese modelo y ese reparto de roles (originalidad + corrección razonada)
- [x] *(Opcional, conecta con el enunciado)* Cómo trabaja la empresa: OO + Proceso Unificado en este primer proyecto, y la intención de valorar después otras metodologías (PDF p. 5)

> Parte 1 hecha en `documento.typ` (capítulos 1–3) y `presentacion.typ`. Organigrama también en `diagramas/` para se-ramify.

### Parte 2 · Diagramas UML de casos de uso (25 %)

- [x] **Diagrama(s) de casos de uso** de AñadaMaster: **actores**, **límite del sistema**, **casos de uso** con nombre en forma de verbo y relaciones **«include» / «extend»** donde tengan sentido
- [x] Decidir y **justificar** si hacéis un diagrama por Core (CoreReservas y CoreBodega) o uno general con dos subsistemas
- [x] **Comprobar que cubrís todo lo que describe el enunciado** (ver la tabla de abajo). La completitud cuenta el 20 % de cada apartado.
- [x] Explicar los **actores** y las decisiones que no son evidentes (por ejemplo, cómo modeláis que Administrador y Personal tengan los mismos privilegios, pero que CoreBodega lo use el Administrador)
- [x] *(Recomendado)* **Especificación** breve de los casos de uso principales: actor, precondiciones, flujo principal, flujos alternativos y postcondiciones. Blackboard no la pide para la E1, pero el PDF sí la pide en el proyecto (pp. 8 y 10), así que adelantáis trabajo.
- [x] Si ya os habéis reunido con el cliente: adjuntar el **acta de la reunión** (el PDF lo pide para cualquier reunión con el cliente, p. 8)

<details>
<summary><b>Funcionalidades del enunciado que tienen que aparecer (PDF pp. 4–5)</b></summary>

Esto es lo que **dice el enunciado**, no un diseño: cómo lo agrupéis en casos de uso lo decidís vosotros.

**CoreReservas**: lo usa sobre todo el **Personal**. Administrador y Personal pueden introducir y modificar datos.

| Opción | Alta / ingresar | Modificar | Baja / eliminar | Otros |
|---|:-:|:-:|:-:|---|
| Producto | ✓ | ✓ | — | Confirmar los cambios para que se apliquen |
| Cliente | ✓ (plantilla con datos y domicilio) | ✓ | ✓ (se elimina de la BD) | — |
| Pedido | ✓ | ✓ | ✓ | El cliente puede pedir cambios o anularlo **por teléfono**. Confirmar los cambios. |
| Pedido Detalle | ✓ | ✓ (cantidad y producto) | ✓ | Un botón para aplicar los cambios |
| Factura | — | — | — | **Imprimir** el detalle del pedido tras recuperar el pedido, con un botón |

**CoreBodega**: lo usa el **Administrador**. Queda registrado **qué usuario** hace cada gestión.

| Opción | Ingresar | Modificar | Eliminar | Otros |
|---|:-:|:-:|:-:|---|
| MateriaPrima | ✓ (datos, fecha, cantidad, descripción) | ✗ **no se puede** | ✓ (si hay devolución) | Validar para que el ingreso o la eliminación sean efectivos |
| Personal | ✓ (datos personales + código de empresa) | ✓ | ✓ | Validar cualquier cambio |
| Detalle Materia Prima | ✓ (lo hace el Administrador) | ✗ **no se puede** | — | Validar el ingreso |

</details>

> Parte 2 hecha: diagramas en `diagramas/` (se-ramify), dibujados en el capítulo 4 de `documento.typ` y en las diapositivas. Acta de la reunión del 16 oct en `acta-reunion-01.typ`; dudas resueltas y pendientes en `dudas-cliente.md`.

### Parte 3 · Documentación y presentación (25 %)

- [x] **Documento** (PDF) con portada (empresa, logo, nombres de los cuatro miembros, asignatura, «Entrega 1») y las dos partes
- [x] **Diapositivas** para la exposición, con la marca de la empresa
- [x] Diagramas **nítidos y legibles** al exportarlos, relacionados con el texto que los acompaña (PDF p. 14)
- [ ] Revisión de **ortografía y redacción** por alguien que no lo haya escrito. No copiéis las erratas del enunciado: escribid **CoreBodega** (no «CoreBodegas»), **AñadaMaster** (sin tilde en la a) y **post mortem**.
- [x] Sin relleno ni elementos solo decorativos (simplicidad)
- [ ] Nada copiado de Internet ni de otro grupo. Se suspende **toda la asignatura** (diap. 16).

### Parte 4 · Exposición en clase (25 %)

- [ ] Decidir **quién presenta** esta vez. No hace falta que presenten todos, pero **cada uno tiene que presentar al menos una vez** durante el curso. Apuntad quién lo hace en cada entrega.
- [ ] Duración: **5–15 minutos** (PDF p. 8; confirmad si se aplica también a las entregas parciales)
- [ ] Ensayar al menos una vez cronometrando

### Entrega en Blackboard

- [ ] Subir **todos** los ficheros (documento + diapositivas + acta si la hay) al intento que ya está abierto
- [ ] **Pulsar «Enviar»** antes de las 23:55. Solo hay **un intento**, así que revisad que estén todos los ficheros antes de enviar.
- [ ] Dejad claro quién del grupo hace el envío

---

## ❓ Dudas para Jorge

- [ ] ¿La E1 es *empresa + casos de uso* (Blackboard) o *empresa + TCO* (PDF V 2.0)? Si es lo primero, ¿en qué entrega va ahora el TCO?
- [ ] ¿Cuándo es la exposición en clase de la E1?
- [ ] ¿Las especificaciones de los casos de uso se piden ya en la E1 o en la E2?

## 📌 No es de esta entrega, pero conviene no perderlo de vista

- **TCO**: local frente a nube, arquitectura y diagrama, costes a 3 años con datos reales y recomendación razonada (PDF pp. 5–6). Se puede ir buscando precios.
- **Alternativas de mercado** (PDF p. 6): el cliente quiere saber qué otras soluciones hay, pero no aparece en ninguna lista de entregas.
- **Dispositivo móvil** para registrar la materia prima (PDF p. 7): solo se menciona en el apartado de *vibe coding*. Hay que preguntarlo al cliente.

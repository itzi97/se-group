# Entrega 2 · UML, mapa de stakeholders y visión

> **Fecha límite: jueves 12 nov 2026, 23:55 · Blackboard · 1 solo intento · 10 pts**
> En Blackboard hay un intento **en curso desde el 6 nov**: hay que **enviarlo**, no basta con guardarlo.

Fuentes: actividad de Blackboard (sync del 10 nov) · [`../Enunciado Caso Práctico.pdf`](<../Enunciado Caso Práctico.pdf>) p. 10 · Tema 3 (stakeholders), Tema 4 (UML), Tema 5 (visión) · acta [`../entrega-1/acta-reunion-01.typ`](../entrega-1/acta-reunion-01.typ).

**Para revisar:** [`revision/COMO-REVISAR.md`](revision/COMO-REVISAR.md) (una hoja por persona).

## Cómo se puntúa (rúbrica de Blackboard)

| Parte | Peso | Dónde está |
|---|---|---|
| Contenido 1.ª parte: UML (casos de uso con especificaciones, clases, secuencia) | 20 % | Documento, apartados 4–7 |
| Contenido 2.ª parte: mapa de stakeholders (mín. 6) | 20 % | Documento, apartado 3 (11 stakeholders, los dos formatos) |
| Elevator pitch | 20 % | Documento, apartado 2 · diapositiva 3 (lo presenta Diego) |
| Presentación (medios, originalidad, capacidad de transmitir) | 20 % | `presentacion.pdf` |
| Exposición en clase | 20 % | 5–15 min; no hace falta que presenten todos |

## ✅ Checklist

- [x] Casos de uso **con especificaciones**: los 15 (CU-01 a CU-08, CU-20 a CU-26), actualizados con las decisiones de abajo
- [x] Diagramas de clases: **modelo de dominio** (uno por Core) y **diseño** (uno por Core, con controles)
- [x] Diagramas de secuencia: **uno por opción del menú** (8), todas las operaciones en `alt`, estilo boundary-control-entity
- [x] Diagrama de estados del pedido (no se pide, pero aclara el ciclo del pedido)
- [x] Mapa de stakeholders: cebolla + matriz poder/interés + tabla (11 stakeholders)
- [x] Visión con la plantilla del elevator pitch
- [x] Supuestos documentados (S-01 a S-13) para las dudas abiertas de la reunión
- [ ] Revisión de los cuatro → correcciones aplicadas
- [ ] Repartir quién presenta qué
- [ ] Subir los PDF y **enviar** en Blackboard

## Decisiones tomadas (11 nov)

| Tema | Decisión |
|---|---|
| Formato | Documento + diapositivas, con las plantillas de Neuranet |
| Especificaciones | Todos los casos de uso, con ficha completa |
| Clases | Modelo de dominio **y** diseño |
| Herramienta | se-ramify: todos los diagramas están en [`../diagramas/`](../diagramas/) y el PDF los dibuja con [`../templates/neuranet-uml.typ`](../templates/neuranet-uml.typ) |
| Secuencias | Una por opción del menú; boundary-control-entity; todas las operaciones en `alt` |
| Diseño | Entidades + una clase de control por opción del menú |
| Stakeholders | Los dos formatos del Tema 3 |
| Usuarios | Herencia: Empleado → Administrador y Personal |
| Dudas del cliente | Supuestos documentados en una tabla |
| Factura | Una factura agrupa 1..* pedidos del mismo cliente |
| Estados del pedido | Enumerado + diagrama de estados |
| Cliente | Herencia: ClienteResidencial (NIF) y ClienteIndustrial (CIF) |
| Registro de operaciones | Clase RegistroOperacion |
| Materia prima | Entrada (remolque) + líneas de detalle por variedad |
| Visión | Del producto AñadaMaster, frente a su app actual y los programas genéricos o Excel |

## Ficheros

| Fichero | Qué es |
|---|---|
| `documento.typ` / `.pdf` | El documento de la entrega (26 pp.) |
| `presentacion.typ` / `.pdf` | Diapositivas (18) |
| `comun.typ` | Diagramas, supuestos y la ficha de especificación, compartidos por los dos |
| `revision/` | Hojas de revisión de cada uno |

> Las especificaciones de los casos de uso están dentro de los JSON de `diagramas/usecase-*.json`, que también usa la E1. Cuando GitHub regenere los PDF, el documento de la E1 mostrará las descripciones actualizadas (la entrega final pide las entregas anteriores corregidas, así que está bien).

# Neuranet · AñadaMaster

Proyecto final de Ingeniería del Software (U-tad, 2026–27). Somos **Neuranet**, una empresa de software ficticia, y nuestro cliente es **Bodegas Viña Alcorza**, que nos encarga **AñadaMaster**: un sistema de gestión con dos programas, **CoreReservas** (pedidos) y **CoreBodega** (uva y empleados).

| Persona | Cargo |
|---|---|
| Itziar Morales Rodriguez | CEO & Project Manager |
| Samuel Porta Boylan | Business Analyst |
| Javier Cejuela García | Software Architect |
| Diego Herrera Rodríguez | Lead Developer (AI & QA) |

## Estado

| Entrega | Fecha | Estado |
|---|---|---|
| **Entrega 1** · Empresa + casos de uso | 22 oct 2026, 23:55 | Lista para entregar: [`entrega-1/`](entrega-1/README.md) |

## Qué hay en el repo

| Carpeta / fichero | Qué es |
|---|---|
| [`Enunciado Caso Práctico.pdf`](<Enunciado Caso Práctico.pdf>) | El enunciado (V 2.0) |
| [`RESUMEN-ENUNCIADO.md`](RESUMEN-ENUNCIADO.md) | Resumen visual del caso práctico y de todas las entregas |
| [`entrega-1/`](entrega-1/README.md) | Documento, diapositivas y acta de la E1 (`.typ` + `.pdf`), checklist, dudas para el cliente y marca |
| [`diagramas/`](diagramas/) | Diagramas de se-ramify (JSON): casos de uso de CoreReservas y CoreBodega, con su especificación completa, y organigrama |
| [`templates/`](templates/README.md) | Plantillas Typst con la marca de Neuranet (informe, documento breve, acta y diapositivas) y las fuentes |
| `.github/workflows/pdfs.yml` | Acción *Generar PDF*: al hacer push a `main` compila todos los `.typ` y sube los PDF |

## Compilar

Con [Typst](https://typst.app) 0.13 o superior, desde la raíz del repo:

```sh
./templates/compilar.sh entrega-1/documento.typ   # un documento
./templates/compilar-todo.sh                      # todos
```

No hace falta compilar antes de hacer push: la acción de GitHub lo hace sola. Después, `git pull` para traer el commit «Regenerar PDF».

Los diagramas se editan en [se-ramify](https://github.com/itzi97/se-ramify) y se guardan en `diagramas/`. Los documentos los dibujan con el estilo de Neuranet (`usecase-diagram` en `templates/neuranet-ramify.typ`), así que al cambiar el JSON se actualizan solos.

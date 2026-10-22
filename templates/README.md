# Plantillas de Neuranet (Typst)

Plantillas para los documentos que **Neuranet entrega a sus clientes**. Llevan nuestro logotipo y nuestros colores, y en la portada y la cabecera aparecen el cliente, el proyecto, la referencia, la versión y la marca de confidencialidad.

| Plantilla | Fichero de partida | Para qué |
|---|---|---|
| **Informe** | `starter-informe.typ` | Documentos largos con portada, control de versiones e índice: propuesta técnica, especificación de requisitos, arquitectura, TCO… |
| **Documento breve** | `starter-breve.typ` | 1–5 páginas con cabecera compacta: nota técnica, presupuesto, resumen ejecutivo… |
| **Acta de reunión** | `starter-acta.typ` | Una por reunión: asistentes, orden del día, acuerdos, dudas y acciones |
| **Diapositivas** | `starter-diapositivas.typ` | Presentación 16:9 para el cliente |

Los PDF `starter-*.pdf` muestran cómo queda cada una.

## Cómo usarlas

1. Instala **Typst** 0.13 o superior. En Arch o CachyOS: `sudo pacman -S typst`. También con `brew install typst`, `winget install Typst.Typst` o descargando el binario de [GitHub](https://github.com/typst/typst/releases).
2. Copia la plantilla a la carpeta de la entrega:
   ```sh
   cp templates/starter-informe.typ entrega-1/documento.typ
   ```
3. Compila desde la raíz del repositorio:
   ```sh
   ./templates/compilar.sh entrega-1/documento.typ          # genera entrega-1/documento.pdf
   ./templates/compilar.sh entrega-1/documento.typ watch    # recompila al guardar
   ```

Para compilar **todos** los documentos del repo de una vez (entregas y ejemplos de las plantillas):
```sh
./templates/compilar-todo.sh
```

**En GitHub no hace falta compilar a mano:** cada vez que se hace push a `main` con cambios en un `.typ`, en `diagramas/` o en `templates/`, la acción *Generar PDF* (`.github/workflows/pdfs.yml`) compila todo y sube los PDF actualizados en un commit «Regenerar PDF». Después de hacer push, haced `git pull` para traeros ese commit.

El script pasa a Typst dos opciones que hacen falta:
* `--root .`: los documentos importan la plantilla con `#import "/templates/lib.typ": *`, una ruta relativa a la raíz del repo.
* `--font-path templates/fonts`: usa las fuentes incluidas, así que no hay que instalar nada.

En **Windows** (sin bash), desde la raíz del repo:
```powershell
typst compile --root . --font-path templates/fonts entrega-1/documento.typ
```

**VS Code** con la extensión *Tinymist*: el repo incluye `.vscode/settings.json` con la raíz y las fuentes ya configuradas, así que la vista previa funciona directamente.

## Campos de la portada

| Campo | Ejemplo | Dónde aparece |
|---|---|---|
| `doc-type` | `[Propuesta técnica]` | Encima del título |
| `title`, `subtitle` | | Portada |
| `client` | `[Nombre del cliente]` | «Preparado para» y cabecera de cada página |
| `project` | `[AñadaMaster]` | Ficha del documento |
| `reference` | `"NN-AM-001"` | Ficha y cabecera |
| `version` | `"1.0"` | Ficha y pie |
| `status` | `[Borrador]`, `[Final]` | Ficha |
| `date` | `"22 de octubre de 2026"` | Ficha |
| `author` | `"Nombre 1 · Nombre 2"` | «Preparado por» |
| `confidential` | `true` / `false` | Sello en la portada y en el pie |

`neuranet-breve` acepta además `extra: (([Hora], [10:00]), ([Lugar], [Online]))` para añadir filas a la ficha (lo usa el acta).

## Componentes

* Recuadros: `note[...]`, `important[...]`, `callout(title: ...)[...]`
* Tablas: `neuranet-table(columns: ..., header: (...), ...celdas)`
* Control de versiones: `version-history(("1.0", "22/10/2026", "Autor", [Cambios]), ...)`
* Diagramas: `orgchart(org-node(...))` (organigrama), `timeline(...)` (Gantt), `evolution-chain(...)`
* Diagramas de se-ramify: `usecase-diagram(json("/diagramas/usecase-….json"))` dibuja un diagrama de casos de uso de se-ramify con el estilo de Neuranet (mismos nombres, códigos y relaciones que en la app; la maquetación se ajusta a la página)
* Diapositivas: `title-slide`, `agenda-slide`, `section-slide`, `slide`, `slide-columns`, `focus-slide`, `stat`
* Código entre ```` ``` ```` con números de línea automáticos
* Colores por nombre: `petroleo`, `brasa`, `chispa`, `sinapsis`, `niebla`

Están basadas en [utad-templates](https://github.com/itzi97/utad-templates); su `docs/GUIDE.md` sirve como referencia de los componentes (`utad-table` aquí es `neuranet-table`).

## Contenido de la carpeta

* `neuranet.typ`: base (paleta, fuentes, portada, recuadros, tablas, control de versiones)
* `neuranet-report.typ`: organigrama, Gantt (`timeline`), registro semanal y referencias
* `neuranet-assignment.typ`: documento breve (`neuranet-breve`)
* `neuranet-slides.typ`: diapositivas
* `neuranet-ramify.typ`: diagramas de se-ramify (casos de uso)
* `lib.typ`: lo importa todo de una vez
* `logo-*.svg`: logotipo y símbolo (los mismos que en `entrega-1/marca/`)
* `fonts/`: Sora, IBM Plex Sans e IBM Plex Mono (licencia SIL OFL, ver `fonts/OFL-*.txt`)

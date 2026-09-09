# Hello, World! — R

Implementación de la especificación [01_Hello_World](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) en **R**, con un enfoque manual y minimalista.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`helloworld.r`](helloworld.r) | Código fuente: imprime `"Hello, World from R!"` en la salida estándar. |

**Estructura de directorios esperada:**

```text
helloworld/
├── helloworld.r    # Código fuente
└── README.md       # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente, sin herramientas de scaffolding. Un único archivo `.r` es suficiente: R es un lenguaje interpretado, por lo que no requiere compilación previa para ejecutarse.

**EN:** The project was created manually, without scaffolding tools. A single `.r` file is enough: R is an interpreted language, so no prior compilation is required to run it.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p r/core/foundations/helloworld
   ```

2. Escribir el archivo `helloworld.r` con el código fuente.

3. No se necesita ningún paso adicional de construcción o vinculación de dependencias.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración de build. El programa se ejecuta directamente con el intérprete `Rscript`.

```r
print("Hello, World from R!")
```

| Elemento | Propósito |
|----------|-----------|
| `print(...)` | Función genérica que imprime su argumento en la salida estándar, seguido de un salto de línea (`\n`). |
| `"Hello, World from R!"` | Argumento: la cadena a imprimir. |

> **ES:** `print` es una función genérica que, para un vector de caracteres, escribe su representación textual (incluidas las comillas) y un salto de línea.
> **EN:** `print` is a generic function that, for a character vector, writes its textual representation (including the quotes) and a newline.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener R instalado

```bash
# Verificar instalación
R --version
```

### Ejecutar directamente / Run directly

```bash
cd r/core/foundations/helloworld
Rscript helloworld.r
```

> **ES:** Alternativamente se puede ejecutar desde una sesión interactiva de R con `source("helloworld.r")`.
> **EN:** Alternatively, it can be run from an interactive R session with `source("helloworld.r")`.

### Salida esperada / Expected output

```text
[1] "Hello, World from R!"
```

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** R no requiere una función `main`: el script se ejecuta de arriba a abajo como en lenguajes de scripting.
- **EN:** R does not require a `main` function: the script executes top to bottom like in scripting languages.
- **ES:** `print` escribe en `stdout` y añade automáticamente un salto de línea.
- **EN:** `print` writes to `stdout` and automatically appends a newline.
- **ES:** `Rscript` es la herramienta de ejecución por lotes de R, pensada para scripts no interactivos.
- **EN:** `Rscript` is R's batch execution tool, intended for non-interactive scripts.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*

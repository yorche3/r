# Hello, World! — R

Implementación de la especificación [01_Hello_World](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) en **R**, con un enfoque manual y minimalista.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`hello_world.r`](hello_world.r) | Código fuente: imprime `"Hello, World from R!"` en la salida estándar. |

**Estructura de directorios esperada:**

```text
helloworld/
├── hello_world.r    # Código fuente
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

2. Escribir el archivo `hello_world.r` con el código fuente.

3. No se necesita ningún paso adicional de construcción o vinculación de dependencias.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración de build. El programa se ejecuta directamente con el intérprete `Rscript`.

```r
cat("Hello, World! from R!\n")
```

| Elemento | Propósito |
|----------|-----------|
| `cat(...)` | Concatena y escribe sus argumentos en la salida estándar **sin** añadir nada: la cadena sale tal cual. |
| `"Hello, World! from R!\n"` | Argumento: la cadena a imprimir, con el salto de línea explícito. |

> **ES:** `cat` escribe la cadena tal cual, sin comillas ni prefijos; `print` habría añadido `[1] ` y comillas por ser la representación de un vector, y por eso no se usa aquí.
> **EN:** `cat` writes the string as is, without quotes or prefixes; `print` would have added `[1] ` and quotes because it renders a vector, so it is not used here.

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
Rscript hello_world.r
```

> **ES:** Alternativamente se puede ejecutar desde una sesión interactiva de R con `source("hello_world.r")`.
> **EN:** Alternatively, it can be run from an interactive R session with `source("hello_world.r")`.

### Salida esperada / Expected output

```text
Hello, World! from R!
```

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** R no requiere una función `main`: el script se ejecuta de arriba a abajo como en lenguajes de scripting.
- **EN:** R does not require a `main` function: the script executes top to bottom like in scripting languages.
- **ES:** `cat` escribe en `stdout` y **no** añade salto de línea: se incluye `\n` en la cadena para que la salida termine en línea nueva.
- **EN:** `cat` writes to `stdout` and does **not** append a newline: `\n` is included in the string so the output ends with a newline.
- **ES:** `Rscript` es la herramienta de ejecución por lotes de R, pensada para scripts no interactivos.
- **EN:** `Rscript` is R's batch execution tool, intended for non-interactive scripts.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*

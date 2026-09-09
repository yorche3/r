# Hello, User! — R

Implementación de la especificación [02_Hello_User](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) en **R**, con un enfoque manual y minimalista.

Solicita un nombre al usuario por la entrada estándar (estilo prompt) y saluda.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`hellouser.r`](hellouser.r) | Código fuente: solicita un nombre por la entrada estándar y saluda. |

**Estructura de directorios esperada:**

```text
hellouser/
├── hellouser.r     # Código fuente
└── README.md       # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este programa introduce tres conceptos nuevos respecto a `helloworld`:

1. **Escritura sin salto de línea** — `cat` imprime el prompt dejando el cursor en la misma línea.
2. **Entrada de usuario** — `readLines("stdin", n = 1)` lee una línea desde la entrada estándar.
3. **Concatenación de cadenas** — `paste0` concatena sin separadores.

**EN:** This program introduces three new concepts compared to `helloworld`:

1. **Writing without newline** — `cat` prints the prompt leaving the cursor on the same line.
2. **User input** — `readLines("stdin", n = 1)` reads a line from standard input.
3. **String concatenation** — `paste0` concatenates without separators.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p r/core/foundations/hellouser
   ```

2. Escribir el archivo `hellouser.r` con el código fuente.

3. No se necesita ningún paso adicional de construcción o vinculación de dependencias.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración de build. El programa se ejecuta directamente con el intérprete `Rscript`.

**ES:** El flujo del programa es:

1. Imprimir `"Enter your name: "` con `cat` (sin salto de línea) y volcar el buffer con `flush(stdout())`.
2. Leer una línea desde `stdin` con `readLines("stdin", n = 1)`.
3. Imprimir `"Hello, <nombre>!"` concatenando con `paste0`.

**EN:** Program flow:

1. Print `"Enter your name: "` with `cat` (no newline) and flush the buffer with `flush(stdout())`.
2. Read a line from `stdin` with `readLines("stdin", n = 1)`.
3. Print `"Hello, <name>!"` concatenating with `paste0`.

```r
cat("Enter your name: ")
flush(stdout())
name <- readLines("stdin", n = 1)
print(paste0("Hello, ", name, "!"))
```

| Elemento | Propósito |
|----------|-----------|
| `cat(...)` | Imprime en la salida estándar **sin** salto de línea al final (el cursor permanece junto al prompt). |
| `flush(stdout())` | Vacía el buffer de `stdout` para que el prompt sea visible **antes** de leer la entrada. |
| `readLines("stdin", n = 1)` | Lee una línea desde la entrada estándar. Con `n = 1` se detiene tras la primera línea. |
| `<-` | Operador de asignación de R. |
| `paste0(...)` | Concatena cadenas **sin** separadores (a diferencia de `paste`, que usa espacios por defecto). |
| `print(...)` | Imprime el resultado en la salida estándar. |

> **ES:** El archivo incluye además, comentada, la variante por línea de comandos con `commandArgs(trailingOnly = TRUE)` (ver notas de implementación).
> **EN:** The file also includes, commented out, the command-line variant with `commandArgs(trailingOnly = TRUE)` (see implementation notes).

> **ES:** No se usa `readline(prompt = ...)`: está pensada para la consola interactiva de R y **no consume la entrada de forma fiable bajo `Rscript`** (imprime el prompt pero devuelve cadena vacía). La combinación `cat` + `readLines("stdin", n = 1)` sí funciona en scripts por lotes.
> **EN:** `readline(prompt = ...)` is not used: it is intended for R's interactive console and **does not reliably consume input under `Rscript`** (it prints the prompt but returns an empty string). The `cat` + `readLines("stdin", n = 1)` combination does work in batch scripts.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener R instalado

```bash
# Verificar instalación
R --version
```

### Ejecutar / Run

```bash
cd r/core/foundations/hellouser
Rscript hellouser.r
```

**ES:** El programa muestra el prompt y espera a que escribas tu nombre y presiones Enter.
**EN:** The program shows the prompt and waits for you to type your name and press Enter.

### Salida esperada / Expected output

```text
Enter your name: Ada
[1] "Hello, Ada!"
```

> **ES:** También admite entrada redirigida: `printf 'Ada\n' | Rscript hellouser.r` produce el mismo saludo.
> **EN:** It also accepts redirected input: `printf 'Ada\n' | Rscript hellouser.r` produces the same greeting.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** R no requiere una función `main`: el script se ejecuta de arriba a abajo como en lenguajes de scripting.
- **EN:** R does not require a `main` function: the script executes top to bottom like in scripting languages.
- **ES:** `print` escribe en `stdout` y añade automáticamente un salto de línea.
- **EN:** `print` writes to `stdout` and automatically appends a newline.
- **ES:** Se elige la variante interactiva (`cat` + `readLines("stdin", n = 1)`) como flujo principal para seguir el patrón de la especificación (prompt + entrada). La variante por argumentos con `commandArgs(trailingOnly = TRUE)` queda comentada como alternativa idiomática de R para CLIs.
- **EN:** The interactive variant (`cat` + `readLines("stdin", n = 1)`) is chosen as the main flow to follow the specification's pattern (prompt + input). The argument variant with `commandArgs(trailingOnly = TRUE)` remains commented out as R's idiomatic alternative for CLIs.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*

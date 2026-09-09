# Interactive use: reads the name from standard input.
# Usage: Rscript hellouser.r   (then type the name and press Enter)
cat("Enter your name: ")
flush(stdout())
name <- readLines("stdin", n = 1)
print(paste0("Hello, ", name, "!"))

# Command-line alternative: pass the name as an argument.
# Usage: Rscript hellouser.r <name>
# Example: Rscript hellouser.r John
#args <- commandArgs(trailingOnly = TRUE)
#name <- args[1]
#print(paste0("Hello, ", name, "!"))
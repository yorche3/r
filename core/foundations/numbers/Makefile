# Runner del modulo: un solo comando (`make test`).
# La biblioteca de usuario de R se fija en ~/.Renviron (R_LIBS_USER).

R ?= Rscript

.PHONY: test clean

test:
	$(R) -e "testthat::test_local()"

clean:
	rm -rf *.Rcheck

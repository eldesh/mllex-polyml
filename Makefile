## Copyright (C) 2020 Takayuki Goto

POLYML      := poly
POLYMLC     := polyc
POLYMLFLAGS := -q --error-exit

PDFLATEX    := pdflatex
DIFF        := diff

NAME := mllex_polyml

DOCS := $(NAME).pdf

SRC := $(wildcard *.sml)


all:	$(NAME)


$(NAME): $(NAME).o
	@echo "  [POLYMLC] $@"
	@$(POLYMLC) -o $@ $^


$(NAME).o: $(SRC)
	@echo "  [POLYML] $@"
	@echo "" | $(POLYML) $(POLYMLFLAGS) \
		--eval 'PolyML.make (OS.FileSys.getDir())' \
		--eval 'PolyML.export ("$@", Main.main)'


lexgen.pdf: lexgen.tex
	$(PDFLATEX) lexgen.tex
	$(PDFLATEX) lexgen.tex
	$(PDFLATEX) lexgen.tex


mllex_polyml.pdf: lexgen.pdf
	cp lexgen.pdf mllex.pdf


.PHONY: docs
docs: $(DOCS)


.PHONY: test
test: $(NAME)
	PATH=.:$(PATH) $(NAME) ml.lex
	$(DIFF) ml.lex.sml ml.lex.sml.exp
	$(RM)   ml.lex.sml


.PHONY: clean
clean:
	-$(RM) $(NAME) $(NAME).o
	-$(RM) $(DOCS)


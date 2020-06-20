## Copyright (C) 2020 Takayuki Goto

POLYML      := poly
POLYMLC     := polyc
POLYMLFLAGS := -q --error-exit

PDFLATEX    := pdflatex
DIFF        := diff

NAME := mllex-polyml

DOCS := $(NAME).pdf

SRCS := $(wildcard *.sml)


all:	$(NAME) $(DOCS)


$(NAME): $(NAME).o
	@echo "  [POLYMLC] $@"
	@$(POLYMLC) -o $@ $^


$(NAME).o: $(SRCS)
	@echo "  [POLYML] $@"
	@echo "" | $(POLYML) $(POLYMLFLAGS) \
		--eval 'PolyML.make (OS.FileSys.getDir())' \
		--eval 'PolyML.export ("$@", Main.main)'


lexgen.pdf: lexgen.tex
	$(PDFLATEX) lexgen.tex
	$(PDFLATEX) lexgen.tex
	$(PDFLATEX) lexgen.tex


$(NAME).pdf: lexgen.pdf
	cp lexgen.pdf $@


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
	-$(RM) lexgen.aux lexgen.log lexgen.toc lexgen.pdf


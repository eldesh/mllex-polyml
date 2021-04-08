## Copyright (C) 2020 Takayuki Goto

POLYML       := poly
POLYMLC      := polyc
POLYMLFLAGS  := -q --error-exit

PDFLATEX     := pdflatex
DIFF         := diff

PREFIX       := /usr/local/polyml
BINDIR       := bin
DOCDIR       := doc/mllex-polyml

MLLEX_POLYML := mllex-polyml

DOCS         := mllex-polyml.pdf

SRCS         := $(wildcard *.sml)


all: mllex-polyml


.PHONY: mllex-polyml
mllex-polyml: mllex-polyml-nodocs docs


.PHONY: mllex-polyml-nodocs
mllex-polyml-nodocs: $(BINDIR)/$(MLLEX_POLYML)


$(BINDIR)/$(MLLEX_POLYML): $(MLLEX_POLYML).o
	@echo "  [POLYMLC] $@"
	@$(POLYMLC) -o $@ $^


$(MLLEX_POLYML).o: $(SRCS)
	@echo "  [POLYML] $@"
	@echo "" | $(POLYML) $(POLYMLFLAGS) \
		--eval 'PolyML.make (OS.FileSys.getDir())' \
		--eval 'PolyML.export ("$@", Main.main)'


lexgen.pdf: lexgen.tex
	-$(RM) lexgen.aux lexgen.log lexgen.toc lexgen.pdf
	$(PDFLATEX) lexgen.tex
	$(PDFLATEX) lexgen.tex
	$(PDFLATEX) lexgen.tex


$(DOCS): lexgen.pdf
	cp lexgen.pdf $(DOCS)


.PHONY: docs
docs: $(DOCS)


.PHONY: test
test: mllex-polyml-nodocs
	$(BINDIR)/$(MLLEX_POLYML) ml.lex
	$(DIFF) ml.lex.sml ml.lex.sml.exp
	$(RM)   ml.lex.sml


.PHONY: install-nodocs
install-nodocs: mllex-polyml-nodocs
	install -D -m 0755 -t $(PREFIX)/$(BINDIR) $(BINDIR)/$(MLLEX_POLYML)


.PHONY: install
install: install-nodocs docs
	install -D -m 0444 -t $(PREFIX)/$(DOCDIR) $(DOCS)


.PHONY: clean
clean:
	-$(RM) $(BINDIR)/$(MLLEX_POLYML) $(MLLEX_POLYML).o
	-$(RM) $(DOCS)
	-$(RM) lexgen.aux lexgen.log lexgen.toc lexgen.pdf


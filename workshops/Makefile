# Tools
LATEXMK = latexmk
RM = rm -rf

# Project-specific settings
DOCNAME ?= overview

# Targets
all: doc
doc: pdf
pdf: $(DOCNAME).pdf

# Rules
%.pdf: %.tex 
	$(LATEXMK) -pdflua -pdflualatex="lualatex --shell-escape" -M -MP -MF $*.d $*

mostlyclean:
	$(LATEXMK) -silent -c
	$(RM) *.bbl

clean: mostlyclean
	$(LATEXMK) -silent -C
	$(RM) *.run.xml *.synctex.gz minted_cache
	$(RM) *.d *.aux *-blx.bib *.{snm,nav}

.PHONY: all clean doc mostlyclean pdf

# Include auto-generated dependencies
-include *.d


# Tools
LATEXMK = latexmk
RM = rm -f

# Project-specific settings
DOCNAME ?= r_workflows

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
	$(RM) *.run.xml *.synctex.gz
	$(RM) *.d *.aux *-blx.bib *.{snm,nav}

.PHONY: all clean doc mostlyclean pdf

# Include auto-generated dependencies
-include *.d


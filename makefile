# tex file without
SOURCE = manuscript
LATEX = pdflatex
# LATEX = ptex2pdf
# LATEX = platex

defaults: diffpdf

.PHONY: diff diffpdf open

open: $(SOURCE)_diff.pdf
	open $(SOURCE)_diff.pdf

diffpdf: $(SOURCE)_diff.pdf

$(SOURCE)_diff.pdf: $(SOURCE)_diff.tex
	$(LATEX) ${SOURCE}_diff
	pbibtex ${SOURCE}_diff
	$(LATEX) ${SOURCE}_diff
	$(LATEX) ${SOURCE}_diff
ifeq ($(LATEX),platex)
	dvipdfmx $(SOURCE)_diff
endif

difftex: $(SOURCE)_diff.tex

$(SOURCE)_diff.tex: $(SOURCE)_prev.tex $(SOURCE).tex ./latexdiff_tool/diffpreamble.tex
	latexdiff -e utf8 --preamble=./latexdiff_tool/diffpreamble.tex $(SOURCE)_prev.tex $(SOURCE).tex > $(SOURCE)_diff.tex

prev:
	cp $(SOURCE).tex $(SOURCE)_prev.tex

clean:
	rm $(SOURCE)_diff.*

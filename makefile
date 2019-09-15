# tex file without
RELATIVE_PATH = ./latexdiff_tool
include $(RELATIVE_PATH)/settings.mk

defaults: diffpdf

.PHONY: diff diffpdf open

open: $(SOURCE)_diff.pdf
	open $(SOURCE)_diff.pdf

diffpdf: $(SOURCE)_diff.pdf

$(SOURCE)_diff.pdf: $(SOURCE)_diff.tex
	$(LATEX) ${LATEX_OPT} ${SOURCE}_diff
	$(BIBTEX) ${BIBTEX_OPT} ${SOURCE}_diff
	$(LATEX) ${LATEX_OPT} ${SOURCE}_diff
	$(LATEX) ${LATEX_OPT} ${SOURCE}_diff
ifeq ($(LATEX),platex)
	dvipdfmx $(SOURCE)_diff
endif

difftex: $(SOURCE)_diff.tex

$(SOURCE)_diff.tex: $(SOURCE)_prev.tex $(SOURCE).tex ${RELATIVE_PATH}/diffpreamble.tex
	latexdiff ${LATEXDIFF_OPT} --preamble=${RELATIVE_PATH}/diffpreamble.tex $(SOURCE)_prev.tex $(SOURCE).tex > $(SOURCE)_diff.tex

prev:
	cp $(SOURCE).tex $(SOURCE)_prev.tex

$(RELATIVE_PATH)/settings.mk: $(RELATIVE_PATH)/settings.mk.sample
	cp $(RELATIVE_PATH)/settings.mk.sample $(RELATIVE_PATH)/settings.mk

clean:
	rm -f $(SOURCE)_diff.tex

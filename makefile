# tex file without
RELATIVE_PATH = ./texutils
include $(RELATIVE_PATH)/settings.mk
TEXDIF_AUTOGEN = $(SOURCE)-diff$(GIT_REV)

defaults: diffpdf

.PHONY: diff diffpdf open

open: $(TEXDIF_AUTOGEN).pdf
	open -a preview.app $(TEXDIF_AUTOGEN).pdf

diffpdf: $(TEXDIF_AUTOGEN).pdf

difftex: $(TEXDIF_AUTOGEN).tex

rtf:
	latex2rtf -E0 $(SOURCE)
figrtf:
	latex2rtf $(SOURCE)

archive:
	git archive HEAD --prefix=submit/ -o ../submit.zip

diffclean:
	rm $(TEXDIF_AUTOGEN).* $(SOURCE)-diff* $(SOURCE)-oldtmp*

distclean:
	rm -f *.aux *.dvi *.log *.synctex.gz *.bbl *.blg *.fls

$(TEXDIF_AUTOGEN).pdf: $(TEXDIF_AUTOGEN).tex
	$(LATEX) --interaction=nonstopmode $(LATEX_OPT) $(TEXDIF_AUTOGEN) > diff_tex1.log
#	$(BIBTEX) ${BIBTEX_OPT} $(TEXDIF_AUTOGEN) > diff_bibtex.log
	$(LATEX) --interaction=nonstopmode ${LATEX_OPT} $(TEXDIF_AUTOGEN) > diff_tex2.log
#	$(LATEX) --interaction=nonstopmode ${LATEX_OPT} $(TEXDIF_AUTOGEN) > diff_tex3.log
ifeq ($(LATEX),platex)
	dvipdfmx $(TEXDIF_AUTOGEN) > diff_dvipdfmx.log
endif

$(TEXDIF_AUTOGEN).tex: $(RELATIVE_PATH)/settings.mk $(RELATIVE_PATH)/diffpreamble.tex $(SOURCES)
	latexdiff-vc $(TEXDIF_OPT) --preamble=${RELATIVE_PATH}/diffpreamble.tex --git --flatten -r $(GIT_REV) $(SOURCE).tex > diff_latexdiff.log

## deprecated

# $(SOURCE)_diff.pdf: $(SOURCE)_diff.tex
# 	$(LATEX) --interaction=nonstopmode ${LATEX_OPT} ${SOURCE}_diff > diff_tex1.log 2>&1
# 	$(BIBTEX) ${BIBTEX_OPT} ${SOURCE}_diff > diff_bibtex.log 2>&1
# 	$(LATEX) --interaction=nonstopmode ${LATEX_OPT} ${SOURCE}_diff > diff_tex2.log 2>&1
# 	$(LATEX) --interaction=nonstopmode ${LATEX_OPT} ${SOURCE}_diff > diff_tex3.log 2>&1
# ifeq ($(LATEX),platex)
# 	dvipdfmx $(SOURCE)_diff > diff_dvipdfmx.log 2>&1
# endif

# $(SOURCE)_diff.tex: $(SOURCE)_prev.tex $(SOURCE).tex ${RELATIVE_PATH}/diffpreamble.tex
# #	latexdiff ${LATEXDIFF_OPT} --preamble=${RELATIVE_PATH}/diffpreamble.tex $(SOURCE)_prev.tex $(SOURCE).tex > $(SOURCE)_diff.tex 2> diff_latexdiff.log
# 	latexdiff ${LATEXDIFF_OPT} $(SOURCE)_prev.tex $(SOURCE).tex > $(SOURCE)_diff.tex 2> diff_latexdiff.log

# prev:
# 	cp $(SOURCE).tex $(SOURCE)_prev.tex

# $(SOURCE)_prev.tex: $(RELATIVE_PATH)/settings.mk
# 	git show $(GIT_REV):$(SOURCE).tex > $(SOURCE)_prev.tex

#$(RELATIVE_PATH)/settings.mk: $(RELATIVE_PATH)/settings.mk.sample
#	cp $(RELATIVE_PATH)/settings.mk.sample $(RELATIVE_PATH)/settings.mk

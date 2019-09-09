# tex file without 
SOURCE = conference_041818

defaults: diffpdf

.PHONY: diff diffpdf open

open: $(SOURCE)_diff.pdf
	open $(SOURCE)_diff.pdf

diffpdf: $(SOURCE)_diff.pdf

$(SOURCE)_diff.pdf: $(SOURCE)_diff.tex
	platex ${SOURCE}_diff
	pbibtex ${SOURCE}_diff
	platex ${SOURCE}_diff
	platex ${SOURCE}_diff
	dvipdfmx $(SOURCE)_diff

difftex: $(SOURCE)_diff.tex

$(SOURCE)_diff.tex: $(SOURCE)_prev.tex $(SOURCE).tex diffpreamble.tex
	latexdiff -e utf8 --preamble=diffpreamble.tex $(SOURCE)_prev.tex $(SOURCE).tex > $(SOURCE)_diff.tex

clean:
	rm $(SOURCE)_diff.*

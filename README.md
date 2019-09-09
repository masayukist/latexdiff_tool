# latexdiff_tool
comfortable latexdiff template

## usage
1. extract the files in your tex directory.
2. set file name to SOURCE in makefile.
3. make a copy of tex as $(SOURCE)_prev.tex in the same directory.
4. modify $(SOURCE).tex as difference.
5. execute make command.
6. you get $(SOURCE)_diff.pdf, in which differences are shown in the red string.

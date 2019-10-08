# Latex Utilties

Various utiltiy commands into one makefile for writing tex manuscript.

## usage

1. extract this repository in your tex directory.
2. set file name to SOURCE in makefile.
3. make a copy of tex as ``$(SOURCE)_prev.tex`` in the same directory, using ``make -f texutils/makefile prev``.
4. modify $(SOURCE).tex as difference.
5. execute ``make -f texutils/makefile diff`` command.
6. you get ``$(SOURCE)_diff.pdf``, in which differences are shown in the red string.
7. execute ``make -f texutils/makefile rtf`` command.
8. you get the RTF file of your manuscript.
9. execute ``make -f texutils/makefile archive`` command.
10. you get the archive file ``submit.zip`` in the parent directory.

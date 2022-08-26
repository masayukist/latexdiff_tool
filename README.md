# Latex Utilties

Various utility commands for writing a tex manuscript into one makefile.

## usage

1. extract this repository in your tex directory.
2. generate ``settings.mk`` from the template ``settings.mk.sample``.
  1. set file name to ``SOURCE``
  2. select appropriate ``LATEX``, ``BIBTEX``, ``TEXDIF_OPT``
  2. set a git revision to ``GIT_REV`` 
3. execute useful commands.
  1. ``make -f texutils/makefile diffpdf`` can generate a differential PDF file
  2. ``make -f texutils/makefile rtf`` can generate a RTF file
  3. ``make -f texutils/makefile archive`` can generate git archive of a current working reivison ``submit.zip``.
10. you get the archive file ``submit.zip`` in the parent directory.

#!/bin/bash
# Andre Anjos <andre.anjos@idiap.ch>
# Thu 26 Jan 2012 09:34:00 CET

pyz=$(which pygmentize-2.7);

if [ -n "${pyz}" ]; then
  case "$1" in
    # add all extensions you want to handle here
    *.awk|*.groff|*.java|*.js|*.m4|*.php|*.pl|*.pm|*.pod|*.sh|\
      *.ad[asb]|*.asm|*.inc|*.[ch]|*.[ch]pp|*.[ch]xx|*.cc|*.hh|\
      *.lsp|*.l|*.pas|*.p|*.xml|*.xps|*.xsl|*.axp|*.ppd|*.pov|\
      *.diff|*.patch|*.py|*.rb|*.rst|*.sh|*.sql|*.ebuild|*.eclass|*.tex|\
      Makefile) ${pyz} -O "bg=dark" "$1" ;;
    *) exit 0;;
  esac
fi

exit 0;

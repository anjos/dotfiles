# Created by Andre Anjos <andre.dos.anjos@cern.ch> 
# Qui 26 Jul 2007 14:35:58 CEST 

# Downloads and builds spelling dictionaries for
# portuguese (brasil), english (us), french (france)
# and spanish (spain), all automagically

PT=http://www.deso-se.com.br/downloads/download.php?arquivo=pt_BR-2007-04-11
EN=http://ftp.services.openoffice.org/pub/OpenOffice.org/contrib/dictionaries/en_US.zip
FR=http://ftp.services.openoffice.org/pub/OpenOffice.org/contrib/dictionaries/fr_FR-1990.zip
ES=http://ftp.services.openoffice.org/pub/OpenOffice.org/contrib/dictionaries/es_ES.zip
GARBAGE=find . -maxdepth 1 -type f -not -name "Makefile" -not -name "*.spl" -not -name "*.add" -print0 | xargs -0 rm -f -v

all: pt en fr es

.PHONY: pt en fr es clean deepclean

pt:
	@wget $(PT)
	@unzip -x *.zip
	@vim "+mkspell $@ pt_BR" "+q!"
	@$(GARBAGE)

en:
	@wget $(EN)
	@unzip -x *.zip
	@vim "+mkspell $@ en_US" "+q!"
	@$(GARBAGE)

fr:
	@wget $(FR)
	@unzip -x *.zip
	@vim "+mkspell $@ fr_FR-1990" "+q!"
	@$(GARBAGE)

es:
	@wget $(ES)
	@unzip -x *.zip
	@vim "+mkspell $@ es_ES" "+q!"
	@$(GARBAGE)

clean:
	@$(GARBAGE)

deepclean: clean
	@rm -f -v *.spl


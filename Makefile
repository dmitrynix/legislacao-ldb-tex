OUTPUT = legislacao-slides
COMMAND= pdflatex -shell-escape -interaction=nonstopmode index.tex

all:
	sed '/url =/s/url =/howpublished ={\\url/g; /howpublished =/s/},/}},/g' ExportedItems.bib > Items.bib
	$(COMMAND)
	bibtex index
	$(COMMAND)
	$(COMMAND)
	make clean

clean:
	rm -f *.aux *.bbl *.toc *.out *.log *.nls *.nlo *.lof *.lot *.blg *.ilg *.nav *.snm
	rm -f Items.bib

preview:
	rm -f index.pdf
	$(COMMAND)
	evince --page-index 1 --presentation index.pdf 2>/dev/null

talk:
	rm -f index.pdf
	make 1>/dev/null 2>/dev/null
	evince --page-index 1 --presentation index.pdf 2>/dev/null

cp:
	make clean
	rm -f index.pdf
	make 1>/dev/null 2>/dev/null
	cp index.pdf ~/Dropbox/Documents/Latex/$(OUTPUT).pdf

unexport BSTINPUTS
unexport BIBINPUTS
unexport TEXINPUTS
export BSTINPUTS=:config:bib:out:
export BIBINPUTS=:config:bib:out:
export TEXINPUTS=out:config:

file = processo-codificacao
out = out
figs = figs
figs-out = figs-out

figures = $(shell dir $(figs)/*.*)
all-figs = $(addsuffix .eps,$(notdir $(basename $(figures))))

vpath %.eps $(out)
vpath %.ly $(figs)
vpath %.eps $(figs-out)
vpath %.dia $(figs)
vpath %.svg $(figs)
vpath %.pdf $(figs)
vpath %.sty config

dvi: $(all-figs) $(file).dvi $(file).lytex 
ps:  $(all-figs) $(file).ps $(file).lytex
pdf:  $(all-figs) $(file).pdf $(file).lytex

push:
	darcs push cons@genos.mus.br:genos.mus.br/processo-codificacao

cleanall: cleanout clean

cleanout: $(file).tex
	sh ./config/latexmk -C $(out)/$<

clean:
	rm -rf $(figs-out) ;\
	rm -rf out ;\
	rm -rf auto ;\
	rm -rf $(svg-figs)

%.tex: %.lytex
	mkdir -p $(out) ;\
	cp config/*.sty config/*.bst $(out)/ ;\
	lilypond-book -V -o $(out) $< ;\

%.dvi: %.tex
	sh ./config/latexmk $(out)/$< ;\

%.ps: %.dvi
	dvips -o $@ $<

%.pdf: %.ps
	ps2pdf -sPAPERSIZE=a4 $<

%.eps: %.svg
	mkdir -p $(figs-out) ;\
	inkscape -E $(figs-out)/$@ $<

%.eps: %.dia
	mkdir -p $(figs-out) ;\
	dia --nosplash  -t eps --export=$(figs-out)/$@ $<

%.eps: %.ly
	mkdir -p $(figs-out)/tmp ;\
	cp $< $(figs-out)/tmp ;\
	cd $(figs-out)/tmp ;\
	lilypond -b eps --preview $(notdir $<) ;\
	mv $(notdir $(basename $<)).preview.eps ../$(notdir $(basename $<)).eps ;\

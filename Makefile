COMMONFORM=node_modules/.bin/commonform
all: agreement.docx agreement.pdf

$(COMMONFORM):
	npm i

%.pdf: %.docx
	doc2pdf $<

%.docx: %.cform %.signatures.json %.blanks.json %.options
	$(COMMONFORM) render \
		--format docx \
		--signatures $*.signatures.json \
		--left-align-title \
		--indent-margins \
		--blanks $*.blanks.json \
		$(shell cat $*.options) \
		< $< > $@

.PHONY: clean

clean:
	rm -f agreement.docx agreement.pdf

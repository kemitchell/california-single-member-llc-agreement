all: agreement.docx agreement.pdf

%.pdf: %.docx
	doc2pdf $<

%.docx: %.commonform %.signatures.json %.blanks.json %.options
	commonform render \
		--format docx \
		--signatures $*.signatures.json \
		--blanks $*.blanks.json \
		$(shell cat $*.options) \
		< $< > $@

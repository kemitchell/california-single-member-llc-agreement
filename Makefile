TARGETS=build/agreement.docx

all: $(TARGETS)

build/%.docx: build/%.form build/%.title build/%.signatures build/%.styles | node_modules
	npx commonform-docx \
		--title "$(shell cat build/$*.title)" \
		--number outline \
		--indent-margins \
		--smart \
		--left-align-title \
		--left-align-body \
		--signatures build/$*.signatures \
		--styles build/$*.styles \
		$< > $@

build/%.json: %.md | build node_modules
	npx commonform-commonmark parse < $< > $@

build/%.title: build/%.json | node_modules
	npx json frontMatter.title < $< > $@

build/%.signatures: build/%.json | node_modules
	npx json frontMatter.signatures < $< > $@

build/%.styles: build/%.json | node_modules
	npx json frontMatter.styles < $< > $@

build/%.form: build/%.json | node_modules
	npx json form < $< > $@

build:
	mkdir -p $@

node_modules:
	npm i

.PHONY: clean

clean:
	rm -rf build

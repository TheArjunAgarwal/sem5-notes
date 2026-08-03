# List of .typ source files
TYP_FILES = aai.typ aalg.typ cana.typ plc.typ topo.typ deqn.typ

# Derive the corresponding PDFs in the Renders/ folder
PDFS = $(TYP_FILES:%.typ=Renders/%.pdf)

# Default target: build all PDFs
all: $(PDFS)

# Rule: how to build Renders/file.pdf from file.typ
Renders/%.pdf: %.typ
	mkdir -p Renders
	typst compile $< $@

# Clean up generated PDFs
clean:
	rm -rf Renders

# Build, then commit & push
push: all
	git add .
	git commit -m "chore: update generated PDFs and typst srcs" || echo "No changes to commit"
	git push
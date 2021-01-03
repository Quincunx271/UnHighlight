.PHONY: all
all: build/unhighlight.zip

build/unhighlight.zip: manifest.json unhighlight.js
	@mkdir -p build
	zip -r $@ $^

.PHONY: clean
clean:
	rm -rf build

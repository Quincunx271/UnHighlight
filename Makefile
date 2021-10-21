.PHONY: all
all: build/unhighlight-0.2-fx.xpi

build/unhighlight-0.2-fx.xpi: build/unhighlight.zip
	cp $^ $@

build/unhighlight.zip: manifest.json unhighlight.js
	@mkdir -p build
	zip -r $@ $^

.PHONY: clean
clean:
	rm -rf build

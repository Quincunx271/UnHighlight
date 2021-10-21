.PHONY: all
all: build/unhighlight-0.2-fx.xpi logo

build/unhighlight-0.2-fx.xpi: build/unhighlight.zip
	cp $^ $@

build/unhighlight.zip: manifest.json unhighlight.js build/logo128x128.png build/logo96x96.png build/logo48x48.png
	@mkdir -p build
	zip -r $@ $^

.PHONY: logo
logo: build/logo128x128.png build/logo96x96.png build/logo48x48.png

build/logo-max-dim: logo.svg
	@mkdir -p build
	inkscape -W -H $^ 2>/dev/null | python3 -c "import sys; print(round(max(float(x) for x in sys.stdin.read().split() if x.strip())))" > $@

build/logo-half-dimx-diff: logo.svg build/logo-max-dim
	@mkdir -p build
	inkscape -W $< 2>/dev/null | python3 -c "import sys; width = round(float(sys.stdin.read().strip())); print(max(0, (int(sys.argv[1]) - width) // 2))" $$(cat build/logo-max-dim) > $@

build/logo-half-dimy-diff: logo.svg build/logo-max-dim
	@mkdir -p build
	inkscape -H $< 2>/dev/null | python3 -c "import sys; height = round(float(sys.stdin.read().strip())); print(max(0, (int(sys.argv[1]) - height) // 2))" $$(cat build/logo-max-dim) > $@

build/logo128x128.png: logo.svg build/logo-max-dim build/logo-half-dimx-diff build/logo-half-dimy-diff
	inkscape -o $@ -w 128 -h 128 --export-area=-$$(cat build/logo-half-dimx-diff):-$$(cat build/logo-half-dimy-diff):$$(cat build/logo-max-dim):$$(cat build/logo-max-dim) --export-area-snap $<

build/logo96x96.png: logo.svg build/logo-max-dim build/logo-half-dimx-diff build/logo-half-dimy-diff
	inkscape -o $@ -w 96 -h 96 --export-area=-$$(cat build/logo-half-dimx-diff):-$$(cat build/logo-half-dimy-diff):$$(cat build/logo-max-dim):$$(cat build/logo-max-dim) --export-area-snap $<

build/logo48x48.png: logo.svg build/logo-max-dim build/logo-half-dimx-diff build/logo-half-dimy-diff
	inkscape -o $@ -w 48 -h 48 --export-area=-$$(cat build/logo-half-dimx-diff):-$$(cat build/logo-half-dimy-diff):$$(cat build/logo-max-dim):$$(cat build/logo-max-dim) --export-area-snap $<

.PHONY: clean
clean:
	rm -rf build

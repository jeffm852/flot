# Makefile for generating minified files

.PHONY: all custom

# we cheat and process all .js files instead of an exhaustive list
all: $(patsubst %.js,%.min.js,$(filter-out %.min.js,$(wildcard *.js)))

%.min.js: %.js
	yui-compressor $< -o $@

test:
	./node_modules/.bin/jshint *jquery.flot.js

#https://stackoverflow.com/questions/4413903/makefile-to-combine-js-files-and-make-a-compressed-version

modules = jquery.flot.js\
	jquery.flot.time.js\
	jquery.flot.pie.js\
	jquery.flot.categories.js\
	jquery.flot.resize.js

custom: custom.js custom.min.js

custom.js: ${modules}
	cat > $@ $^

custom.min.js:
	yui-compressor custom.js -o custom.min.js

clean:
	-rm *.min.js *custom.js

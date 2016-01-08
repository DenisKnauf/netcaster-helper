pt.min.js: pt.js
	uglifyjs --compress --mangle --reserved '$$' --in-source-map pt.js.map --output $@ --source-map $@.map $<

pt.js: pt.coffee
	coffee --compile --map $<

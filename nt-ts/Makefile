netcast-ts.min.js: netcast-ts.js
	uglifyjs --compress --mangle --reserved '$$' --in-source-map netcast-ts.js.map --output $@ --source-map $@.map $<

netcast-ts.js: netcast-ts.coffee
	coffee --compile --map $<

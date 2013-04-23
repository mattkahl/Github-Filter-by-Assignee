SHELL = /bin/sh
SRC = filter_by_assignee.coffee
BIN = ./node_modules/.bin/

all: chrome safari

chrome:
	cat $(SRC) | $(BIN)coffee -cs | $(BIN)uglifyjs -o Chrome/extension/filter_by_assignee.min.js

safari:
	cat $(SRC) | $(BIN)coffee -cs | $(BIN)uglifyjs -o Safari/Github\ Filter\ By\ Assignee.safariextension/filter_by_assignee.min.js

clean:
	rm -f Chrome/extension/filter_by_assignee.min.js Safari/Github\ Filter\ By\ Assignee.safariextension/filter_by_assignee.min.js

.PHONY: chrome safari
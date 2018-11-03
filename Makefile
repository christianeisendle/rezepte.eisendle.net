all: clean generate publish

clean:
	@rm -rf public/

publish:
	@rsync -rave ssh public/ --delete --stats server.eisendle.net:/var/www/htdocs/rezepte.eisendle.net

generate:
	@hugo

.DEFAULT_GOAL := all


all: clean generate publish

clean:
	@rm -rf public/

publish:
	@rsync -rave ssh public/ --delete --stats server.eisendle.net:/var/www/htdocs/rezepte.eisendle.net

generate:
	@docker run --rm -it -v ${PWD}:/hugo hugo hugo

docker-image:
	@docker build . --build-arg HUGO_UID=`id -u` -t hugo


.DEFAULT_GOAL := all


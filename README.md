elm-live
========

A docker image, based on node, installing elm and elm-live. 

Allows local development, using elm-live, in a containerised environment.

It also includes a build script, `build.sh`, that can be used to compile minified, gzipped static assets that are ready for production.

Assumptions
-----------

- You don't have any static assets to include, other than the elm application itself.
- You want to compile your elm application to a standalone javascript file, which is then referenced in your `index.html` file.

Local development
-----------------

From within your elm application directory, run:
```sh
docker run --rm \
	-d \
	-p 8000:8000 \
	-v $(PWD)/elm.json:/app/elm.json:ro \
	-v $(PWD)/src:/app/src:ro \
	-v $(PWD)/index.html:/app/index.html:ro \
	add1ed/elm-live:latest /app/src/Main.elm \
		--hot \
		--pushstate \
		--host=0.0.0.0 \
		-- --output=index.js --debug

```

Production compilation
----------------------

From within your elm application directory, run:
```sh
docker run --rm \
	-v $(PWD)/dist:/app/dist \
	-v $(PWD)/elm.json:/app/elm.json:ro \
	-v $(PWD)/src:/app/src:ro \
	-v $(PWD)/index.html:/app/index.html:ro \
	--entrypoint=/bin/bash \
	add1ed/elm-live:latest \
		/app/build.sh
```
to generate compiled assets in the directory `dist`.
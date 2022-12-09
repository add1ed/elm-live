#!/bin/bash
set -e
DIR=$PWD
JS_FILENAME="${FILENAME:-index}"
UNESCAPED_BASE_PATH="${BASE_PATH:-\/}"
BASE_HREF_PATH=$(sed 's/[&/\]/\\&/g' <<<"$UNESCAPED_BASE_PATH")
rm -f $DIR/dist/* && \
cp $DIR/index.html $DIR/dist/index.html && \
elm make $DIR/src/Main.elm --optimize --output=$DIR/dist/elm.js && \
uglifyjs $DIR/dist/elm.js --compress 'pure_funcs=[F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9],pure_getters,keep_fargs=false,unsafe_comps,unsafe' | uglifyjs --mangle --output $DIR/dist/$JS_FILENAME.js && \
rm -f $DIR/dist/elm.js && \
cp $DIR/index.html $DIR/dist/index.html && \
sed -i "s/index.js/$JS_FILENAME.js/" $DIR/dist/index.html && \
sed -i "s/base href=\"\/\"/base href=\"$BASE_HREF_PATH\"/" $DIR/dist/index.html && \
gzip -k $DIR/dist/*
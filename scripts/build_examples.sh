#!/bin/bash
mkdir -p ./docs/examples/assets
cp -R ./examples/assets ./docs/examples

doc_body="<ul>\n"

compile() {
  f=$1
  f=${f/\.\/examples\//""}
  f=${f/.rs/""}
  ./scripts/web_example.sh $f --release --no-assets

  url="examples/${f}.html"
  doc_body="${doc_body}\n<li><a href=\"${url}\">${f}</a></li>"
}

for f in ./examples/*.rs; do
  compile "$f" 
done

wait

doc_body="${doc_body}\n</ul>"
cp ./scripts/docs.html ./docs/index.html
index=$(sed "s#{{ BODY }}#${doc_body}#g" "./scripts/docs.html")
echo "${index}" > ./docs/index.html

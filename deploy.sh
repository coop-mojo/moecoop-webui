#!/bin/sh

rm -rf public || exit 0
mkdir public

cp -r dist public
echo $MOECOOP_DOMAIN > public/CNAME

cd public
mv dist/index.html .

git init
git config user.name 'Travis CI'
git config user.email 'coop.e.moe@gmail.com'
git add -A
git commit -m "Deploy to Github Pages"
git push -f -q "https://${GH_TOKEN}@github.com/coop-mojo/moecoop-webui.git" master:gh-pages > /dev/null 2>&1

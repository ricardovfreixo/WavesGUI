#!/usr/bin/env bash

echo "run post install script"

echo "compile typescript"
./node_modules/.bin/tsc || exit 1
./node_modules/.bin/browserify data-service/index.js -s ds -u ts-utils -u @turtlenetwork/tn-signature-generator -u ramda --no-bf -o ./data-service-dist/data-service.js || exit 1
echo "compile typescript >> DONE"

echo "run post install script >> DONE"

echo "copy hooks"
cp hooks/pre-commit .git/hooks || exit 0
cp hooks/commit-msg .git/hooks || exit 0
cp hooks/post-checkout .git/hooks || exit 0
echo "copy hooks >> DONE"

echo "apply aliases"
git config alias.s status
git config alias.p "push origin HEAD"
git config alias.a "add ."
git config alias.rh "reset --hard"
git config alias.c "!node ./ts-scripts/commit.js"
git config alias.pu "!node ./ts-scripts/pull.js"
echo "apply aliases >> DONE"


exit 0

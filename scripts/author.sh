#!/bin/sh

git filter-branch --env-filter '
an="clmntgbr"
am="clement.goubier@gmail.com"
cn="clmntgbr"
cm="clement.goubier@gmail.com"
export GIT_AUTHOR_NAME="$an"
export GIT_AUTHOR_EMAIL="$am"
export GIT_COMMITTER_NAME="$cn"
export GIT_COMMITTER_EMAIL="$cm"
'

git push -f
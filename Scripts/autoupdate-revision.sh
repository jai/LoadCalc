#!/bin/sh
# autoupdate-revision.sh
#
# Evgeny Aleksandrov

CURRENT_BRANCH_NAME=`git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3`

COMMITS_COUNT=`git rev-list ${CURRENT_BRANCH_NAME} | wc -l  | tr -d ' '`

filepath="${BUILT_PRODUCTS_DIR}/${INFOPLIST_PATH}"

echo "Updating ${filepath}"
echo "Current version build ${COMMITS_COUNT}"
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion ${COMMITS_COUNT}" "${filepath}"

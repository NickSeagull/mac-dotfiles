
#!/bin/bash

npm config set registry http://localhost:4873
COLOR='\033[0;32m'
publish(){
  declare -a packages=("${!1}")
  for path in "${packages[@]}"
  do
    echo -e "${COLOR} ✨🧙✨ Doing some magic to publish $(basename "$path") $(tput sgr0)"
    cd $path || exit
    npm unpublish --force --silent @boostercloud/$(basename "$path")
    npm publish --registry http://localhost:4873 --no-git-tag-version --canary --non-interactive
    cd ../..
  done
}
STARTTIME=$(date +%s)
lerna run clean
lerna clean -y
lerna bootstrap
lerna run compile
PACKAGES+=(./packages/framework-types)
PACKAGES+=(./packages/framework-core)
PACKAGES+=(./packages/framework-provider-aws)
PACKAGES+=(./packages/framework-provider-aws-infrastructure)
PACKAGES+=(./packages/framework-provider-local)
PACKAGES+=(./packages/framework-provider-local-infrastructure)
PACKAGES+=(./packages/framework-provider-azure)
PACKAGES+=(./packages/framework-provider-kubernetes)
PACKAGES+=(./packages/framework-provider-kubernetes-infrastructure)
PACKAGES+=(./packages/cli)
publish PACKAGES[@]
echo -e "${COLOR} 🧨  Uninstalling the current Booster version $(tput sgr0)"
npm uninstall -g @boostercloud/cli
echo -e "${COLOR} 💾  Installing the local Booster version including your magic  $(tput sgr0)"
npm install -g @boostercloud/cli
#npm config set registry https://registry.npmjs.org

ENDTIME=$(date +%s)

echo -e "${COLOR} -----------------------"
echo -e "| 🧙 Deploy time: $(($ENDTIME - $STARTTIME)) s |"
echo -e " ----------------------- $(tput sgr0)"
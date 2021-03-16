
#!/bin/bash
COLOR='\033[0;32m'
publish(){
  declare -a packages=("${!1}")
  #for path in "${packages[@]}"
  #do
  #  echo -e "${COLOR} ⏳ Compiling $(basename "$path") $(tput sgr0)"
  #  cd $path || exit
  #  yarn --silent compile || exit
  #  cd ../..
  #done
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
PACKAGES+=(./packages/rocket-static-sites-aws-infrastructure)
PACKAGES+=(./packages/rocket-uploads3-store-event-aws-infrastructure)
PACKAGES+=(./packages/cli)
publish PACKAGES[@]
echo -e "${COLOR} 🧨  Uninstalling the current Booster version $(tput sgr0)"
npm uninstall -g @boostercloud/cli
echo -e "${COLOR} 💾  Installing the local Booster version including your magic  $(tput sgr0)"
npm install -g @boostercloud/cli
if [ $# -eq 1 ]
then
  rm -rf $1
  mkdir $1
  cd $1
  boost new:project test
  cd test
  cp -r ../../rdiaz/populateTestProject/* ./src/
  STARTTIME=$(date +%s)
  boost deploy -e production
  ENDTIME=$(date +%s)
fi
echo -e "${COLOR} -----------------------"
echo -e "| 🧙 Deploy time: $(($ENDTIME - $STARTTIME)) s |"
echo -e " ----------------------- $(tput sgr0)"
projs=(jigasi ice4j docs meet lib-gmeet assemblies jicofo jvb docker)
for proj in ${projs[@]};do
  git clone http://git.rdapp.com/numax/gmeet/$proj.git
  pushd $proj > /dev/null
    git checkout dev
  popd
done

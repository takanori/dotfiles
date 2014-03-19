#!/usr/bin/env zsh
 
if [[ $# -lt 2 ]]; then
	print -P "%UUsage%u: brew install-version [install options] FORMULA VERSION"
	exit 1
fi
 
formula=
version=
install_opts=()
versions_opts=()
for arg in $*; do
	if [[ $arg =~ '^--' ]]; then
		install_opts+=$arg
		[[ $arg == --devel ]] && versions_opts+=$arg
		continue
	fi
	if [[ -z $formula ]]; then
		formula=$arg
		continue
	fi
	version=$arg
done
 
versions=`brew versions $versions_opts $formula`
if [[ $? -ne 0 ]]; then
	print -P "%F{red}%UError%u%f: No available formula for $formula"
	exit 1
fi
 
object=$(echo $versions | awk '$1=="'$version'" {print $4":"$5}')
object=${object/:`brew --prefix`\//:}
if [[ -z $object ]]; then
	print -P "%F{red}%UError%u%f: No available formula for $formula version $version"
	exit 1
fi
 
formula_cache="`brew --cache`/Formula/$formula.rb"
git --git-dir="`brew --repository`/.git" show $object > $formula_cache
if [[ $? -eq 0 ]]; then
	brew install $install_opts $formula_cache
fi

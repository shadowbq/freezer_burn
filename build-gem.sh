#!/usr/bin/env bash

if [ -f ./README.md ] && [ -f ./LICENSE ];
then
  echo "Removing old gem.."
	gem uninstall -x freezer_burn
	echo "Building gem.."
	gem build freezer_burn.gemspec
	echo "Installing gem.."
	gem install freezer_burn-`bump current |grep -o [0-9].*`.gem
	git status
	echo "Validating gem.."
	gem list --local |grep freezer_burn
else
	echo "not in root gem directory, existing."
fi

#!/usr/bin/env bash

set -e

for file in ${HOME}/code/src/github.com/ViBiOh/dotfiles/symlinks/*; do
  [ -r "${file}" ] && [ -e "${file}" ] && rm -f ${HOME}/.`basename ${file}` && ln -s ${file} ${HOME}/.`basename ${file}`
done

MAC_OS_SSH_CONFIG=""
if [ `uname` == 'Darwin' ]; then
  MAC_OS_SSH_CONFIG="
    UseKeyChain no"
fi

echo "Host *
    PasswordAuthentication no
    ChallengeResponseAuthentication no
    HashKnownHosts yes${MAC_OS_SSH_CONFIG}
    ServerAliveInterval 300
    ServerAliveCountMax 2

Host vibioh
    HostName vibioh.fr
    User vibioh
" > ${HOME}/.ssh/config

if [ `uname` == 'Darwin' ]; then
  if ! command -v brew > /dev/null 2>&1; then
    echo Installing brew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    echo
    echo Installing common brew tools
    brew install \
      bash \
      git \
      bash-completion \
      fswatch \
      fzf \
      fd \
      tmux \
      reattach-to-user-namespace \
      openssl \
      gnupg \
      pass \
      node \
      golang \
      graphviz \
      pgcli

    echo
    echo Configuring FZF
    /usr/local/opt/fzf/install

    echo
    echo Installing curl with right option
    brew install curl --with-openssl
    brew link --force curl

    echo
    echo Configuring FZF
    /usr/local/opt/fzf/install

    echo
    echo Configuring pgcli
    mkdir -p "${HOME}/.config/pgcli"
    ln -s "${HOME}/.pgclirc" "${HOME}/.config/pgcli/config"

    echo
    echo Follow instruction in README for configuring bash
  else
    echo
    echo Updating brew packages

    brew update
    brew upgrade
    brew cleanup
  fi
elif [ `uname` == "Linux" ]; then
  if [ ! -d "${HOME}/.fzf" ]; then
    echo
    echo Installing FZF

    git clone --depth 1 https://github.com/junegunn/fzf.git ${HOME}/.fzf
    ${HOME}/.fzf/install
  fi
fi

if [ -d "${HOME}/.fzf" ]; then
  echo
  echo Updating FZF

  cd ${HOME}/.fzf
  git pull
fi

if command -v go > /dev/null 2>&1; then
  echo
  echo Updating golang packages

  go get -v -u github.com/asciimoo/wuzz
  go get -v -u github.com/golang/dep/cmd/dep
  go get -v -u github.com/google/pprof
  go get -v -u github.com/rakyll/hey
  go get -v -u golang.org/x/tools/cmd/goimports
fi

if command -v npm > /dev/null 2>&1; then
  echo
  echo Updating npm packages

  npm install -g npm
fi


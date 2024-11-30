#!/usr/bin/env bash

# Script to install ruby and rails

# Old structure
# if command -v python3.6 &>/dev/null; then
#     echo "=> Python 3.6.8 is installed"
# else

#  fi


# Exit on error
set -e

echo "Starting installation of Ruby and Rails on Debian Bookworm 64-bit..."

# Update package lists and upgrade system
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Install dependencies
echo "Installing required dependencies..."
sudo apt install -y \
  curl git-core build-essential libssl-dev libreadline-dev zlib1g-dev \
  autoconf bison libyaml-dev libncurses5-dev libffi-dev libgdbm-dev \
  libsqlite3-dev sqlite3 nodejs yarn

# NOTE TO SELF add ca-certsss
# sudo apt update
# sudo apt install -y ca-certificates
# sudo update-ca-certificates

# Install rbenv and ruby-build
if ! command -v rbenv &>/dev/null; then
  echo "Installing rbenv and ruby-build..."
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >>~/.bashrc
  echo 'eval "$(rbenv init - bash)"' >>~/.bashrc
  source ~/.bashrc
  mkdir -p "$(rbenv root)"/plugins
  git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
fi

# Install the latest Ruby version
echo "Installing the latest Ruby version..."
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - bash)"
LATEST_RUBY=$(rbenv install -l | grep -v - | tail -1)
echo "-----------here"
echo $LATEST_RUBY
rbenv install "$LATEST_RUBY"
echo "-----------here1"
rbenv global "$LATEST_RUBY"
echo "-----------here2"

# Verify Ruby installation
echo "Ruby version installed: $(ruby -v)"

# Install Bundler
echo "Installing Bundler..."
gem install bundler

# Install Rails
echo "Installing Rails..."
gem install rails

# Rehash rbenv shims
rbenv rehash

# Verify Rails installation
echo "Rails version installed: $(rails -v)"

echo "Installation complete! Ruby and Rails are ready to use."


sudo apt install -y libpq-dev
gem install pg

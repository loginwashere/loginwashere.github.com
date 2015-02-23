#!/bin/bash

# colorize
sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/g' /home/vagrant/.bashrc

# locale
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

start=`date +%s`

export DEBIAN_FRONTEND=noninteractive

sudo apt-get update

sudo apt-get -y install software-properties-common python-software-properties

sudo apt-get -q -y  -o Dpkg::Options::=--force-confnew  install \
    ruby-full \
    curl \
    htop \
    git \
    make \
    vim \
    g++ \
    build-essential \
    mc

# Check versions
echo `ruby -v`

gem install execjs

cd /var/www/blog

gem install bundler
bundle install

echo "Ready to go"

end=`date +%s`

provisionTime=$((end - start))

echo "Provision took: '$provisionTime' seconds"

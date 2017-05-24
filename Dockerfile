from debian:sid
run sed -e 's/deb.debian.org/debian.mirrors.ovh.net/g' -i /etc/apt/sources.list
run apt-get update \
    && apt-get install -y \
      bundler \
      fonts-linuxlibertine \
      inotify-tools \
      libcairo2-dev \
      libpango1.0-dev \
      pdftk \
      poppler-utils \
      ruby \
    && apt-get clean 
add Gemfile /workspace/Gemfile
add Gemfile.lock /workspace/Gemfile.lock
workdir /workspace
run bundle install 
add . /workspace

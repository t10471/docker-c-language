
FROM phusion/baseimage:0.9.12

MAINTAINER t10471 <t104711202@gmail.com>

## disable prompts from apt
ENV DEBIAN_FRONTEND noninteractive

## custom apt-get install options
ENV OPTS_APT        -y --force-yes --no-install-recommends

## ensure locale is set during build
ENV LC_ALL          en_US.UTF-8
ENV LANG            en_US.UTF-8
ENV LANGUAGE        en_US.UTF-8

## ensure locale is set during init
RUN echo           'en_US.UTF-8' >  '/etc/container_environment/LC_ALL'\
 && echo           'en_US.UTF-8' >  '/etc/container_environment/LANG'\
 && echo           'en_US.UTF-8' >  '/etc/container_environment/LANGUAGE'

## ensure locale is set for new logins
RUN echo    'LC_ALL=en_US.UTF-8' >> '/etc/default/locale'\
 && echo      'LANG=en_US.UTF-8' >> '/etc/default/locale'\
 && echo  'LANGUAGE=en_US.UTF-8' >> '/etc/default/locale'

RUN apt-get update\
 && apt-get install ${OPTS_APT}\
      zlib1g-dev \
      git \
      build-essential \
      wget \
      liblua5.2-dev \
      lua5.2 \
      libncurses5-dev \
##      UI系?
##      libgnome2-dev \
##      libgnomeui-dev \
##      libgtk2.0-dev \
##      libatk1.0-dev \
##      libbonoboui2-dev \
##      libcairo2-dev \
##      libx11-dev \
##      libxpm-dev \
##      libxt-dev \
      python-dev \
##      python3-dev \
##      ruby-dev \
      mercurial \
      checkinstall \
      gdb \
      valgrind \
      strace \
      make \
      cmake \
      scons \
      libcunit1 \
      libcunit1-dev \
      libgtest-dev \
      binutils \
      libgoogle-perftools-dev \
      kcachegrind \
      global \
      doxygen \
      clang \
      m4 \
      flex \
      bison \
      gawk \
      texinfo \
      autoconf \
      libtool \
      pkg-config \
      openssl \
      curl \
      libreadline6 \
      zlib1g \
      autoconf \
      automake \
      libtool \
      imagemagick \
      tree \
      libc6 \
      libc6-dev \
      libgmp10 \
      libgmp-dev \
      libncursesw5 \
      libtinfo5

RUN apt-get remove ${OPTS_APT}\
      vim \
      vim-runtime \
      gvim \
      vim-tiny \
      vim-common \
      vim-gui-common

RUN hg clone https://code.google.com/p/vim/ /root/vim
WORKDIR /root/vim
RUN ./configure --with-features=huge \
            --disable-darwin \
            --disable-selinux \
            --enable-luainterp \
##            --enable-perlinterp \
            --enable-pythoninterp \
##            --enable-python3interp \
##            --enable-tclinterp \
##            --enable-rubyinterp \
##           C言語?
##            --enable-cscope \
##         日本語入力に必要らしい   
            --enable-multibyte \
            --enable-xim \
            --enable-fontset\
            --enable-gui=no
##            --enable-gui=gnome2
RUN make
RUN checkinstall \
            --type=debian \
            --install=yes \
            --pkgname="vim" \
            --maintainer="ubuntu-devel-discuss@lists.ubuntu.com" \
            --nodoc \
            --default


RUN echo "Host github.com\n\
  User git\n\
  Port 22\n\
  Hostname github.com\n\
  IdentityFile ~/.ssh/id_rsa_github\n\
  TCPKeepAlive yes\n\
  IdentitiesOnly yes\n" >> /root/.ssh/config


RUN echo "function share_history {\n\
    history -a\n\
    history -c\n\
    history -r\n\
}\n\
PROMPT_COMMAND='share_history'\n\
shopt -u histappend\n\
export HISTSIZE=9999\n" >> /root/.bashrc


ADD dotfiles.sh /root/


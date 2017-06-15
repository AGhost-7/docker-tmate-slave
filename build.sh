#!/usr/bin/env bash

set -e
set -x

apt-get update

apt-get install --no-install-recommends -y \
	git-core \
	build-essential \
	pkg-config \
	libtool \
	libevent-dev \
	libncurses5-dev \
	zlib1g-dev \
	automake \
	cmake \
	ruby \
	curl

# For some reason configure isn't able to find msgpack so install the library manually...
curl -L -o /tmp/msgpack.tar.gz \
	https://github.com/msgpack/msgpack-c/releases/download/cpp-1.3.0/msgpack-1.3.0.tar.gz
tar -xzf /tmp/msgpack.tar.gz -C /tmp
mv /tmp/msgpack-1.3.0 /usr/src/msgpack
cd /usr/src/msgpack
./configure --prefix=/usr
make
make install
cd /
rm -rf /tmp/msgpack.tar.gz

# Install libssh manually as well...
apt-get install -y libssl-dev
git clone --branch=v0-7 --depth=3 https://github.com/nviennot/libssh.git /tmp/libssh
cd /tmp/libssh
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr -DWITH_EXAMPLES=OFF -DWITH_SFTP=OFF ..
make
make install
cd /
rm -rf /tmp/libssh
apt-get purge -y libssl-dev

# And now build the tmate-slave binary.
git clone https://github.com/tmate-io/tmate-slave /tmp/tmate-slave
cd /tmp/tmate-slave
./autogen.sh 
./configure
make
cp ./tmate-slave /usr/local/bin/tmate-slave
cd /
rm -rf /tmp/tmate-slave

# Clean things up to keep the image as small as possible.
apt-get purge -y \
	git-core \
	build-essential \
	pkg-config \
	libtool \
	libevent-dev \
	libncurses5-dev \
	zlib1g-dev \
	automake \
	cmake \
	ruby \
	curl

# Install runtime requirements (don't need *-dev packages since those have extra stuff like
# headers and debug symbols.
apt-get install --no-install-recommends -y \
	libevent-2.0-5 \
	libncurses5 \
	zlib1g \
	openssh-client \
	language-pack-en-base

rm -rf /var/lib/apt/lists/*

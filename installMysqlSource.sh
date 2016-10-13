#!/bin
./configure \
--prefix=/usr/lib/mysql \
--with-mysqld-user=mysql \
--without-debug \
--with-client-ldflags=-all-static \
--with-mysqld-ldflags=-all-static \
--disable-shared \
--localstatedir=/usr/lib/mysql/data \
--with-extra-charsets=none \
--enable-assembler \
--with-unix-socket-path=/tmp/mysql.socket

make
sudo make install

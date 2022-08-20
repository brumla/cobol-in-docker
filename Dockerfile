#
# Build the Alpine Linux GNUCobol environment
# (C) 2022 Brumla
#

FROM alpine:latest

# install the GCC toolchain incl. some additional libs
RUN "apk" "add" "gcc"
RUN "apk" "add" "g++"
RUN "apk" "add" "ncurses-dev" "gmp-dev" "db-dev" "libxml2-dev" "cjson-dev" "flex"
RUN "apk" "add" "gdb"
RUN "apk" "add" "make" "libtool" "automake"

# user tools
RUN "apk" "add" "vim"
RUN "apk" "add" "mc"


# build the GnuCobol 3.1
# 1. working folder
RUN "mkdir" "-p" "source/repos"
WORKDIR /source/repos

# 2. download the archive and unpack
RUN "wget" "https://ftp.gnu.org/gnu/gnucobol/gnucobol-3.1.tar.gz"
RUN "tar" "xzvf" "gnucobol-3.1.tar.gz"

# 3. compile and install
WORKDIR /source/repos/gnucobol-3.1
RUN "./configure"
RUN "make"
RUN "make" "install"
RUN "ldconfig"

# 4. ensure everything is working properly
WORKDIR /source/repos/gnucobol-3.1/tests
RUN "./testsuite"

CMD "/bin/sh"

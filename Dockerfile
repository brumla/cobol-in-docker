#
# Alpine Linux GNUCobol environment
# 
# Copyright 2022 Brumla
# 
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
# 
#        http://www.apache.org/licenses/LICENSE-2.0
# 
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.


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

# only for VSCode Broadcomb Cobol extenstion
# RUN "apk" "add" "openjdk17-jdk"

# build the GnuCobol 3.1
# 1. working folder
RUN "mkdir" "-p" "source/repos"
WORKDIR /source/repos

# 2. download the archive and unpack
RUN "wget" "https://ftp.gnu.org/gnu/gnucobol/gnucobol-3.1.2.tar.gz"
RUN "tar" "xzvf" "gnucobol-3.1.2.tar.gz"

# 3. compile and install
WORKDIR /source/repos/gnucobol-3.1.2
RUN "./configure"
RUN "make"
RUN "make" "install"

WORKDIR /source/repos
RUN "ls"
RUN "rm" "-rf" "gnucobol*"

RUN "adduser" "-D" "app"
USER app
WORKDIR /home/app
RUN "mkdir" "-p" "source/repos"

CMD "/bin/sh"

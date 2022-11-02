FROM ubuntu:latest
RUN apt-get update

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get -y install autotools-dev
RUN apt-get -y install automake
RUN apt-get -y install libtool
RUN apt-get -y install make
RUN apt-get -y install libssl-dev
RUN apt-get -y install libconfig-dev
RUN apt-get -y install git
RUN apt-get -y install telnet
RUN apt-get -y install iproute2
RUN apt-get -y install vim

RUN adduser ubuntu

# Create project folder
RUN mkdir /home/ubuntu/Projects
WORKDIR /home/ubuntu/Projects

# Install odp via github
RUN git clone https://github.91chi.fun//https://github.com/OpenDataPlane/odp.git
RUN cd odp && ./bootstrap && mkdir build && cd build && ../configure CFLAGS='-O0 -ggdb' --enable-debug=full --enable-helper-linux && make -j && make install

# install em-odp via github
RUN git clone https://github.91chi.fun//https://github.com/jianywu/em-odp.git
RUN cd em-odp && ./bootstrap
RUN cd em-odp && mkdir build
RUN cd em-odp && sed -i "s/enable = false/enable = true/" ./config/em-odp.conf
RUN cd em-odp && cat ./config/em-odp.conf
RUN cd em-odp/build && ../configure CFLAGS='-O0 -ggdb' --enable-check-level=3 --with-odp-lib=libodp-linux && make -j && make install

# Run the example program
WORKDIR /home/ubuntu/Projects/em-odp/build/programs/example/hello
ENTRYPOINT ["./hello"]

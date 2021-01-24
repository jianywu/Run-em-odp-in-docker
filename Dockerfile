FROM ubuntu:latest
RUN apt-get update

ENV TZ=Europe/Helsinki
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get install autotools-dev
RUN apt-get -y install automake
RUN apt-get -y install libtool
RUN apt-get -y install make
RUN apt-get -y install libssl-dev
RUN apt-get -y install libconfig-dev
RUN apt-get -y install git

RUN adduser ubuntu

# Create project folder
RUN mkdir /home/ubuntu/Projects
WORKDIR /home/ubuntu/Projects

# Install odp
RUN git clone https://github.com/OpenDataPlane/odp.git
RUN cd odp && ./bootstrap && ./configure && make && make install

# install em-odb
RUN git clone https://github.com/openeventmachine/em-odp.git
RUN cd em-odp && ./bootstrap
RUN cd em-odp && mkdir build
RUN cd em-odp/build && ../configure && make && make install

# Run the example program
WORKDIR /home/ubuntu/Projects/em-odp/build/programs/example/hello
ENTRYPOINT ["./hello"]

FROM debian
RUN apt-get update && apt-get install -y autoconf automake autotools-dev curl python3 libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev git
RUN git clone  https://github.com/riscv/riscv-gnu-toolchain
WORKDIR riscv-gnu-toolchain 
RUN git checkout rvv-0.8.x && git submodule update --init --recursive
RUN ./configure --prefix=/opt/riscv && make linux -j$(nproc)
ENV PATH="/opt/riscv/bin:${PATH}"
ENV RISCV="/opt/riscv"
WORKDIR ..
RUN git clone https://github.com/riscv/riscv-pk.git
WORKDIR riscv-pk/build
RUN ../configure --prefix=$RISCV --host=riscv64-unknown-linux-gnu
RUN make -j8 && make install
WORKDIR ../../
RUN apt install device-tree-compiler
RUN git clone https://github.com/riscv/riscv-isa-sim.git
WORKDIR riscv-isa-sim/build
RUN ../configure --prefix=$RISCV
RUN make -j8 && make install



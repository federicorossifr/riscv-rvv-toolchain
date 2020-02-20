
# Usage guide
Docker images can be obtained through:
```bash
docker pull federicorossir/riscv-rvv-toolchain
```

## Inside-container builds
Run the container as follow to map a project folder from your host inside the container:

```bash
docker run -it -v /path/to/your/project:/home/project federicorossir/riscv-rvv-release bash
```
Binaries are located in /opt/riscv/bin (this is included in the PATH env variable).


## Local builds (binary binding)
Use the following script to bind the binaries in your host machine (you may need to create the folder where you want to mount the files):

```bash
#!/bin/bash
idd=$(id -u)
docker run -v /opt/riscv:/home/project -it federicorossir/riscv-rvv-release sh -c "cp -r /opt/riscv/* /home/project; chown -R $idd:$idd /home/project;"
export PATH="/opt/riscv/bin:$PATH"
```

Compile using:
```bash
riscv64-unknown-linux-gnu-g++ -static -march=rv64gcv program.cpp -o program
```

Execute using:
```bash
spike --isa=RV64GCV /opt/riscv/riscv64-unknown-linux-gnu/bin/pk program
```

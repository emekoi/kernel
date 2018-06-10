# building
you're going to need QEMU to run any of these so i suggest you download that.

## tools
you're also going to need some tools to build some of these. this is how you can get them.

### i686-elf-gcc
```shell
export PREFIX="$HOME/opt/cross"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"

cd $HOME
mkdir -p src/
mkdir -p src/build-binutils
mkdir -p src/build-gcc
cd src
wget ftp://ftp.gnu.org/gnu/binutils/binutils-2.30.tar.xz
wget ftp://ftp.gnu.org/gnu/gcc/gcc-8.1.0/gcc-8.1.0.tar.xz
tar xf binutils-2.30.tar.xz
tar xf gcc-8.1.0.tar.xz

cd build-binutils
../binutils-2.30/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
make
make install

cd ../build-gcc
../gcc-8.1.0/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers
make all-gcc
make all-target-libgcc
make install-gcc
make install-target-libgcc

$HOME/opt/cross/bin/$TARGET-gcc --version

export PATH="$HOME/opt/cross/bin:$PATH"
```

### nake
have a working [nimble](https://github.com/nim-lang/nimble) installation and run `nimble install nake`.

### xargo
have a working [cargo](https://doc.rust-lang.org/cargo/getting-started/installation.html) installation and run `cargo install xargo`.

## c

### required
- nim >= 0.10.2
- i686-elf-gcc
- nake

### build
```shell
nake run
```

## nim

### required
- nim => 0.18.0
- i686-elf-gcc
- nake

### build
```shell
nake run
```

## crystal
### required
### build

## rust
### required
  - xargo
### build

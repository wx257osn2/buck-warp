http_file(
  name = 'warp-linux',
  out = 'warp',
  executable = True,
  urls = [
    'https://github.com/dgiagio/warp/releases/download/v0.3.0/linux-x64.warp-packer',
  ],
  sha256 = 'ba5da4d224077fffea78c7872df47413234e4ee179c941c821aae0b33bd9f594',
)

http_file(
  name = 'warp-windows',
  out = 'warp.exe',
  executable = True,
  urls = [
    'https://github.com/dgiagio/warp/releases/download/v0.3.0/windows-x64.warp-packer.exe',
  ],
  sha256 = '4f9a0f223f0e9f689fc718fdf86a147a357921ffa69c236deadc3274091070c1',
)

http_archive(
  name = 'openjre8-linux',
  out = 'out',
  urls = [
    'https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u265-b01/OpenJDK8U-jre_x64_linux_hotspot_8u265b01.tar.gz',
  ],
  sha256 = '9bce39f63d24626da75778f240294fa466a0ed117e32db798164621fe30b0723',
  strip_prefix = 'jdk8u265-b01-jre',
)

http_archive(
  name = 'openjre8-windows',
  out = 'out',
  urls = [
    'https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u265-b01/OpenJDK8U-jre_x64_windows_hotspot_8u265b01.zip',
  ],
  sha256 = 'ac9b2005c3a2efe6aecbacdb30ceb5a85bdf1a487e112d622af942f1000f4a27',
  strip_prefix = 'jdk8u265-b01-jre',
)

http_file(
  name = 'python2-windows',
  urls = [
    'https://www.python.org/ftp/python/2.7.18/python-2.7.18.amd64.msi',
  ],
  sha256 = 'b74a3afa1e0bf2a6fc566a7b70d15c9bfabba3756fb077797d16fffa27800c05',
)

http_archive(
  name = 'zlib-src',
  out = 'out',
  urls = [
    'https://zlib.net/zlib-1.2.11.tar.xz',
  ],
  sha256 = '4ff941449631ace0d4d203e3483be9dbc9da454084111f97ea0a2114e19bf066',
  strip_prefix = 'zlib-1.2.11',
)

http_archive(
  name = 'python2-src',
  out = 'out',
  urls = [
    'https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tar.xz',
  ],
  sha256 = 'b62c0e7937551d0cc02b8fd5cb0f544f9405bafc9a54d3808ed4594812edef43',
  strip_prefix = 'Python-2.7.18',
)


http_archive(
  name = 'buck-bottle-2020.06.29.01',
  out = 'out',
  type = 'tar.gz',
  urls = [
    'https://github.com/facebook/buck/releases/download/v2020.06.29.01/buck-2020.06.29.01.yosemite.bottle.tar.gz',
  ],
  sha256 = 'c8d295aa5e603d4bd9e4c4fcc99be002b33f6dc9df4169c342f4cd87ffb41fc2',
  strip_prefix = 'buck/2020.06.29.01',
)

genrule(
  name = 'buck-2020.06.29.01-linux',
  out = 'buck-2020.06.29.01-linux',
  executable = True,
  srcs = [
    'buck.sh',
  ],
  cmd = ' && '.join([
    'cd $TMP',
    'mkdir -p bundle',
    'mkdir -p bundle/bin',
    'mkdir -p build',
    'mkdir -p build/zlib',
    'pushd build/zlib',
    '$(location :zlib-src)/configure --prefix="$TMP/zlib"',
    'make install -j',
    'popd',
    'mkdir -p build/python',
    'pushd build/python',
    'C_INCLUDE_PATH="$TMP/zlib/include":$C_INCLUDE_PATH LIBRARY_PATH="$TMP/zlib/lib":$LIBRARY_PATH $(location :python2-src)/configure --prefix="$TMP/python2" --enable-optimizations',
    'make install -j',
    'popd',
    'cp $SRCDIR/buck.sh ./bundle/buck.sh',
    'cp -r $(location :openjre8-linux) ./bundle/jre',
    'cp -r ./python2 ./bundle',
    'cp -r $(location :buck-bottle-2020.06.29.01)/bin/buck ./bundle/bin/buck',
    'chmod +x ./bundle/buck.sh',
    '$(exe :warp-linux) -a linux-x64 -e buck.sh -i ./bundle -o $OUT',
  ]),
)

genrule(
  name = 'buck-2020.06.29.01-windows',
  out = 'buck-2020.06.29.01-windows.exe',
  executable = True,
  srcs = [
    'buck.bat',
  ],
  cmd_exe = ' & '.join([
    'cd $TMP',
    'mkdir bundle',
    'copy /y $SRCDIR\\buck.bat bundle\\buck.bat',
    'mkdir "bundle\\jre"',
    'xcopy /y /e $(location :openjre8-windows) bundle\\jre',
    'mkdir "bundle\\python2"',
    'msiexec /a $(location :python2-windows) targetdir="$TMP\\bundle\\python2" /qn',
    'mkdir "bundle\\bin"',
    'copy /y $(location :buck-bottle-2020.06.29.01)\\bin\\buck bundle\\bin\\buck',
    '$(exe :warp-windows) -a windows-x64 -e buck.bat -i ./bundle -o $OUT',
  ]),
)

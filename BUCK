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

http_archive(
  name = 'python3-windows',
  out = 'out',
  urls = [
    'https://www.python.org/ftp/python/3.8.5/python-3.8.5-embed-amd64.zip',
  ],
  sha256 = 'de59a3544c17dd091c08a6a061fb2660d3bdbd667ed6617b01189a86c18ac2c0',
)

http_archive(
  name = 'libffi-src',
  out = 'out',
  urls = [
    'https://github.com/libffi/libffi/releases/download/v3.3/libffi-3.3.tar.gz',
  ],
  sha256 = '72fba7922703ddfa7a028d513ac15a85c8d54c8d67f55fa5a4802885dc652056',
  strip_prefix = 'libffi-3.3',
)

http_archive(
  name = 'python3-src',
  out = 'out',
  urls = [
    'https://www.python.org/ftp/python/3.8.5/Python-3.8.5.tar.xz',
  ],
  sha256 = 'e3003ed57db17e617acb382b0cade29a248c6026b1bd8aad1f976e9af66a83b0',
  strip_prefix = 'Python-3.8.5',
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
    'mkdir -p build/libffi',
    'pushd build/libffi',
    '$(location :libffi-src)/configure --prefix="$TMP/libffi"',
    'make install -j',
    'popd',
    'mkdir -p build/python',
    'pushd build/python',
    'LIBFFI_INCLUDEDIR=$TMP/libffi/include PKG_CONFIG_PATH=$TMP/libffi/lib/pkgconfig/ LDFLAGS="-L $TMP/libffi/lib/" $(location :python3-src)/configure --prefix="$TMP/python3" --enable-optimizations',
    'make install -j',
    'popd',
    'cp $SRCDIR/buck.sh ./bundle/buck.sh',
    'cp -r $(location :openjre8-linux) ./bundle/jre',
    'cp -r ./python3 ./bundle',
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
    'python38._pth',
  ],
  cmd_exe = ' & '.join([
    'cd $TMP',
    'mkdir bundle',
    'copy /y $SRCDIR\\buck.bat bundle\\buck.bat',
    'mkdir "bundle\\jre"',
    'xcopy /y /e $(location :openjre8-windows) bundle\\jre',
    'mkdir "bundle\\python3"',
    'xcopy /y /e $(location :python3-windows) bundle\\python3',
    'copy /y "$SRCDIR\\python38._pth" bundle\\python3\\',
    'mkdir "bundle\\bin"',
    'copy /y $(location :buck-bottle-2020.06.29.01)\\bin\\buck bundle\\bin\\buck',
    '$(exe :warp-windows) -a windows-x64 -e buck.bat -i ./bundle -o $OUT',
  ]),
)

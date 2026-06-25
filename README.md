# homebrew-ffmpeg for Seek-One

A customized version of ffmpeg build with the following options :
- LGPL
- openh264
- drawtext
- fribidi
- freetype
- ass

Avaliable options : 

```
  --with-fdk-aac: Enable the Fraunhofer FDK AAC library"
  --with-ass: Enable ASS library"
  --with-freetype: Enable freetype library"
  --with-harfbuzz: Enable harfbuzz library"
  --with-openh264: Enable OpenH264 library"
  --with-x264: Enable x264 library"
  --with-x265: Enable x265 library"
  --with-vpx: Enable x265 library"
```

Usage :

```
brew tap seek-one/ffmpeg
brew options seek-one/ffmpeg/ffmpeg
brew install seek-one/ffmpeg/ffmpeg --with-fdk-aac --with-libass --with-freetype --with-harfbuzz --with-openh264 --with-libvpx
```

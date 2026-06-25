class Ffmpeg < Formula
  desc "Play, record, convert, and stream audio and video"
  homepage "https://ffmpeg.org/"
  url "https://ffmpeg.org/releases/ffmpeg-8.1.2.tar.xz"
  sha256 "464beb5e7bf0c311e68b45ae2f04e9cc2af88851abb4082231742a74d97b524c"
  license "GPL-2.0-or-later"
  head "https://github.com/FFmpeg/FFmpeg.git", branch: "master"

  option "with-fdk-aac", "Enable the Fraunhofer FDK AAC library"
  option "with-libass", "Enable libass library"
  option "with-freetype", "Enable freetype library"
  option "with-harfbuzz", "Enable harfbuzz library"
  option "with-openh264", "Enable OpenH264 library"
  option "with-x264", "Enable x264 library"
  option "with-x265", "Enable x265 library"
  option "with-libvpx", "Enable libvpx library"

  depends_on "pkgconf" => :build

  depends_on "fdk-aac" => :optional
  depends_on "libass" => :optional
  depends_on "freetype" => :optional
  depends_on "harfbuzz" => :optional
  depends_on "openh264" => :optional
  depends_on "x264" => :optional
  depends_on "x265" => :optional
  depends_on "libvpx" => :optional

  uses_from_macos "zlib"

  on_intel do
    depends_on "nasm" => :build
  end

  fails_with gcc: "5"

  def install
    args = %W[
      --prefix=#{prefix}
      --enable-shared
      --cc=#{ENV.cc}
      --host-cflags=#{ENV.cflags}
      --host-ldflags=#{ENV.ldflags}
      --enable-libfontconfig
      --disable-mediafoundation
    ]

    args << "--enable-neon" if Hardware::CPU.arm?

    args << "--disable-htmlpages" # The same info is accessible through the man pages.
    args << "--enable-libfdk-aac" if build.with? "fdk-aac"
    args << "--enable-libass" if build.with? "libass"
    args << "--enable-libfreetype --enable-zlib --extra-libs=-lpng" if build.with? "freetype"
    args << "--enable-libharfbuzz" if build.with? "harfbuzz"
    args << "--enable-libopenh264" if build.with? "openh264"
    args << "--enable-libx264" if build.with? "x264"
    args << "--enable-libx265" if build.with? "x265"
    args << "--enable-libvpx" if build.with? "libvpx"

    system "./configure", *args
    if build.with? "alt-name"
      system "make"
      bin.install "ffmpeg" => "ffmpeg-alt"
      bin.install "ffprobe" => "ffprobe-alt"
      bin.install "ffplay" => "ffplay-alt"
    else
      system "make", "install"
    end
  end
end

require 'formula'

class CairoQuartz < Formula
  homepage 'http://cairographics.org/'
  #url 'http://www.cairographics.org/releases/cairo-1.10.2.tar.gz'
  #sha1 'ccce5ae03f99c505db97c286a0c9a90a926d3c6e'
  url "http://www.cairographics.org/releases/cairo-1.14.0.tar.xz"
  #sha1 "4f6e337d5d3edd7ea79d1426f575331552b003ec" 
  #depends_on :x11
  depends_on 'pkg-config' => :build
  depends_on 'freetype'
  depends_on 'fontconfig'
  depends_on 'libpng'
  depends_on 'pixman'
  depends_on 'glib'

  keg_only 'This formula builds Cairo for use with Quartz instead of X11, which is experimental.'

  fails_with_llvm 'Gives an LLVM ERROR with Xcode 4 on some CPUs', :build => 2334

  def install
    #ENV.x11
    system './configure', "--prefix=#{prefix}",
                          '--disable-dependency-tracking',
                          '--enable-quartz', '--enable-quartz-font', '--enable-quartz-image',
                         # '--enable-ft', 
                           '--disable-xlib', '--without-x',"--enable-xlib=no",  "--enable-xlib-xrender=no"

    system 'make install'
  end
end

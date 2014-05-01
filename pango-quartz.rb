require 'formula'

class PangoQuartz < Formula
  homepage 'http://www.pango.org/'
  #url 'http://ftp.gnome.org/pub/GNOME/sources/pango/1.28/pango-1.28.4.tar.bz2'
  #sha256 '7eb035bcc10dd01569a214d5e2bc3437de95d9ac1cfa9f50035a687c45f05a9f'
  url 'http://ftp.gnome.org/pub/GNOME/sources/pango/1.36/pango-1.36.3.tar.xz'
  sha256 'ad48e32917f94aa9d507486d44366e59355fcfd46ef86d119ddcba566ada5d22'
  #depends_on :x11
  depends_on 'pkg-config' => :build
  depends_on 'glib'
  depends_on 'fontconfig' if MacOS.leopard? # Leopard's fontconfig is too old.
  depends_on 'gobject-introspection'
  #depends_on '3togo/quartz/cairo-quartz'
  depends_on 'cairo-quartz'
  keg_only 'This formula builds Pango for use with Quartz instead of X11, which is experimental.'

  fails_with_llvm 'Undefined symbols when linking', :build => '2326'

  def install
    #ENV.x11
    system './configure', "--prefix=#{prefix}", '--without-x', '--disable-introspection', '--without-xft' 
    system 'make install'
  end
end

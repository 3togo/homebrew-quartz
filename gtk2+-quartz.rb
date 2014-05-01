require 'formula'

class Gtk2xQuartz < Formula
  homepage 'http://www.gtk.org/'
  #url 'http://ftp.gnome.org/pub/gnome/sources/gtk+/2.24/gtk+-2.24.23.tar.xz'
  #sha256 'a0a406e27e9b5e7d6b2c4334212706ed5cdcd41e713e66c9ae950655dd61517c'
  url 'http://ftp.acc.umu.se/pub/gnome/sources/gtk+/2.11/gtk+-2.11.6.tar.bz2'  #compile error
  #url 'http://ftp.acc.umu.se/pub/gnome/sources/gtk+/2.12/gtk+-2.12.12.tar.bz2'
  #url 'http://ftp.acc.umu.se/pub/gnome/sources/gtk+/2.13/gtk+-2.13.7.tar.bz2'
  #url 'http://ftp.acc.umu.se/pub/gnome/sources/gtk+/2.14/gtk+-2.14.7.tar.bz2'
  #url 'http://ftp.acc.umu.se/pub/gnome/sources/gtk+/2.15/gtk+-2.15.5.tar.bz2'
  #url 'http://ftp.acc.umu.se/pub/gnome/sources/gtk+/2.20/gtk+-2.20.1.tar.bz2'
  #sha256 'da202af5b91c6243944e6b8c48872de10a4e86ba0e2b87456a4a8fa56ceb6ae8'
  depends_on 'pkg-config' => :build
  depends_on 'glib'
  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'gdk-pixbuf'
  depends_on 'jasper' => :optional
  depends_on 'atk'

  depends_on 'pango-quartz'
  depends_on 'cairo-quartz'
  keg_only 'This formula builds Gtk+ for use with Quartz instead of X11, which is experimental.'

  fails_with_llvm 'Undefined symbols when linking', :build => '2326' unless MacOS.lion?
  #git hash-object ~/Downloads/gtkclipboard-quartz.patch 
   
  #patch :p0 do 
  #  url 'https://raw.githubusercontent.com/3togo/homebrew-quartz/master/reverse-gtkclipboard-quartz.patch'
  #  sha256 "3bd568b2a7dc20500c2e10eb55d7b46b742f26d3a26333f8d24d2223819a2c0d"
  #end   
  
  #patch :p0 do 
  #  url 'https://raw.githubusercontent.com/3togo/homebrew-quartz/master/gtkclipboard-quartz-jc.patch'
  #  sha256 "627623f1162b0aa5bec474c76bb17b541cc796c430b1623e2a90c875d0e4469b"
  #end   
   
  def configure_install
  
    ENV.append 'LDFLAGS', '-framework Carbon -framework Cocoa'
    # gtk-update-icon-cache is used during installation, and
    # we don't want to add a dependency on gtk+2 just for this.
    #inreplace %w[ gtk/makefile.msc.in
    #              demos/gtk-demo/Makefile.in
    #              demos/widget-factory/Makefile.in ],
    #              /gtk-update-icon-cache --(force|ignore-theme-index)/,
    #              "#{buildpath}/gtk/\\0"

    system './configure', "--prefix=#{prefix}",
                          '--disable-debug', '--disable-dependency-tracking',
                          '--disable-glibtest', 
                          '--with-gdktarget=quartz', 
                          '--disable-introspection',
                          '--enable-quartz-backend'

    system 'make install'
  end
  def install
    configure_install
  end
  #def test
  #  system '#{bin}/gtk-demo'
  #end
end

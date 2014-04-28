require 'formula'

class GtkxQuartz < Formula
  homepage 'http://www.gtk.org/'
 # url 'http://ftp.gnome.org/pub/gnome/sources/gtk+/2.24/gtk+-2.24.23.tar.xz'
 # sha256 'a0a406e27e9b5e7d6b2c4334212706ed5cdcd41e713e66c9ae950655dd61517c'
  url 'http://ftp.gnome.org/pub/GNOME/sources/gtk+/3.12/gtk+-3.12.1.tar.xz'
  sha256 '719aae5fdb560f64cadb7e968c8c85c0823664de890c9f765ff4c0efeb0277cd'
  depends_on 'pkg-config' => :build
  depends_on 'glib'
  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'gdk-pixbuf'
  depends_on 'jasper' => :optional
  depends_on 'atk'

  depends_on '3togo/quartz/pango-quartz'
  depends_on '3togo/quartz/cairo-quartz'
  keg_only 'This formula builds Gtk+ for use with Quartz instead of X11, which is experimental.'

  fails_with_llvm 'Undefined symbols when linking', :build => '2326' unless MacOS.lion?

  def install
    ENV.append 'LDFLAGS', '-framework Carbon -framework Cocoa'
    # gtk-update-icon-cache is used during installation, and
    # we don't want to add a dependency on gtk+2 just for this.
    inreplace %w[ gtk/makefile.msc.in
                  demos/gtk-demo/Makefile.in
                  demos/widget-factory/Makefile.in ],
                  /gtk-update-icon-cache --(force|ignore-theme-index)/,
                  "#{buildpath}/gtk/\\0"

    system './configure', "--prefix=#{prefix}",
                          '--disable-debug', '--disable-dependency-tracking',
                          '--disable-glibtest', 
                          '--with-gdktarget=quartz', 
                          '--disable-introspection',
                          '--enable-quartz-backend'

    system 'make install'
  end

  #def test
  #  system '#{bin}/gtk-demo'
  #end
end

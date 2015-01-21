require 'formula'

class GtkxQuartz < Formula
  homepage 'http://www.gtk.org/'
 
  url 'http://ftp.acc.umu.se/pub/GNOME/sources/gtk+/3.14/gtk+-3.14.7.tar.xz'
  #sha1 'b3bd754863325f963e5539fb8fbf3c4303b8bdc7'
  #url 'http://ftp.acc.umu.se/pub/GNOME/sources/gtk+/3.15/gtk+-3.15.4.tar.xz'
  #sha1 '3f5ea41a11b1705221e9d773fc03b845bade743e'
  depends_on 'pkg-config' => :build
  depends_on 'glib'
  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'gdk-pixbuf'
  depends_on 'jasper' => :optional
  depends_on 'atk'

  depends_on 'pango-quartz'
  #depends_on 'cairo-quartz'
  keg_only 'This formula builds Gtk+ for use with Quartz instead of X11, which is experimental.'

  fails_with_llvm 'Undefined symbols when linking', :build => '2326' unless MacOS.lion?
  #patch :p1 do 
  #  url 'https://raw.githubusercontent.com/3togo/homebrew-quartz/master/gtkapplication-quartz-menu-3.13.1.patch'
  #  sha256 "5e907c6b135b710a97882a6310fe347098f6c2928f30d5f6e59e2889969acd4f"
  #end   
  
  def configure_install
    ENV.append 'LDFLAGS', '-framework Carbon -framework Cocoa'
    # gtk-update-icon-cache is used during installation, and
    # we don't want to add a dependency on gtk+2 just for this.
    inreplace %w[ gtk/makefile.msc.in
                   ],
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
  def install
	configure_install
  end
  #def test
  #  system '#{bin}/gtk-demo'
  #end
end

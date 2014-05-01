require 'formula'

class GeanyQuartz < Formula
  homepage 'http://geany.org/'
  url 'http://download.geany.org/geany-1.24.1.tar.gz'
  sha1 '2707b6bbcc4710e3dca990d26f66d679d82a2cc0'

  #depends_on :x11
  depends_on 'pkg-config' => :build
  depends_on 'intltool' => :build
  depends_on 'gettext'
  depends_on 'gtk+-quartz'
  depends_on 'hicolor-icon-theme'
  def setVersion
	gtkVersion=`$HOMEBREW_PREFIX/bin/pkg-config --modversion gtk+-3.0`.strip!
    brewVersion=`$HOMEBREW_PREFIX/bin/brew --version`.strip!
    strVersion=sprintf("[Hombrew-Quartz Version %s(GTK V %s)] built by FreeToGo.",brewVersion,gtkVersion)
    print brewVersion
    print gtkVersion
    print strVersion
    sedStr="sed -i -e 's|This is Geany %s|This is Geany %s #{strVersion}|g' src/main.c"                                         
    system sedStr
  end  
  
  def configure_install
	system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--enable-gtk3",
                          "--disable-debug"
                          #"--enable-debug",
                          #"--enable-introspection=yes"
    system "make install"
  end
  
  def install
		setVersion
		configure_install
  end
end

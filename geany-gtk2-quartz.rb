require 'formula'

class GeanyGtk2Quartz < Formula
  gtkVersion="1.24.1"
  homepage 'http://geany.org/'
  url 'http://download.geany.org/geany-'+gtkVersion+'.tar.gz'
  sha1 '2707b6bbcc4710e3dca990d26f66d679d82a2cc0'
  
  #depends_on :x11
  depends_on 'pkg-config' => :build
  depends_on 'intltool' => :build
  depends_on 'gettext'
  #depends_on '3togo/quartz/gtk2+-quartz'
  depends_on "gtk2+-quartz"
  depends_on 'hicolor-icon-theme'
  
  def install
    #sedStr="sed -i -e 's|GEANY_STATUS_ADD|AC_SUBST([GTK_VERSION])\
#GEANY_STATUS_ADD|g' configure.ac"                                       
    #system sedStr
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          #"--enable-gtk3",
                          "--disable-debug"
                          #"--enable-debug",
                          #"--enable-introspection=yes"
                          
    gtkVersion=`$HOMEBREW_PREFIX/bin/pkg-config --modversion gtk+-2.0`.strip!
    brewVersion=`$HOMEBREW_PREFIX/bin/brew --version`.strip!
    strVersion=sprintf("[Hombrew-Quartz Version %s(GTK V %s)] built by FreeToGo.",brewVersion,gtkVersion)
    print brewVersion
    print gtkVersion
    print strVersion
    sedStr="sed -i -e 's|This is Geany %s|This is Geany %s #{strVersion}|g' src/main.c"                                         
    system sedStr
    
    system "make install"
  end
end



require 'formula'

class Libaacplus < Formula
  homepage 'http://tipok.org.ua/node/17'
  url 'http://tipok.org.ua/downloads/media/aacplus/libaacplus/libaacplus-2.0.2.tar.gz'
  sha256 '60dceb64d4ecf0be8d21661d5af2f214710f9d5b6ab389a5bdebf746baa7e1d7'

  depends_on 'autoconf' => :build
  depends_on 'automake' => :build
  depends_on 'libtool' => :build

  def patches
      # configure.ac:8: error: 'AM_CONFIG_HEADER': this macro is obsolete. You should use the 'AC_CONFIG_HEADERS' macro instead.
      DATA
    end

  def install
    ENV.llvm if MacOS.xcode_version >= "4.2" # This fields contains dirty hack
    ENV.gcc if MacOS.xcode_version < "4.2"   # to provide ability install aacplus library
    ENV.deparallelize
    inreplace 'autogen.sh', 'libtool', 'glibtool'
    system "./autogen.sh", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--disable-libtool-lock"
    inreplace "Makefile", "distdir = $(PACKAGE)-$(VERSION)", "distdir = #{pwd}"
    system "make"
    system "make install"
  end
end

__END__
--- a/configure.ac	2013-02-16 02:03:59.000000000 +0400
+++ b/configure.ac	2013-02-16 02:04:10.000000000 +0400
@@ -5,7 +5,7 @@
 #AM_INIT_AUTOMAKE([dist-bzip2])
 AM_INIT_AUTOMAKE
 
-AM_CONFIG_HEADER(config.h)
+AC_CONFIG_HEADERS(config.h)
 AC_CONFIG_MACRO_DIR([m4])
 # Checks for programs.
 AC_PROG_CC
--- a/Makefile.am 2010-11-10 13:27:45.000000000 -0800
+++ b/Makefile.am.new 2013-10-30 11:21:58.000000000 -0700
@@ -1,5 +1,5 @@

-SUBDIRS = src include patches frontend
+SUBDIRS = src include patches

 if HAVE_PKGCONFIG
     pkgconfigdir = $(libdir)/pkgconfig

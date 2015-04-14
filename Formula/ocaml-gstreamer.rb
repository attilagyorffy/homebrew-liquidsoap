require 'formula'

class OcamlGstreamer < Formula
  homepage 'http://liquidsoap.fm/'
  url 'http://downloads.sourceforge.net/project/savonet/ocaml-gstreamer/0.2.0/ocaml-gstreamer-0.2.0.tar.gz'
  sha256 '256f4345da338148d510dbe57a3888624d5248ff8239124b5aacf3648ca0f9d7'

  depends_on 'objective-caml' => :build
  depends_on 'ocaml-findlib' => :build
  depends_on 'gstreamer' => :build
  depends_on 'pkg-config' => :build
  depends_on 'gst-plugins-base' => :build

  def install
    ENV.j1
    ENV.append "OCAMLPATH", "#{HOMEBREW_PREFIX}/lib/ocaml/site-lib"
    ENV.append "OCAMLFIND_DESTDIR", "#{lib}/ocaml/site-lib"
    ENV["PKG_CONFIG_LIBDIR"] = "/usr/local/lib/pkgconfig:#{ENV["PKG_CONFIG_LIBDIR"]}"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    mkdir_p "#{lib}/ocaml/site-lib"
    system "make install OCAMLFIND_LDCONF=ignore"
    Dir.glob("#{lib}/ocaml/site-lib/**/*stubs.so").each { |so| mkdir_p "#{lib}/ocaml/stublibs"; mv so, "#{lib}/ocaml/stublibs/" }
  end
end

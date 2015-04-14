require 'formula'

class OcamlSchroedinger < Formula
  homepage 'http://liquidsoap.fm/'
  url 'http://downloads.sourceforge.net/project/savonet/ocaml-schroedinger/0.1.0/ocaml-schroedinger-0.1.0.tar.gz'
  sha256 '23e721cb494c1a40f59fee4757a642c92fdfd30e5dcd6e9965c320acb426c3ee'

  depends_on 'objective-caml' => :build
  depends_on 'ocaml-findlib' => :build
  depends_on 'schroedinger' => :build
  depends_on 'pkg-config' => :build
  depends_on 'ocaml-ogg' => :build

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

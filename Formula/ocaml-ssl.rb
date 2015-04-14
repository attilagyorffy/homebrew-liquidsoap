require 'formula'

class OcamlSsl < Formula
  homepage 'http://liquidsoap.fm/'
  url 'http://downloads.sourceforge.net/project/savonet/ocaml-ssl/0.4.6/ocaml-ssl-0.4.6.tar.gz'
  sha256 '1ff7fbc77bb5ec7b6bfdca045c6c7a51d4d98ed60a865f29e06dd91285ac9499'

  depends_on 'objective-caml' => :build
  depends_on 'ocaml-findlib' => :build
  depends_on 'openssl' => :build

  def install
    ENV.llvm if MacOS.xcode_version >= "4.2"
    ENV.gcc if MacOS.xcode_version < "4.2"
    ENV.j1
    ENV.append "OCAMLPATH", "#{HOMEBREW_PREFIX}/lib/ocaml/site-lib"
    ENV.append "OCAMLFIND_DESTDIR", "#{lib}/ocaml/site-lib"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    mkdir_p "#{lib}/ocaml/site-lib"
    system "make install OCAMLFIND_LDCONF=ignore"
    Dir.glob("#{lib}/ocaml/site-lib/**/*.so").each { |so| mkdir_p "#{lib}/ocaml/stublibs"; mv so, "#{lib}/ocaml/stublibs/" }
  end
end


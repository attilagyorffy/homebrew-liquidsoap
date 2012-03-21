require 'formula'

class Xmlm < Formula
  homepage 'http://erratique.ch/software/xmlm'
  url 'http://erratique.ch/software/xmlm/releases/xmlm-1.1.0.tbz'
  md5 '443bb4e06ee5f88bbd2bafd5641f903d'

  depends_on 'objective-caml' => :build
  depends_on 'ocaml-findlib'

  def install
    ENV['OCAMLFIND_DESTDIR'] = "#{lib}/ocaml/site-lib"
    system "ocaml", "setup.ml", "-configure", "--prefix", "#{prefix}"
    system "ocaml", "setup.ml", "-build"
    mkdir_p "#{lib}/ocaml/site-lib"
    system "ocaml", "setup.ml", "-install"
  end
end

require 'formula'

class OMake < Formula
  url 'http://omake.metaprl.org/downloads/omake-0.9.8.6-0.rc1.tar.gz'
  homepage 'http://omake.metaprl.org/'
  sha1 'e78c9d8858749f5e234cba303637980e24085cbc'

  depends_on 'objective-caml'

  def patches
    # removes reference to missing caml_sync in OS X OCaml
    DATA
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end
end

__END__
diff --git a/src/exec/omake_exec.ml b/src/exec/omake_exec.ml
index 8c034b5..7e40b35 100644
--- a/src/exec/omake_exec.ml
+++ b/src/exec/omake_exec.ml
@@ -46,8 +46,6 @@ open Omake_exec_notify
 open Omake_options
 open Omake_command_type
 
-external sync : unit -> unit = "caml_sync"
-
 module Exec =
 struct
    (*
diff --git a/OMakefile b/OMakefile
index 9b77a25..1d61d70 100644
--- a/OMakefile
+++ b/OMakefile
@@ -57,7 +57,7 @@ if $(not $(defined CAMLLIB))
 #
 # OCaml options
 #
-OCAMLFLAGS[] += -w Ae$(if $(OCAML_ACCEPTS_Z_WARNING), z)
+OCAMLFLAGS[] += -w Ae$(if $(OCAML_ACCEPTS_Z_WARNING), z)-9-27..29
 if $(THREADS_ENABLED)
     OCAMLFLAGS += -thread
     export
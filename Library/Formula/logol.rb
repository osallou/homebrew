require "formula"

# Documentation: https://github.com/Homebrew/homebrew/wiki/Formula-Cookbook
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Logol < Formula
  homepage "http://logol.genouest.org"
  url "https://gforge.inria.fr/frs/download.php/33588/logol_1.7.1.orig.tar.bz2"
  sha1 "42b7393985366104db555c034d8975a2feaf71ef"

   depends_on "ant" => :build
   depends_on "cassiopee"
   depends_on "swi-prolog"
   depends_on "coreutils"

  def install
    opoo "Ruby gem *cassiopee* is required, it requires sudo priviledges, installing..."
    system "sudo", "gem", "install", "cassiopee"
    system "ant", "setup"
    system "ant", "compile_swi_exe"
    system "ant", "create-jar"
    inreplace "LogolExec.sh" do |s|
        s.gsub! /readlink/, "greadlink"
    end
    inreplace "LogolMultiExec.sh" do |s|
        s.gsub! /readlink/, "greadlink"
    end
    system "ant", "-Dtarget.dir=#{prefix}", "deploy"
  end

  test do
    system "ant", "test_swi"
  end
end

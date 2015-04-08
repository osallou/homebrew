require "formula"

# Documentation: https://github.com/Homebrew/homebrew/wiki/Formula-Cookbook
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Logol < Formula
  homepage "http://logol.genouest.org"
  url "https://gforge.inria.fr/frs/download.php/33588/logol_1.7.2.orig.tar.bz2"
  version "1.7.2"
  sha256 "7c55105fe81336d6d9c238ad15b4d8d500c9a21d6e71ae4dcdb475a4cbd0e4c4"

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

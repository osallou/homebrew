require 'formula'

class Cassiopee < Formula
  homepage 'http://osallou.github.io/cassiopee-c/'
  url "https://github.com/osallou/cassiopee-c/archive/1.0.3.tar.gz"
  version "1.0.3"
  sha256 "a0cf78a3bc0d99d046ac0af5e7e486105af27a203a79ee673aa14de478943394"

  depends_on 'cmake' => :build
  depends_on 'boost'
  depends_on 'glog'
  depends_on 'cppunit' => :build
  depends_on 'doxygen' => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make"
    system "make install"
  end

  def test
    system "bin/test_cassiopee"
  end
end

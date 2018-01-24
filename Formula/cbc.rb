class Cbc < Formula
  homepage 'https://projects.coin-or.org/Cbc'
  url 'http://www.coin-or.org/download/source/Cbc/Cbc-2.9.7.tgz'
  sha256 '637d080d381e620888d032cba28a3f1f8199f3b5619a3b763aa1470fda543817'

  def install
    # build without lapack until Julia issue 4923 is resolved
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--without-lapack",
                          "--enable-cbc-parallel"
    system "make"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"

  end
end

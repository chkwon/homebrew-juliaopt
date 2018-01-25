class Ipopt < Formula
  homepage 'https://projects.coin-or.org/Ipopt'
  url 'http://www.coin-or.org/download/source/Ipopt/Ipopt-3.12.8.tgz'
  sha256 '62c6de314220851b8f4d6898b9ae8cf0a8f1e96b68429be1161f8550bb7ddb03'
  revision 1

 bottle do
   root_url 'https://dl.bintray.com/chkwon/juliaopt'
   cellar :any
   rebuild 3
   sha256 "899ed068cc3db0833740cb7c2150a4d98141628977cd943308a99e46242d9165" => :high_sierra
 end

  # depends_on "gcc" if ARGV.build_bottle?
  depends_on "gcc"

  def install
    system "cd ThirdParty/Mumps; sed -i '' 's/wgetcmd=ftp/wgetcmd=\"curl -L -k -O\"/g' get.Mumps; ./get.Mumps"
    system "cd ThirdParty/Blas; ./get.Blas"
    system "cd ThirdParty/Blas; ./configure --prefix=#{prefix} --disable-shared --with-pic; make install"
    system "cd ThirdParty/Lapack; ./get.Lapack"
    system "cd ThirdParty/Lapack; ./configure --prefix=#{prefix} --disable-shared --with-pic; make install"
    system "cd ThirdParty/ASL; ./get.ASL"
    system "./configure", "--disable-dependency-tracking",
                          "--with-blas=#{prefix}/lib/libcoinblas.a",
                          "--with-lapack=#{prefix}/lib/libcoinlapack.a",
                          "--prefix=#{prefix}"
    system "make"
    system "make test"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end

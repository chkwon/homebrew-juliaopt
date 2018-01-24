class Ipopt < Formula
  homepage 'https://projects.coin-or.org/Ipopt'
  url 'http://www.coin-or.org/download/source/Ipopt/Ipopt-3.12.8.tgz'
  sha256 '62c6de314220851b8f4d6898b9ae8cf0a8f1e96b68429be1161f8550bb7ddb03'
  revision 1

 #  bottle do
 #    root_url 'https://juliabottles.s3.amazonaws.com'
 #    cellar :any
 #    rebuild 2
 #    sha256 "212196e3838345ed1e16c962514ddaf32c2e5a822f797f2af9b05cb130ec3d7a" => :sierra
 #    sha256 "2d240f0c450c65ea0555844e117d8f10a1f565f8b732538dc023fe50404d7d71" => :el_capitan
 #    sha256 "33c266d3fb148cb96a381baeee7d5edd368891cda1bd935da1e9f98c235efced" => :yosemite
 # end

 bottle do
   root_url 'https://github.com/chkwon/homebrew-juliaopt/releases/download/v3.12.8'
   cellar :any
   rebuild 3
   sha256 "899ed068cc3db0833740cb7c2150a4d98141628977cd943308a99e46242d9165" => :high_sierra
 end


  # Need this snippet in every formula that has a runtime dependency on libgfortran
  def post_install
    fixup_libgfortran prefix
  end

  # Need to enable this when building the bottle, disable it when installing from bottles
  depends_on "gcc" if ARGV.build_bottle?

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

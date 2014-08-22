# Copyright 2014 Artem Butusov
# Distributed under the terms of the GNU General Public License v2
# Author: Artem Butusov <arе.sormy@gmail.com>

EAPI=5

inherit eutils

DESCRIPTION="Convert html to pdf (and various image formats) using webkit"
HOMEPAGE="http://wkhtmltopdf.org"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${PN/pdf/x}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="examples doc"

DEPEND="dev-lang/python
	media-libs/fontconfig
	media-libs/freetype
	sys-libs/zlib
	virtual/jpeg:0
	media-libs/libpng:0=
	dev-libs/openssl
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender"

S="${WORKDIR}/${PN/pdf/x}-${PV}"

src_configure() {
	sed -e "s/shell('tar -c -v -f/#\0/" \
		-e "s/shell('xz --compress --force --verbose -9/#\0/" \
		-i ./scripts/build.py || die "Unable to disable tar.xz in build script"
}

src_compile() {
	./scripts/build.py posix-local
}

src_install() {
	local build_dir=./static-build/posix-local/${PN/pdf/x}-${PV}
	dobin ${build_dir}/bin/*
	doheader -r ${build_dir}/include
	dolib.so ${build_dir}/lib/*
	use examples && dodoc -r examples
	use doc && dodoc README.md CHANGELOG-OLD CHANGELOG.md AUTHORS VERSION COPYING
}

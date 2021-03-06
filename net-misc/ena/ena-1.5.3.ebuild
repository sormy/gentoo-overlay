# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-info linux-mod eutils

DESCRIPTION="Amazon EC2 Elastic Network Adapter (ENA) kernel driver"
HOMEPAGE="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/enhanced-networking-ena.html"
SRC_URI="https://github.com/amzn/amzn-drivers/archive/ena_linux_${PV}.zip -> ${P}-linux.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

S="${WORKDIR}/amzn-drivers-ena_linux_${PV}/kernel/linux/ena"

MODULE_NAMES="ena(net:${S}:${S})"
BUILD_TARGETS="all"

pkg_setup() {
    linux-mod_pkg_setup
    BUILD_PARAMS="CONFIG_MODULE_SIG=n"
}

src_install() {
    linux-mod_src_install
    dodoc README RELEASENOTES.md COPYING
}

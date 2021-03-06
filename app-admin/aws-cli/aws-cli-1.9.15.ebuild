# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Universal Command Line Interface for Amazon Web Services"
HOMEPAGE="https://github.com/aws/aws-cli"
SRC_URI="https://github.com/aws/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="=dev-python/botocore-1.3.15[${PYTHON_USEDEP}]
	>=dev-python/colorama-0.2.5[${PYTHON_USEDEP}]
	<=dev-python/colorama-0.3.3[${PYTHON_USEDEP}]
	>=dev-python/docutils-0.10[${PYTHON_USEDEP}]
	>=dev-python/rsa-3.1.2[${PYTHON_USEDEP}]
	<=dev-python/rsa-3.3.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
	)"

src_prepare() {
	# Unbundled in dev-python/botocore
	grep -rl 'botocore.vendored' | xargs \
		sed -i -e "/import requests/s/from botocore.vendored //" \
		-e "/^from/s/botocore\.vendored\.//" \
		-e "s/^from botocore\.vendored //" \
		-e "s/'botocore\.vendored\./'/" \
		|| die "sed failed"
}

python_test() {
	# Only run unit tests
	nosetests tests/unit || die "Tests fail with ${EPYTHON}"
}

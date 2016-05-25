# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="Universal Command Line Interface for Amazon Web Services"
HOMEPAGE="https://github.com/aws/aws-cli"
SRC_URI="https://github.com/aws/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="=dev-python/botocore-1.4.23[${PYTHON_USEDEP}]
	>=dev-python/colorama-0.2.5[${PYTHON_USEDEP}]
	<=dev-python/colorama-0.3.3[${PYTHON_USEDEP}]
	>=dev-python/docutils-0.10[${PYTHON_USEDEP}]
	>=dev-python/rsa-3.1.2[${PYTHON_USEDEP}]
	<=dev-python/rsa-3.5.0[${PYTHON_USEDEP}]
	=dev-python/s3transfer-0.0.1[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
	)"

python_test() {
	# Only run unit tests
	nosetests tests/unit || die "Tests fail with ${EPYTHON}"
}

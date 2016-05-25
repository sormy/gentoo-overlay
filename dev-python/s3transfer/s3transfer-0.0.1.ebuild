# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="An Amazon S3 Transfer Manager for Python"
HOMEPAGE="https://github.com/boto/${PN}"
SRC_URI="https://github.com/boto/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-python/botocore-1.3.0[${PYTHON_USEDEP}]
	<dev-python/botocore-2.0.0[${PYTHON_USEDEP}]
	virtual/python-futures[${PYTHON_USEDEP}]"
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

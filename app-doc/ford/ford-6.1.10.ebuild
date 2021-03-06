# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 toolchain-funcs

MY_PN="FORD"
DESCRIPTION="FORD, automatic documentation generator for modern Fortran programs"
HOMEPAGE="https://github.com/Fortran-FOSS-Programmers/ford"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

S="${WORKDIR}/${MY_PN}-${PV}"

RDEPEND="
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/graphviz[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/markdown[${PYTHON_USEDEP}]
	dev-python/markdown-include[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/python-markdown-math[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/toposort[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

DOCS=( CHANGELOG.md README.md README.rst )

distutils_enable_tests pytest

src_prepare() {
	default
	sed -i -e 's/"cpp /"'"$(tc-getCPP)"' /' ford/__init__.py || die # bug: 839300
}

python_test(){
	# The 'test/test_projects' tests use subprocess, i.e. require FORD to be installed.
	distutils_install_for_testing
	distutils-r1_python_test
}

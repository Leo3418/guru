# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://c9x.me/qbe.git"
else
	SRC_URI="https://c9x.me/compile/release/${P}.tar.xz"
	# 64-bit RISC-V only
	KEYWORDS="~amd64 ~arm64 ~riscv"
fi

DESCRIPTION="Pure-C embeddable compiler backend"
HOMEPAGE="https://c9x.me/compile/"
LICENSE="MIT"
SLOT="0"

DOCS=( README doc )

src_compile() {
	emake CFLAGS="-std=c99 ${CPPFLAGS} ${CFLAGS}"
}

src_install() {
	einstalldocs
	emake install DESTDIR="${ED}" PREFIX=/usr
}

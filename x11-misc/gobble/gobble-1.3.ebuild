# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.13.2

EAPI=8

CRATES="
	anyhow@1.0.75
	bitflags@1.3.2
	libc@0.2.147
	memchr@2.5.0
	quick-xml@0.28.2
	xcb@1.2.2
"

inherit cargo

DESCRIPTION="Hide current window before launching external program, unhide after quitting"
HOMEPAGE="https://github.com/EmperorPenguin18/gobble"
SRC_URI="
	https://github.com/EmperorPenguin18/gobble/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+=" MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="man"

RDEPEND="x11-libs/libxcb:="
DEPEND="${RDEPEND}"
BDEPEND="man? ( virtual/pandoc )"

QA_FLAGS_IGNORED="usr/bin/.*"

src_compile() {
	cargo_src_compile
	if use man; then
		pandoc gobble.1.md -s -t man -o gobble.1 || die
	fi
}

src_install() {
	cargo_src_install
	use man && doman gobble.1
}

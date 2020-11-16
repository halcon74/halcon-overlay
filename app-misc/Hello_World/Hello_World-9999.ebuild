# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Part of the project [1]
# [1] - https://github.com/halcon74/hello-world

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9} )

inherit git-r3 python-any-r1 scons-utils toolchain-funcs

DESCRIPTION="A test program printing 'Hello World!' to STDOUT"
HOMEPAGE="https://github.com/halcon74/hello-world"
EGIT_REPO_URI="https://github.com/halcon74/hello-world.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""
IUSE=""

RESTRICT="mirror"

DEPEND=""
RDEPEND=""
BDEPEND="virtual/pkgconfig"

MYSCONS=(
	PREFIX="${EPREFIX}/usr"
	DESTDIR="${D}"
	CXX="$(tc-getCXX)"
	CXXFLAGS="${CXXFLAGS}"
	LDFLAGS="${LDFLAGS}"
)
DOCS=( README.md docs/used_sources )

src_compile() {
	escons "${MYSCONS[@]}"
}

src_install() {
	escons "${MYSCONS[@]}" install
	einstalldocs
}

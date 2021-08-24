# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )

inherit cmake toolchain-funcs

DESCRIPTION="light-weight X11 desktop panel"
HOMEPAGE="https://github.com/eleksir/fbpanel"
SRC_URI="https://github.com/eleksir/fbpanel/archive/refs/tags/${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~mips ppc ppc64 x86"

RESTRICT="mirror"

RDEPEND="
	dev-libs/glib:2
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	x11-libs/libX11
	media-libs/alsa-lib
"
DEPEND="
	${RDEPEND}
	x11-base/xorg-proto
"

BDEPEND="
	virtual/pkgconfig
"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}"/usr
		-DCMAKE_INSTALL_FULL_LIBDIR="${EPREFIX}"/usr/$(get_libdir)
		-DCMAKE_INSTALL_FULL_LIBEXECDIR="${EPREFIX}"/usr/libexec/fbpanel
		-DCMAKE_INSTALL_FULL_DATADIR="${EPREFIX}"/usr/share
		-DCMAKE_INSTALL_FULL_LOCALEDIR="${EPREFIX}"/usr/share/locale
		-DCMAKE_INSTALL_MANDIR="${EPREFIX}"/usr/share/man
		-DCMAKE_INSTALL_DOCDIR="${EPREFIX}"/usr/share/doc/"${PN}"
		-DPROJECT_NAME="${PN}"
		-DPROJECT_VERSION="${PV}"
	)
	   cmake_src_configure
}

src_compile() {
	cmake_src_compile
}

src_install() {
	cmake_src_install
}

pkg_postinst() {
	elog "For the volume plugin to work, you need to configure your kernel"
	elog "with CONFIG_SND_MIXER_OSS or CONFIG_SOUND_PRIME or some other means"
	elog "that provide the /dev/mixer device node."
}

# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils toolchain-funcs unpacker

DESCRIPTION="Worker Filemanager: Amiga Directory Opus 4 clone"
HOMEPAGE="http://www.boomerangsworld.de/cms/worker/"
SRC_URI="mirror://sourceforge/workerfm/${P}.tar.zst"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ppc ~ppc64 x86"
IUSE="avfs debug dbus examples libnotify lua +magic openssl xinerama +xft"

RESTRICT="mirror"

# The author of worker indicated 5.3 in configure.ac explicitly, so, here should be:
# lua? ( >=dev-lang/lua-5.3 )
# But 5.3 is masked in ::Gentoo
RDEPEND="x11-libs/libX11
	avfs? ( >=sys-fs/avfs-0.9.5 )
	dbus? ( dev-libs/dbus-glib )
	lua? ( =dev-lang/lua-5.1.5-r4 )
	magic? ( sys-apps/file )
	openssl? ( dev-libs/openssl )
	xft? ( x11-libs/libXft )
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${RDEPEND}
	app-arch/zstd"

DOCS=( AUTHORS ChangeLog INSTALL NEWS README README_LARGEFILES THANKS )

src_unpack() {
	if [[ -n "${A}" ]]; then
		local _src=$(find_unpackable_file "${A}")
		zstd -df "${_src}" -o "${P}.tar"
		tar -xpf "${P}.tar" -C "${WORKDIR}"
	fi
}

src_configure() {
	# there is no ./configure flag to disable libXinerama support
	export ac_cv_lib_Xinerama_XineramaQueryScreens=$(usex xinerama)
	# there is no ./configure flag to disable openssl support
	export ac_cv_header_openssl_sha_h=$(usex openssl)
	econf \
		--without-hal \
		--enable-utf8 \
		$(use_with avfs) \
		$(use_with dbus) \
		$(use_enable debug) \
		$(use_enable libnotify inotify) \
		$(use_enable lua) \
		$(use_with magic libmagic) \
		$(use_enable xft)
}

src_compile() {
	emake -j1
}

src_install() {
	default

	if use examples; then
		docinto examples
		dodoc examples/config-*
	fi
}

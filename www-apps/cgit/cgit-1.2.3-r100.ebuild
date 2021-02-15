# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUA_COMPAT=( lua5-{1..2} luajit )

inherit lua-single toolchain-funcs

[[ -z "${CGIT_CACHEDIR}" ]] && CGIT_CACHEDIR="/var/cache/${PN}/"

GIT_V="2.25.1"

DESCRIPTION="a fast web-interface for git repositories"
HOMEPAGE="https://git.zx2c4.com/cgit/about"
SRC_URI="https://www.kernel.org/pub/software/scm/git/git-${GIT_V}.tar.xz
	https://git.zx2c4.com/cgit/snapshot/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="doc +highlight libressl +lua test"
REQUIRED_USE="lua? ( ${LUA_REQUIRED_USE} )"
RESTRICT="!test? ( test )"

MY_HOSTROOTDIR="/usr/share/webapps/${PN}/${PVR}/hostroot"
MY_CGIBINDIR="${MY_HOSTROOTDIR}/cgi-bin"
MY_ERRORSDIR="${MY_HOSTROOTDIR}/error"
MY_ICONSDIR="${MY_HOSTROOTDIR}/icons"
MY_SERVERCONFIGDIR="/usr/share/webapps/${PN}/${PVR}/conf"
MY_HOOKSCRIPTSDIR="/usr/share/webapps/${PN}/${PVR}/hooks"
MY_HTDOCSDIR="/usr/share/webapps/${PN}/${PVR}/htdocs"
MY_SQLSCRIPTSDIR="/usr/share/webapps/${PN}/${PVR}/sqlscripts"

RDEPEND="
	acct-group/cgit
	acct-user/cgit
	dev-vcs/git
	highlight? ( || ( dev-python/pygments app-text/highlight ) )
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )
	lua? ( ${LUA_DEPS} )
	sys-libs/zlib
	virtual/httpd-cgi
"

DEPEND="${RDEPEND}
	doc? ( app-text/docbook-xsl-stylesheets
		>=app-text/asciidoc-8.5.1 )
"

pkg_setup() {
	use lua && lua-single_pkg_setup
}

src_prepare() {
	rmdir git || die
	mv "${WORKDIR}"/git-"${GIT_V}" git || die

	echo "prefix = ${EPREFIX}/usr" >> cgit.conf
	echo "libdir = ${EPREFIX}/usr/$(get_libdir)" >> cgit.conf
	echo "CGIT_SCRIPT_PATH = ${MY_CGIBINDIR}" >> cgit.conf
	echo "CGIT_DATA_PATH = ${MY_HTDOCSDIR}" >> cgit.conf
	echo "CACHE_ROOT = ${CGIT_CACHEDIR}" >> cgit.conf
	echo "DESTDIR = ${D}" >> cgit.conf
	if use lua; then
		echo "LUA_PKGCONFIG = ${ELUA}" >> cgit.conf
	else
		echo "NO_LUA = 1" >> cgit.conf
	fi

	eapply_user
}

src_compile() {
	emake V=1 AR="$(tc-getAR)" CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
	use doc && emake V=1 doc-man
}

src_preinst() {
	dodir "${MY_HOSTROOTDIR}"
	dodir "${MY_CGIBINDIR}"
	dodir "${MY_ERRORSDIR}"
	dodir "${MY_ICONSDIR}"
	dodir "${MY_SERVERCONFIGDIR}"
	dodir "${MY_HOOKSCRIPTSDIR}"
	dodir "${MY_HTDOCSDIR}"
	dodir "${MY_SQLSCRIPTSDIR}"
}

src_install() {
	emake V=1 AR="$(tc-getAR)" CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" install

	insinto /etc
	doins "${FILESDIR}"/cgitrc

	dodoc README
	use doc && doman cgitrc.5

	keepdir "${CGIT_CACHEDIR}"
	fowners ${PN}:${PN} "${CGIT_CACHEDIR}"
	fperms 700 "${CGIT_CACHEDIR}"
}

src_test() {
	emake V=1 AR="$(tc-getAR)" CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" test
}

pkg_postinst() {
	ewarn "If you intend to run cgit using web server's user"
	ewarn "you should change ${CGIT_CACHEDIR} permissions."
}

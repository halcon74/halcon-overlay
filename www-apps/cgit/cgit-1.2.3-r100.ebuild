# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUA_COMPAT=( lua5-{1..2} luajit )

inherit lua-single toolchain-funcs

declare -A MY_DIRS
MY_DIRS[APPDIR]="/usr/share/webapps/${PN}/${PVR}"
MY_DIRS[HOSTROOTDIR]="${MY_DIRS[APPDIR]}/hostroot"
MY_DIRS[CGIBINDIR]="${MY_DIRS[HOSTROOTDIR]}/cgi-bin"
MY_DIRS[ERRORSDIR]="${MY_DIRS[HOSTROOTDIR]}/error"
MY_DIRS[ICONSDIR]="${MY_DIRS[HOSTROOTDIR]}/icons"
MY_DIRS[SERVERCONFIGDIR]="${MY_DIRS[APPDIR]}/conf"
MY_DIRS[HOOKSCRIPTSDIR]="${MY_DIRS[APPDIR]}/hooks"
MY_DIRS[HTDOCSDIR]="${MY_DIRS[APPDIR]}/htdocs"
MY_DIRS[SQLSCRIPTSDIR]="${MY_DIRS[APPDIR]}/sqlscripts"
MY_DIRS[CGIT_CACHEDIR]="/var/cache/${PN}"
MY_DIRS[PERSISTROOT]="/var/db/webapps/${PN}/${PVR}"

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
	echo "CGIT_SCRIPT_PATH = ${MY_DIRS[CGIBINDIR]}" >> cgit.conf
	echo "CGIT_DATA_PATH = ${MY_DIRS[HTDOCSDIR]}" >> cgit.conf
	echo "CACHE_ROOT = ${MY_DIRS[CGIT_CACHEDIR]}" >> cgit.conf
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
	local MY_DIR
	for MY_DIR in "${!MY_DIRS[@]}"; do
		dodir "${MY_DIRS[$MY_DIR]}" || die "Failed to create directory ${MY_DIRS[$MY_DIR]}"
	done
}

src_install() {
	emake V=1 AR="$(tc-getAR)" CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" install

	insinto /etc
	doins "${FILESDIR}"/cgitrc

	dodoc README
	use doc && doman cgitrc.5

	insinto "${MY_DIRS[APPDIR]}"
	doins "${FILESDIR}"/postinstall-en.txt

	local MY_DIR
	for MY_DIR in "${!MY_DIRS[@]}"; do
		keepdir "${MY_DIRS[$MY_DIR]}" || die "Failed to keep directory ${MY_DIRS[$MY_DIR]}"
		fowners ${PN}:${PN} "${MY_DIRS[$MY_DIR]}" || die "Failed to change owners for directory ${MY_DIRS[$MY_DIR]}"
		fperms 700 "${MY_DIRS[$MY_DIR]}" || die "Failed to change permissions for directory ${MY_DIRS[$MY_DIR]}"
	done
}

src_test() {
	emake V=1 AR="$(tc-getAR)" CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" test
}

pkg_postinst() {
	ewarn "If you intend to run cgit using web server's user"
	ewarn "you should change ${MY_DIRS[CGIT_CACHEDIR]} permissions."
}

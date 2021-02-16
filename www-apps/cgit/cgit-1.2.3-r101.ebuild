# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUA_COMPAT=( lua5-{1..2} luajit )

inherit lua-single toolchain-funcs

MY_APPDIR="/usr/share/webapps/${PN}/${PVR}"
MY_HOSTROOTDIR="${MY_APPDIR}/hostroot"

declare -A MY_DIRS
MY_DIRS[CGIBINDIR]="${MY_HOSTROOTDIR}/cgi-bin"
MY_DIRS[HTDOCSDIR]="${MY_APPDIR}/htdocs"

declare -A MY_EMPTY_DIRS
MY_EMPTY_DIRS[HOOKSCRIPTSDIR]="${MY_APPDIR}/hooks"
MY_EMPTY_DIRS[CACHEDIR]="/var/cache/${PN}"

GIT_V="2.25.1"

DESCRIPTION="Fast web-interface for git repositories"
HOMEPAGE="https://git.zx2c4.com/cgit/about"
SRC_URI="https://www.kernel.org/pub/software/scm/git/git-${GIT_V}.tar.xz
	https://git.zx2c4.com/cgit/snapshot/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="doc +highlight +lua nginx test"
REQUIRED_USE="lua? ( ${LUA_REQUIRED_USE} )"
RESTRICT="!test? ( test )"

RDEPEND="
	acct-group/cgit
	acct-user/cgit
	dev-vcs/git
	highlight? ( || ( dev-python/pygments app-text/highlight ) )
	dev-libs/openssl:0=
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
	echo "CACHE_ROOT = ${MY_EMPTY_DIRS[CACHEDIR]}" >> cgit.conf
	echo "DESTDIR = ${D}" >> cgit.conf
	if use lua; then
		echo "LUA_PKGCONFIG = ${ELUA}" >> cgit.conf
	else
		echo "NO_LUA = 1" >> cgit.conf
	fi

	eapply "${FILESDIR}"/${PV}-processing-page.patch

	eapply_user
}

src_compile() {
	emake V=1 AR="$(tc-getAR)" CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
	use doc && emake V=1 doc-man
}

src_install() {
	local MY_DIR MY_EMPTY_DIR
	for MY_DIR in "${!MY_DIRS[@]}"; do
		elog "dodir ${MY_DIRS[$MY_DIR]}"
		dodir "${MY_DIRS[$MY_DIR]}"
	done
	for MY_EMPTY_DIR in "${!MY_EMPTY_DIRS[@]}"; do
		keepdir "${MY_EMPTY_DIRS[$MY_EMPTY_DIR]}"
		elog "keepdir ${MY_EMPTY_DIRS[$MY_EMPTY_DIR]}"
	done

	emake V=1 AR="$(tc-getAR)" CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" install

	insinto /etc
	doins "${FILESDIR}"/cgitrc

	dodoc README
	use doc && doman cgitrc.5

	local MY_ALL_DIRS=()
	local MY_DIR_KEY MY_EMPTY_DIR_KEY
	for MY_DIR_KEY in "${!MY_DIRS[@]}"; do
		MY_ALL_DIRS+=( "${MY_DIRS[$MY_DIR_KEY]}" )
	done
	for MY_EMPTY_DIR_KEY in "${!MY_EMPTY_DIRS[@]}"; do
		MY_ALL_DIRS+=( "${MY_EMPTY_DIRS[$MY_EMPTY_DIR_KEY]}" )
	done

	local MY_EACH_DIR
	for MY_EACH_DIR in "${MY_ALL_DIRS[@]}"; do
		if use nginx; then
			fowners nginx:nginx "${MY_EACH_DIR}"
		else
			fowners ${PN}:${PN} "${MY_EACH_DIR}"
		fi
		fperms 700 "${MY_EACH_DIR}"
	done
}

src_test() {
	emake V=1 AR="$(tc-getAR)" CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" test
}

pkg_postinst() {
	local MY_LINE
	while IFS= read -r MY_LINE; do
		ewarn "${MY_LINE}"
	done < <(cat "${FILESDIR}"/postinstall-en.txt)
}

pkg_postrm() {
	rm -rf "${EROOT}${MY_EMPTY_DIRS[CACHEDIR]}" || die
}

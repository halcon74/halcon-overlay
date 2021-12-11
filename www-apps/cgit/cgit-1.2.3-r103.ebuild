# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# This ebuild is based on the official ebuild in the main ::Gentoo tree
# and modified by Alexey Mishustin <halcon@tuta.io>

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

MY_GIT_V="2.25.1"

DESCRIPTION="Fast web-interface for git repositories"
HOMEPAGE="https://git.zx2c4.com/cgit/about"
SRC_URI="https://www.kernel.org/pub/software/scm/git/git-${MY_GIT_V}.tar.xz
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
	mv "${WORKDIR}"/git-"${MY_GIT_V}" git || die

	{ echo "prefix = ${EPREFIX}/usr";
	echo "libdir = ${EPREFIX}/usr/$(get_libdir)";
	echo "CGIT_SCRIPT_PATH = ${MY_DIRS[CGIBINDIR]}";
	echo "CGIT_DATA_PATH = ${MY_DIRS[HTDOCSDIR]}";
	echo "CACHE_ROOT = ${MY_EMPTY_DIRS[CACHEDIR]}";
	echo "DESTDIR = ${D}"; } >> cgit.conf
	if use lua; then
		echo "LUA_PKGCONFIG = ${ELUA}" >> cgit.conf
	else
		echo "NO_LUA = 1" >> cgit.conf
	fi

	eapply "${FILESDIR}"/"${PV}"-processing-page.patch

	eapply_user
}

src_compile() {
	emake V=1 AR="$(tc-getAR)" CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
	use doc && emake V=1 doc-man
}

src_install() {
	local MY_DIR_VALUE MY_EMPTY_DIR_VALUE
	for MY_DIR_VALUE in "${MY_DIRS[@]}"; do
		elog "dodir ${MY_DIR_VALUE}"
		dodir "${MY_DIR_VALUE}"
	done
	for MY_EMPTY_DIR_VALUE in "${MY_EMPTY_DIRS[@]}"; do
		keepdir "${MY_EMPTY_DIR_VALUE}"
		elog "keepdir ${MY_EMPTY_DIR_VALUE}"
	done

	emake V=1 AR="$(tc-getAR)" CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" install

	insinto /etc
	doins "${FILESDIR}"/cgitrc

	dodoc README
	use doc && doman cgitrc.5

	local MY_ALL_DIRS=()
	local MY_DIR_VALUE MY_EMPTY_DIR_VALUE
	for MY_DIR_VALUE in "${MY_DIRS[@]}"; do
		MY_ALL_DIRS+=( "${MY_DIR_VALUE}" )
	done
	for MY_EMPTY_DIR_VALUE in "${MY_EMPTY_DIRS[@]}"; do
		MY_ALL_DIRS+=( "${MY_EMPTY_DIR_VALUE}" )
	done

	local MY_UID MY_EACH_DIR
	MY_UID="cgit"
	if use nginx; then
		MY_UID="nginx"
	fi
	for MY_EACH_DIR in "${MY_ALL_DIRS[@]}"; do
		fowners -R "${MY_UID}":"${MY_UID}" "${MY_EACH_DIR}"
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
	if [[ -z "${REPLACED_BY_VERSION}" ]]; then
		ewarn "rm -rf ${MY_EMPTY_DIRS[CACHEDIR]}"
		rm -rf "${MY_EMPTY_DIRS[CACHEDIR]}" || die
	fi
}

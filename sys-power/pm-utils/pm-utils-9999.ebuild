# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools eutils git-r3

DESCRIPTION="Suspend and hibernation utilities"
HOMEPAGE="https://pm-utils.freedesktop.org/"

EGIT_REPO_URI="https://github.com/halcon74/pm-utils.git"
EGIT_BRANCH="pm-utils-1.4"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug +logrotate video_cards_intel video_cards_radeon"

RESTRICT="mirror"

MY_GIT_DIR=''

vbetool="!video_cards_intel? ( sys-apps/vbetool )"
RDEPEND="!<app-laptop/laptop-mode-tools-1.55-r1
	!sys-power/pm-quirks
	!sys-power/powermgmt-base[-pm-utils(+)]
	sys-apps/dbus
	>=sys-apps/util-linux-2.13
	amd64? ( ${vbetool} )
	x86? ( ${vbetool} )
	logrotate? ( app-admin/logrotate )
	video_cards_radeon? ( app-laptop/radeontool )"
DEPEND="${RDEPEND}
	>=app-crypt/openpgp-keys-pm-utils-20210206
"

DOCS="AUTHORS ChangeLog NEWS pm/HOWTO* README* TODO"

src_unpack() {
	git-r3_fetch

	# Use a git-r3 internal function to find the long term storage of the local clone. This is probably a bad idea, and the ebuild
	# should instead take the tag name from the user instead of guessing it.
	local -x GIT_DIR
	_git-r3_set_gitdir "$EGIT_REPO_URI"
	elog "GIT_DIR=${GIT_DIR}"

	local EGIT_COMMIT
	EGIT_COMMIT=$(cat "${GIT_DIR}"/refs/heads/pm-utils-1.4)
	elog "EGIT_COMMIT = ${EGIT_COMMIT}"
	gemato gpg-wrap -K "/usr/share/openpgp-keys/halcon.asc" -R -- \
		git verify-commit "${EGIT_COMMIT}" ||
		die "Git commit verification failed"

	# Yes, fetch again, now that EGIT_COMMIT is a specific commit.
	git-r3_fetch
	git-r3_checkout

	MY_GIT_DIR="$GIT_DIR"
}

src_prepare() {
	default

	eautoreconf

	local ignore="01grub"
	use debug && echo 'PM_DEBUG="true"' > "${T}"/gentoo
	echo "HOOK_BLACKLIST=\"${ignore}\"" >> "${T}"/gentoo
}

src_configure() {
	econf
}

src_compile() {
	default

	make ChangeLog
}

src_install() {
	default

	doman man/*.{1,8}

	insinto /etc/pm/config.d
	doins "${T}"/gentoo

	if use logrotate ; then
		mv debian/${PN}.logrotate debian/${PN}
		insinto /etc/logrotate.d
		doins debian/${PN} #408091
	fi

	rm -rf "${ED}"/etc/video-quirks

	# Remove hooks which are not stable enough yet (rm -f from debian/rules)
	rm -f "${ED}"/usr/$(get_libdir)/${PN}/power.d/harddrive

	# Change to executable (chmod +x from debian/rules)
	fperms +x /usr/$(get_libdir)/${PN}/defaults
}

pkg_postinst() {
	elog "deleting MY_GIT_DIR ${MY_GIT_DIR}..."
	rm -r "${MY_GIT_DIR}" || die "deleting MY_GIT_DIR failed"
}

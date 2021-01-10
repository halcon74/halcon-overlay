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
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog NEWS pm/HOWTO* README* TODO"

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

src_install() {
	default

	doman man/*.{1,8}

	insinto /etc/pm/config.d
	doins "${T}"/gentoo

	if use logrotate ; then
		mv logrotate/${PN}.logrotate logrotate/${PN}
		insinto /etc/logrotate.d
		doins logrotate/${PN} #408091
	fi

	# No longer required with current networkmanager (rm -f from debian/rules)
	rm -f "${ED}"/usr/$(get_libdir)/${PN}/sleep.d/55NetworkManager

	# No longer required with current kernels (rm -f from debian/rules)
	rm -f "${ED}"/usr/$(get_libdir)/${PN}/sleep.d/49bluetooth

	# Punt HAL related file wrt #401257 (rm -f from debian/rules)
	rm -f "${ED}"/usr/$(get_libdir)/${PN}/power.d/hal-cd-polling

	# Punt hooks which have shown to not reduce, or even increase power usage
	# (rm -f from debian rules)
	rm -f "${ED}"/usr/$(get_libdir)/${PN}/power.d/{journal-commit,readahead}

	# Remove hooks which are not stable enough yet (rm -f from debian/rules)
	rm -f "${ED}"/usr/$(get_libdir)/${PN}/power.d/harddrive

	# Change to executable (chmod +x from debian/rules)
	fperms +x /usr/$(get_libdir)/${PN}/defaults
}

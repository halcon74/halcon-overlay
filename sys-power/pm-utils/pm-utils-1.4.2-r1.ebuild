# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit autotools eutils multilib

DESCRIPTION="Suspend and hibernation utilities"
HOMEPAGE="https://pm-utils.freedesktop.org/"
SRC_URI="https://github.com/halcon74/pm-utils/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="debug ntp video_cards_intel video_cards_radeon"

RESTRICT="mirror"

vbetool="!video_cards_intel? ( sys-apps/vbetool )"
RDEPEND="!<app-laptop/laptop-mode-tools-1.55-r1
	!sys-power/powermgmt-base[-pm-utils(+)]
	sys-apps/dbus
	>=sys-apps/util-linux-2.13
	sys-power/pm-quirks
	ntp? ( || ( net-misc/ntp net-misc/openntpd ) )
	amd64? ( ${vbetool} )
	x86? ( ${vbetool} )
	video_cards_radeon? ( app-laptop/radeontool )"
DEPEND="${RDEPEND}"

DOCS="AUTHORS NEWS pm/HOWTO* README* TODO"

src_unpack() {
	default
	mv ${WORKDIR}/pm-utils-${P} ${WORKDIR}/${P} 
}

src_prepare() {
	default

	eautoreconf

	local ignore="01grub"
	use ntp || ignore+=" 90clock"

	use debug && echo 'PM_DEBUG="true"' > "${T}"/gentoo
	echo "HOOK_BLACKLIST=\"${ignore}\"" >> "${T}"/gentoo
}

src_configure() {
	econf
}

src_install() {
	default
	doman man/*.{1,8}

	# Remove duplicate documentation install
	rm -r "${ED}"/usr/share/doc/${PN}

	insinto /etc/pm/config.d
	doins "${T}"/gentoo

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/${PN}.logrotate ${PN} #408091

	exeinto /usr/$(get_libdir)/${PN}/sleep.d
	doexe "${FILESDIR}"/sleep.d/50unload_alx

	exeinto /usr/$(get_libdir)/${PN}/power.d
	doexe "${FILESDIR}"/power.d/{pci_devices,usb_bluetooth}

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

# Copyright 2012-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit udev

DESCRIPTION="Hardware (PCI, USB, OUI, IAB) IDs databases"
HOMEPAGE="https://github.com/halcon74/hwids"
if [[ ${PV} == 9999 ]]; then
	PYTHON_COMPAT=( python3_{6..10} )
	inherit git-r3 python-any-r1
	EGIT_REPO_URI="https://github.com/halcon74/hwids.git"
else
	SRC_URI="https://github.com/halcon74/hwids/archive/${P}.tar.gz"
	KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux"
fi

LICENSE="|| ( GPL-2 BSD ) public-domain"
SLOT="0"
IUSE="+net +pci systemd +udev +usb"
REQUIRED_USE="systemd? ( udev )"

RDEPEND="
	systemd? ( sys-apps/systemd[hwdb(+)] )
	udev? ( virtual/udev )
"

if [[ ${PV} == 9999 ]]; then
	BDEPEND="
		net-misc/curl
		udev? ( $(python_gen_any_dep 'dev-python/pyparsing[${PYTHON_USEDEP}]') )
	"
	python_check_deps() {
		if use udev; then
			has_version -b "dev-python/pyparsing[${PYTHON_USEDEP}]"
		fi
	}
else
	S=${WORKDIR}/hwids-${P}
fi

pkg_setup() {
	:
}

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
		cd "${S}" || die
		emake fetch
	else
		default
	fi
}

src_prepare() {
	default
	sed -i -e '/udevadm hwdb/d' Makefile || die
}

_emake() {
	emake \
		NET=$(usex net) \
		PCI=$(usex pci) \
		UDEV=$(usex udev) \
		USB=$(usex usb) \
		"$@"
}

src_compile() {
	if [[ ${PV} == 9999 ]] && use udev; then
		python_setup
		_emake udev-hwdb
	fi
	_emake
}

src_install() {
	_emake install \
		DOCDIR="${EPREFIX}/usr/share/doc/${PF}" \
		MISCDIR="${EPREFIX}/usr/share/misc" \
		HWDBDIR="${EPREFIX}$(get_udevdir)/hwdb.d" \
		DESTDIR="${D}"
}

pkg_postinst() {
	if use systemd; then
		systemd-hwdb --root="${ROOT}" update
	elif use udev; then
		udevadm hwdb --update --root="${ROOT}"
	fi
}

# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="OpenPGP key used to sign pm-utils (Alexey Mishustin's fork) git commits"
HOMEPAGE="https://github.com/halcon74/openpgp-key/releases/tag/v20210206"
SRC_URI="
	https://keys.openpgp.org/vks/v1/by-fingerprint/2CBEFA570AEB24A706847485BF15ECF9BFC05F96
		-> halcon.asc
"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"

S=${WORKDIR}

src_install() {
	local files=( ${A} )
	insinto /usr/share/openpgp-keys
	newins - halcon.asc < <(cat "${files[@]/#/${DISTDIR}/}")
}

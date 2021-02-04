# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR="KARUPA"
DIST_VERSION="0.01"
inherit perl-module

DESCRIPTION="Fuzzy number comparison with Test::Deep"
HOMEPAGE="https://github.com/karupanerura/Test-Deep-Fuzzy"

SLOT="0"
IUSE="test"
RESTRICT="
	mirror
	!test? ( test )
"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

RDEPEND="
	>=virtual/perl-Exporter-5.570.0
	virtual/perl-Scalar-List-Utils
	dev-perl/Math-Round
	dev-perl/Test-Deep
"

DEPEND="${RDEPEND}
	>=dev-perl/Module-Build-Tiny-0.35.0
	test? (
		virtual/perl-Test-Simple
		dev-perl/Test-Deep
	)
"

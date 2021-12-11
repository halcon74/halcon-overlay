# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR="KARUPA"
DIST_VERSION="0.91"
DIST_EXAMPLES=("author/*")
inherit perl-module

DESCRIPTION="Simple TOML parser"
HOMEPAGE="https://github.com/karupanerura/TOML-Parser"

SLOT="0"
IUSE="examples test"
RESTRICT="
	mirror
	!test? ( test )
"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

RDEPEND="
	virtual/perl-Encode
	>=virtual/perl-Exporter-5.570.0
	virtual/perl-parent

	dev-perl/Types-Serialiser
"

BDEPEND="${RDEPEND}
	virtual/perl-MIME-Base64
	>=virtual/perl-Storable-2.380.0
	>=dev-perl/Module-Build-Tiny-0.35.0
	test? (
		>=virtual/perl-Test-Simple-0.980.0
		dev-perl/Test-Deep
		dev-perl/Test-Deep-Fuzzy
		)
"

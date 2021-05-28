# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR="TOBYINK"
DIST_VERSION="0.011"
inherit perl-module

DESCRIPTION="Declare class attributes Moose-style... but without Moose"
HOMEPAGE="https://metacpan.org/release/TOBYINK/MooX-ClassAttribute-0.011"

SLOT="0"
IUSE="test"
RESTRICT="
	mirror
	!test? ( test )
"
KEYWORDS="~amd64 ~m68k ~mips ~s390 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

RDEPEND="
	virtual/perl-Exporter
	>=dev-perl/Moo-1.0.0
	>=dev-perl/Role-Tiny-1.0.0
"

BDEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.170.0
	!~dev-perl/Moo-1.1.0
	!<=dev-perl/MooseX-ClassAttribute-0.260.0
	test? ( virtual/perl-Test-Simple	)
"

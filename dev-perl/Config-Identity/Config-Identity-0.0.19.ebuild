# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR="DAGOLDEN"
DIST_VERSION="0.0019"
inherit perl-module

DESCRIPTION="Load (and optionally decrypt via GnuPG) user/pass identity information"
HOMEPAGE="https://github.com/dagolden/Config-Identity"

SLOT="0"
IUSE="test"
RESTRICT="
	mirror
	!test? ( test )
"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

RDEPEND="
	virtual/perl-Carp
	virtual/perl-File-Spec
	dev-perl/File-HomeDir
	dev-perl/File-Which
	dev-perl/IPC-Run
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.170.0
	test? (
		virtual/perl-Test-Simple
		dev-perl/Test-Deep
	)
"

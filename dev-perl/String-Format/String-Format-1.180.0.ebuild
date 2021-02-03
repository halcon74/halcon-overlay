# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR="SREZIC"
DIST_VERSION="1.18"
inherit perl-module

DESCRIPTION="sprintf-like string formatting capabilities with arbitrary format definitions"
HOMEPAGE="https://github.com/dlc/string--format"

LICENSE="GPL-2"
SLOT="0"
IUSE="test"
RESTRICT="
	mirror
	!test? ( test )
"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

RDEPEND=""

DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? ( virtual/perl-Test-Simple )
"

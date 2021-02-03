# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR="KAZUHO"
DIST_VERSION="0.24"
inherit perl-module

DESCRIPTION="Micro template engine with Perl5 language"
HOMEPAGE="https://github.com/kazuho/p5-text-microtemplate"

DIST_EXAMPLES=("contrib/*")

SLOT="0"
IUSE="examples test"
RESTRICT="
	mirror
	!test? ( test )
"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

RDEPEND=""

# There is a bug in the distribution meta.yml, there is written ExtUtils::MakeMaker: 6.5, but actually Module::Install is used
DEPEND="${RDEPEND}
	dev-perl/Module-Install
	virtual/perl-File-Temp
	test? ( virtual/perl-Test-Simple dev-perl/Test-Requires )
"

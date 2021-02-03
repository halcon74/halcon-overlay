# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR="SYOHEX"
DIST_VERSION="v3.1.11"
inherit perl-module

DESCRIPTION="CPAN module authoring tool"
HOMEPAGE="https://github.com/tokuhirom/Minilla"

DIST_EXAMPLES=("eg/*")

SLOT="0"
IUSE="examples test"
RESTRICT="
	mirror
	!test? ( test )
"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

RDEPEND="
	>=virtual/perl-Archive-Tar-1.600.0
	>=virtual/perl-CPAN-Meta-2.132.830
	>=virtual/perl-ExtUtils-Manifest-1.540.0
	>=virtual/perl-Getopt-Long-2.360.0
	>=virtual/perl-Module-Metadata-1.0.27
	virtual/perl-Term-ANSIColor
	virtual/perl-Test-Harness
	>=virtual/perl-Time-Piece-1.160.0
	virtual/perl-parent
	virtual/perl-version
	>=dev-perl/App-cpanminus-1.690.200
	dev-perl/Config-Identity
	>=dev-perl/Data-Section-Simple-0.40.0
	dev-perl/File-Which
	dev-perl/File-pushd
	>=dev-perl/Module-CPANfile-0.902.500
	dev-perl/Module-Runtime
	>=dev-perl/Moo-1.1.0
	>=dev-perl/Pod-Markdown-1.322.0
	>=dev-perl/TOML-0.950.0
	>=dev-perl/Text-MicroTemplate-0.200.0
	dev-perl/Try-Tiny
	dev-perl/URI
"

DEPEND="${RDEPEND}
	virtual/perl-File-Temp
	dev-perl/File-Copy-Recursive
	dev-perl/JSON
	>=dev-perl/Module-Build-Tiny-0.35.0
	test? ( 
		>=virtual/perl-Test-Simple-0.980.0
		dev-perl/Test-Output
		dev-perl/Test-Requires
	)
"

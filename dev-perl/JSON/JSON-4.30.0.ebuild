# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit perl-module

DIST_AUTHOR="ISHIGAKI"
DIST_VERSION="4.03"
DIST_EXAMPLES=("eg/*")

DESCRIPTION="JSON (JavaScript Object Notation) encoder/decoder"

SLOT="0"
IUSE="examples test +xs"
RESTRICT="
	mirror
	!test? ( test )
"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris"

RDEPEND="xs? ( >=dev-perl/JSON-XS-2.340.0 )"

DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? ( virtual/perl-Test-Simple )
"

src_test() {
	perl_rm_files t/00_pod.t
	perl-module_src_test
}

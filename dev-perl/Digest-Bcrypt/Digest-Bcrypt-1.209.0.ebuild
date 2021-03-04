# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR="CAPOEIRAB"
DIST_VERSION="1.209"
inherit perl-module

DESCRIPTION="Perl interface to the bcrypt digest algorithm"
HOMEPAGE="https://github.com/genio/digest-bcrypt"

SLOT="0"
IUSE="test"
RESTRICT="
	mirror
	!test? ( test )
"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

RDEPEND="
	virtual/perl-Carp
	dev-perl/Crypt-Eksblowfish
	virtual/perl-Digest
	virtual/perl-parent
"

DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	virtual/perl-File-Spec
	>=virtual/perl-Scalar-List-Utils-0.880.0
	>=dev-perl/Try-Tiny-0.240.0
	test? ( >=virtual/perl-Test-Simple-0.880.0 )
"

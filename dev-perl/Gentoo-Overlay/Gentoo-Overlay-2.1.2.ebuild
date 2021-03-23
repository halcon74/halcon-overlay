# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR="KENTNL"
DIST_VERSION="2.001002"
inherit perl-module

DESCRIPTION="Tools for working with Gentoo Overlays"
HOMEPAGE="https://metacpan.org/release/Gentoo-Overlay"

SLOT="0"
IUSE="test"
RESTRICT="
	mirror
	!test? ( test )
"
KEYWORDS="~amd64 ~m68k ~mips ~s390 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

# StackTrace::Auto -> Throwable
# Type::Library -> Type-Tiny
# Types::Standard -> Type-Tiny
# Type::Utils -> Type-Tiny
# overload -> perl
RDEPEND="
	virtual/perl-Carp
	dev-perl/Const-Fast
	>=dev-perl/Moo-1.6.0
	dev-perl/MooX-ClassAttribute
	dev-perl/MooX-HandlesVia
	dev-perl/MooseX-Has-Sugar
	dev-perl/String-Errf
	dev-perl/Sub-Exporter-Progressive
	dev-perl/Throwable
	dev-perl/Try-Tiny
	dev-perl/Types-Path-Tiny
	>=dev-perl/Type-Tiny-0.8.0
	dev-perl/namespace-clean
"

# FindBin -> perl
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	virtual/perl-File-Spec
	test? (
		>=virtual/perl-Test-Simple-0.960.0
		dev-perl/Test-Fatal
		dev-perl/Test-Output
	)
"

# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR="ZEFRAM"
DIST_VERSION="0.007"
inherit perl-module

DESCRIPTION="Entropy (randomness) management"
HOMEPAGE="https://metacpan.org/release/Data-Entropy"

SLOT="0"
IUSE="test"
RESTRICT="
	mirror
	!test? ( test )
"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

RDEPEND="
	dev-perl/Crypt-Rijndael
	>=dev-perl/Data-Float-0.8.0
	>=virtual/perl-IO-1.30.0
	virtual/perl-Carp
	virtual/perl-Exporter
	dev-perl/Params-Classify
	virtual/perl-parent
	>=virtual/perl-Math-BigInt-1.600.0
	>=virtual/perl-Math-BigRat-0.40.0
"

DEPEND="${RDEPEND}
	dev-perl/Module-Build
	test? ( virtual/perl-Test-Simple )
"

# Modules Data::Entropy::RawSource::RandomOrg and Data::Entropy::RawSource::RandomnumbersInfo
# are not needed in the minimal configuration.
# They would require HTTP::Lite and would get random numbers from websites.
# They could be enabled with IUSE flag 'web' or something.
PERL_RM_FILES=(
	lib/Data/Entropy/RawSource/RandomOrg.pm
	lib/Data/Entropy/RawSource/RandomnumbersInfo.pm
	t/rs_randomorg.t
	t/rs_randomnumbersinfo.t
)

src_prepare() {
	perl-module_src_prepare

	# The same comment as for PERL_RM_FILES
	sed -i -e '/HTTP::Lite/d' Build.PL || die
	sed -i -e '/HTTP::Lite/d' META.json || die
	sed -i -e '/HTTP::Lite/d' META.yml || die
	sed -i -e '/RandomOrg/d' \
			-e '/RandomnumbersInfo/d' MANIFEST || die

	# ToDo: shorten the following code or move it to an eclass
	local		ORG_PM			INFO_PM	\
			ORG_JSON_NUM	ORG_YML_NUM	\
			INFO_JSON_NUM	INFO_YML_NUM \
			ORG_JSON_FROM	ORG_JSON_TO		INFO_JSON_FROM	INFO_JSON_TO \
			ORG_YML_FROM	ORG_YML_TO		INFO_YML_FROM	INFO_YML_TO

	ORG_PM="lib/Data/Entropy/RawSource/RandomOrg.pm"
	INFO_PM="lib/Data/Entropy/RawSource/RandomnumbersInfo.pm"

	ORG_JSON_NUM="$(grep -n -- "${ORG_PM}" META.json | head -1 | cut -d: -f1)" || die
	ORG_YML_NUM="$(grep -n -- "${ORG_PM}" META.yml | head -1 | cut -d: -f1)" || die
	INFO_JSON_NUM="$(grep -n -- "${INFO_PM}" META.json | head -1 | cut -d: -f1)" || die
	INFO_YML_NUM="$(grep -n -- "${INFO_PM}" META.yml | head -1 | cut -d: -f1)" || die

	let "ORG_JSON_FROM=ORG_JSON_NUM-1" || die
	let "ORG_JSON_TO=ORG_JSON_NUM+2" || die
	let "INFO_JSON_FROM=INFO_JSON_NUM-1" || die
	let "INFO_JSON_TO=INFO_JSON_NUM+2" || die

	let "ORG_YML_FROM=ORG_YML_NUM-1" || die
	let "ORG_YML_TO=ORG_YML_NUM+1" || die
	let "INFO_YML_FROM=INFO_YML_NUM-1" || die
	let "INFO_YML_TO=INFO_YML_NUM+1" || die

	sed -i -e "${ORG_JSON_FROM},${ORG_JSON_TO}d" \
			-e "${INFO_JSON_FROM},${INFO_JSON_TO}d" META.json || die

	sed -i -e "${ORG_YML_FROM},${ORG_YML_TO}d" \
			-e "${INFO_YML_FROM},${INFO_YML_TO}d" META.yml || die
}

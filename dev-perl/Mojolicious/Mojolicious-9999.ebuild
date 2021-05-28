# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Based on an ebuild from pg-overlay [1] and the code proposed by Hu on Gentoo Forum [2]
# [1] - https://github.com/gentoo-mirror/pg_overlay/blob/master/dev-perl/Mojolicious/Mojolicious-8.260.0.ebuild
# [2] - https://forums.gentoo.org/viewtopic-p-8482160.html#8482160

EAPI=7

inherit perl-module git-r3

DESCRIPTION="Real-time web framework"
HOMEPAGE="https://mojolicious.org https://metacpan.org/release/Mojolicious https://github.com/mojolicious/mojo"

DIST_EXAMPLES=("examples/*")

EGIT_REPO_URI="https://github.com/mojolicious/mojo.git"
EGIT_BRANCH="master"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS=""
IUSE="examples test minimal"

RESTRICT="
	mirror
	!test? ( test )
"

MY_GIT_DIR=""

RDEPEND="
	!minimal? ( >=dev-perl/EV-4.0.0 )
	>=virtual/perl-IO-Socket-IP-0.370.0
	>=virtual/perl-JSON-PP-2.271.30
	>=virtual/perl-Pod-Simple-3.90.0
	>=virtual/perl-Time-Local-1.200.0
"
BDEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? ( virtual/perl-Test-Simple	)
"

src_unpack() {
	git-r3_fetch

	# Use a git-r3 internal function to find the long term storage of the local clone. This is probably a bad idea, and the ebuild
	# should instead take the tag name from the user instead of guessing it.
	local -x GIT_DIR
	_git-r3_set_gitdir "$EGIT_REPO_URI"
	elog "GIT_DIR=${GIT_DIR}"

	local EGIT_COMMIT
	EGIT_COMMIT=$(git describe --tags --abbrev=0 master)
	elog "EGIT_COMMIT=${EGIT_COMMIT}"

	# Yes, fetch again, now that EGIT_COMMIT is a specific tag.
	git-r3_fetch
	git-r3_checkout

	MY_GIT_DIR="$GIT_DIR"
}

src_test() {
	perl_rm_files t/pod{,_coverage}.t
	perl-module_src_test
}

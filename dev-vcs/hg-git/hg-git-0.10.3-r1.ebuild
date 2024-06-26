# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python3_10 )

inherit distutils-r1

DESCRIPTION="Push to and pull from a Git repository using Mercurial"
HOMEPAGE="https://hg-git.github.io https://pypi.org/project/hg-git/"
SRC_URI="https://foss.heptapod.net/mercurial/hg-git/-/archive/${PV}/${PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="
	>=dev-vcs/mercurial-5.3.2[${PYTHON_USEDEP}]
	>=dev-python/dulwich-0.19.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

S="${WORKDIR}/${PN}-${PV}"

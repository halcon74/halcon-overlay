# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Based on the code proposed by Hu [1] and fedeliallalinea [2] on Gentoo Forum
# [1] - https://forums.gentoo.org/viewtopic-p-8477816.html#8477816
# [2] - https://forums.gentoo.org/viewtopic-p-8478388.html#8478388

# Works together with one of the three patches, published on the Gentoo Forum [3]
# [3] - https://forums.gentoo.org/viewtopic-p-8477654.html#8477654

# No more actual for Linux Kernels >=5.8 [4]
# [4] - https://forums.gentoo.org/viewtopic-p-8487416.html#8487416

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Non-root Xorg and modesetting driver on Gentoo or any non-systemd system"
HOMEPAGE="https://ch1p.io/non-root-xorg-modesetting/ https://github.com/gch1p/drm_master_util/"
MY_COMMIT="e9412bbc8df43ee3282ae515198b39ae7c99f09d"
SRC_URI="https://codeload.github.com/gch1p/drm_master_util/tar.gz/$MY_COMMIT -> $P-$MY_COMMIT.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/libdrm"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

S="$WORKDIR/drm_master_util-${MY_COMMIT}"

src_prepare() {
	default
	sed -i -e "s/\$(PREFIX)/\$(DESTDIR)\$(PREFIX)/g" \
		-e "s/\$(INSTALL) \$(PROGRAM)/\$(INSTALL) -D \$(PROGRAM) -t /g" Makefile
}

src_compile() {
	$(tc-getCC) $CFLAGS $CPPFLAGS $LDFLAGS `pkg-config --cflags --libs libdrm` -o $PN drm_master_util.c
}

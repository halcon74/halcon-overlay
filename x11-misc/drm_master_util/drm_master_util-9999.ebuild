# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Based on an ebuild proposed by GDH-Gentoo on Gentoo Forum [1]
# [1] - https://forums.gentoo.org/viewtopic-p-8478448.html#8478448

# Requires patches for x11-drivers/xf86-video-amdgpu, x11-drivers/xf86-video-ati, x11-base/xorg-server [2]
# [2] - https://forums.gentoo.org/viewtopic-p-8477654.html#8477654

# No more actual for Linux Kernels >=5.8 [3]
# [3] - https://forums.gentoo.org/viewtopic-p-8487416.html#8487416

EAPI=7

inherit git-r3 toolchain-funcs

DESCRIPTION="suid program for using video drivers under rootless Xorg"
HOMEPAGE="https://ch1p.io/non-root-xorg-modesetting/ https://github.com/gch1p/drm_master_util/"
EGIT_REPO_URI="https://github.com/gch1p/drm_master_util.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RESTRICT="mirror"

DEPEND="x11-libs/libdrm"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_compile() {
	tc-export PKG_CONFIG
	local LIBDRM_CFLAGS="$(${PKG_CONFIG} --cflags libdrm)"
	local LIBDRM_LIBS="$(${PKG_CONFIG} --libs libdrm)"
	$(tc-getCC) -o ${PN} ${CPPFLAGS} ${LIBDRM_CFLAGS} ${CFLAGS} \
		${LDFLAGS} drm_master_util.c ${LIBDRM_LIBS} ||
		die "Could not compile ${PN}"
}

src_install() {
	exeopts -m a+rx,u+ws
	exeinto usr/bin
	doexe ${PN}
}

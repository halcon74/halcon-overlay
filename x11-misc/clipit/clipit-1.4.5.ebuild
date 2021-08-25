# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools gnome2-utils xdg-utils

DESCRIPTION="Lightweight GTK+ clipboard manager. Fork of Parcellite."
HOMEPAGE="http://gtkclipit.sourceforge.net https://github.com/CristianHenzel/ClipIt"
SRC_URI="https://github.com/CristianHenzel/ClipIt/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
S="${WORKDIR}/ClipIt-${PV}"

LICENSE="GPL-3"
SLOT="0"
IUSE="nls +gtk3 appindicator"

REQUIRED_USE="appindicator? ( gtk3 )"

COMMON_DEPENDS="
	!gtk3? ( >=x11-libs/gtk+-2.10:2 )
	gtk3? (
		x11-libs/gtk+:3
		appindicator? ( dev-libs/libappindicator:3 )
	)
	>=dev-libs/glib-2.14
"
DEPEND="${COMMON_DEPENDS}
	nls? (
		dev-util/intltool
		sys-devel/gettext
	)
"
RDEPEND="${COMMON_DEPENDS}
	x11-misc/xdotool
"

src_prepare(){
	# Otherwise, there is error
		# checking for APPINDICATOR... no
		# configure: error: Package requirements (ayatana-appindicator3-0.1 >= 0.2.4) were not met:
		# 
		# Package 'ayatana-appindicator3-0.1', required by 'virtual:world', not found
		# 
		# Consider adjusting the PKG_CONFIG_PATH environment variable if you
		# installed software in a non-standard prefix.
		# 
		# Alternatively, you may set the environment variables APPINDICATOR_CFLAGS
		# and APPINDICATOR_LIBS to avoid the need to call pkg-config.
		# See the pkg-config man page for more details.
	# I know, 2nd and 3rd lines are a no-brain solution :) I just hadn't time to fix it properly (I don't use Unity)
	sed -i -e 's/libayatana-appindicator/libappindicator/' src/main.c
	sed -i -e 's/if test x$enable_appindicator = xauto /if test x$enable_appindicator = x1111111111111 /' configure.ac
	sed -i -e 's/if test x$enable_appindicator = xyes /if test x$enable_appindicator = x2222222222222 /' configure.ac

	default_src_prepare
	eautoreconf
}

src_configure(){
	econf \
		$(use_enable nls) \
		$(use_enable appindicator) \
		$(use_with gtk3)
}

pkg_preinst(){
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

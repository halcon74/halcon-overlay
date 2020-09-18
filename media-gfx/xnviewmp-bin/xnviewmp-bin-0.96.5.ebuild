# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Based on an ebuild from c2p-overlay [1]
# [1] - https://github.com/gentoo-mirror/c2p-overlay/blob/master/media-gfx/XnViewMP/XnViewMP-0.89.ebuild

# Gentoo Forum discussion is on [2]
# [2] - https://forums.gentoo.org/viewtopic-t-1118764-highlight-.html

EAPI=7

inherit desktop xdg-utils

DESCRIPTION="A versatile and powerful photo viewer, image management, image resizer"
HOMEPAGE="https://www.xnview.com/en/xnviewmp/ https://newsgroup.xnview.com/viewtopic.php?f=82&t=40823&sid=1e876705c694988991fd81eca5b925d1"
MY_V=${PV//./}
SRC_URI="https://download.xnview.com/old_versions/XnViewMP-${MY_V}-linux-x64.tgz"

LICENSE="freedist XnView"
SLOT="0"
KEYWORDS="~amd64"
IUSE="-bundled-qt-libs -bundled-icu-libs -bundled-other-libs -system-pulseaudio"

RESTRICT="strip mirror"
REQUIRED_USE="bundled-qt-libs? ( !system-pulseaudio )"

BUNDLED_QT_LIBS="
	libQt5Concurrent.so.5		libQt5Concurrent.so.5.12.8
	libQt5Core.so.5			libQt5Core.so.5.12.8
	libQt5DBus.so.5			libQt5DBus.so.5.12.8
	libQt5Gui.so.5				libQt5Gui.so.5.12.8
	libQt5Multimedia.so.5		libQt5Multimedia.so.5.12.8
	libQt5MultimediaWidgets.so.5	libQt5MultimediaWidgets.so.5.12.8
	libQt5Network.so.5			libQt5Network.so.5.12.8
	libQt5OpenGL.so.5			libQt5OpenGL.so.5.12.8
	libQt5Positioning.so.5		libQt5Positioning.so.5.12.8
	libQt5PrintSupport.so.5		libQt5PrintSupport.so.5.12.8
	libQt5Qml.so.5				libQt5Qml.so.5.12.8
	libQt5Quick.so.5			libQt5Quick.so.5.12.8
	libQt5Sensors.so.5			libQt5Sensors.so.5.12.8
	libQt5Sql.so.5				libQt5Sql.so.5.12.8
	libQt5Svg.so.5				libQt5Svg.so.5.12.8
	libQt5WebChannel.so.5		libQt5WebChannel.so.5.12.8
	libQt5WebKit.so.5			libQt5WebKit.so.5.9.0
	libQt5WebKitWidgets.so.5		libQt5WebKitWidgets.so.5.9.0
	libQt5Widgets.so.5			libQt5Widgets.so.5.12.8
	libQt5X11Extras.so.5		libQt5X11Extras.so.5.12.8
	libQt5XcbQpa.so.5			libQt5XcbQpa.so.5.12.8
	libQt5Xml.so.5				libQt5Xml.so.5.12.8
	libQtAV.so.1				libQtAV.so.1.12.0
	libQtAVWidgets.so.1			libQtAVWidgets.so.1.12.0"
	
BUNDLED_ICU_LIBS="
	libicudata.so				libicudata.so.56			libicudata.so.56.1
	libicui18n.so				libicui18n.so.56			libicui18n.so.56.1
	libicuio.so					libicuio.so.56				libicuio.so.56.1
	libicule.so					libicule.so.56				libicule.so.56.1
	libiculx.so					libiculx.so.56				libiculx.so.56.1
	libicutest.so				libicutest.so.56				libicutest.so.56.1
	libicutu.so				libicutu.so.56				libicutu.so.56.1
	libicuuc.so				libicuuc.so.56				libicuuc.so.56.1"

BUNDLED_OTHER_LIBS="
	libavcodec.so.58
	libavdevice.so.58
	libavfilter.so.7
	libavformat.so.58
	libavutil.so.56
	libcrypto.so				libcrypto.so.1.1
	libdbus-1.so.3				libdbus-1.so
	libqgsttools_p.so			libqgsttools_p.so.1
	libssl.so					libssl.so.1.1
	libswresample.so.3
	libswscale.so.5
	libva-drm.so.1
	libva-x11.so.1
	libva.so.1
	libvdpau.so.1
	libwebp.so.6				libwebp.so
	audio/ platforms/ printsupport/"

BUNDLED_QT_LIBS_DEPEND="
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5[X]
	dev-qt/qtgui:5[gif]
	dev-qt/qtgui:5[jpeg]
	dev-qt/qtgui:5[png]
	!system-pulseaudio? (
		dev-qt/qtmultimedia:5[widgets]
		dev-qt/qtmultimedia:5[qml]
	)
	system-pulseaudio? (
		dev-qt/qtmultimedia:5[pulseaudio]
		dev-qt/qtmultimedia:5[widgets]
		dev-qt/qtmultimedia:5[qml]
	)
	dev-qt/qtnetwork:5
	dev-qt/qtopengl:5
	dev-qt/qtlocation:5
	dev-qt/qtprintsupport:5
	dev-qt/qtdeclarative:5
	dev-qt/qtsensors:5[qml]
	dev-qt/qtsql:5
	dev-qt/qtsvg:5
	dev-qt/qtwebchannel:5[qml]
	dev-qt/qtwebkit:5[qml]
	dev-qt/qtwebkit:5[opengl]
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	dev-qt/qtxml:5
	system-pulseaudio? (
		media-libs/qtav[pulseaudio]
	)"

BUNDLED_ICU_LIBS_DEPEND="dev-libs/icu"

DEPEND=""
RDEPEND="
	>=dev-libs/glib-2
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXt
	!bundled-qt-libs? ( ${BUNDLED_QT_LIBS_DEPEND} )
	!bundled-icu-libs? ( ${BUNDLED_ICU_LIBS_DEPEND} )"
BDEPEND="x11-misc/xdg-utils"

S="${WORKDIR}/XnView"

PATCHES=(
	"${FILESDIR}/xnviewmp-bin--security-paths.patch"
)

src_prepare() {
	default

	if ! use bundled-qt-libs ; then
		einfo Removing bundled qt libraries
		for libname in ${BUNDLED_QT_LIBS} ; do
			rm -rv "${S}"/lib/${libname} || die "Failed removing bundled qt library ${libname}"
		done
		rm "${S}"/qt.conf
	fi

	if ! use bundled-icu-libs ; then
		einfo Removing bundled icu libraries
		for libname in ${BUNDLED_ICU_LIBS} ; do
			rm -rv "${S}"/lib/${libname} || die "Failed removing bundled icu library ${libname}"
		done
	fi
	
	if ! use bundled-other-libs ; then
		einfo Removing bundled other libraries
		for libname in ${BUNDLED_OTHER_LIBS} ; do
			rm -rv "${S}"/lib/${libname} || die "Failed removing bundled other library ${libname}"
		done
	fi
}

src_install() {
	declare XNVIEW_HOME=/opt/XnView

	# Install XnView in /opt
	dodir ${XNVIEW_HOME%/*}
	mv "${S}" "${D}"${XNVIEW_HOME} || die "Unable to install XnView folder"

	# Create /opt/bin/xnview
	dodir /opt/bin/
	dosym ${XNVIEW_HOME}/XnView /opt/bin/xnview

	# Install icon and .desktop for menu entry
	newicon "${D}"${XNVIEW_HOME}/xnview.png ${PN}.png || die "newicon failed"
	make_desktop_entry xnview XnViewMP ${PN} "Graphics" || die "make_desktop_entry failed"
}

pkg_postinst(){
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

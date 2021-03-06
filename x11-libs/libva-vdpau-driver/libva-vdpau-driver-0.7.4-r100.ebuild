# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools multilib-minimal git-r3

DESCRIPTION="VDPAU Backend for Video Acceleration (VA) API"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/vaapi"
SRC_URI=""

EGIT_REPO_URI="https://github.com/cjosephson/libva-vdpau-driver"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="debug opengl"

RDEPEND=">=x11-libs/libva-1.2.1-r1:=[X,opengl?,${MULTILIB_USEDEP}]
	opengl? ( >=virtual/opengl-7.0-r1[${MULTILIB_USEDEP}] )
	>=x11-libs/libvdpau-0.8[${MULTILIB_USEDEP}]"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( NEWS README AUTHORS )

src_unpack() {
	kernel_is -ge 4 8 && {
		EGIT_BRANCH="master"
	}
	git-r3_src_unpack
}

src_prepare() {
	default
	sed -i 's:AM_CONFIG_HEADER:AC_CONFIG_HEADERS:' configure.ac || die
	eautoreconf
}

multilib_src_configure() {
	local myeconfargs=(
	$(use_enable debug)
	$(use_enable opengl glx)
	)

	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

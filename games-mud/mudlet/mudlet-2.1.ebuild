# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games qt4-r2

DESCRIPTION="Mudlet is a quality MUD client, designed to take mudding to a new level."
HOMEPAGE="http://www.mudlet.org"
MY_P="mudlet-code-2b355dc19c2ee867733d79e18b491fb73dec17b5"
SRC_URI="http://sourceforge.net/code-snapshots/git/m/mu/mudlet/code.git/${MY_P}.zip"
S="${WORKDIR}/${MY_P}"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
	dev-lang/lua
	dev-libs/quazip
	dev-libs/yajl
	dev-libs/zziplib
	dev-qt/qtopengl:4
	dev-qt/qtphonon:4
	dev-qt/qtgui:4
	dev-qt/qtcore:4
"
RDEPEND="${DEPEND}
	dev-lua/lrexlib[pcre]
	dev-lua/luazip
	dev-lua/luafilesystem
	dev-lua/luasql[sqlite3]
"

src_configure() {
	epatch "${FILESDIR}/mudlet-lua.patch"
	epatch "${FILESDIR}/install_prefix-${PV}.patch"
	eqmake4 "${S}/src/src.pro" INSTALL_PREFIX=${INSTALL_PREFIX}
}

src_install() {
	qt4-r2_src_install

	domenu mudlet.desktop
	doicon mudlet.svg mudlet.png

	cd "${S}/src/mudlet-lua"
	for dir in lua lua/geyser; do
		insinto "/usr/share/mudlet/${dir}"
		doins $(ls -1 ${dir}/*.lua)
	done
}
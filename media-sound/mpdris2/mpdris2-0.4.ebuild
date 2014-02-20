# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

MY_PN="mpDris2"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="MPRIS V2.1 support for mpd"
HOMEPAGE="https://github.com/eonpatapon/mpDris2"
SRC_URI="http://${PN}.patapon.info/${MY_P}/${MY_P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-lang/python:2.7
	dev-python/python-mpd[python_targets_python2_7]
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/python2.patch"
	epatch "${FILESDIR}/${PV}-desktop.patch"
	epatch "${FILESDIR}/lastfm_coverfetcher.patch"
}

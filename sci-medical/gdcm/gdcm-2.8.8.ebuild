# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

# Short one-line description of this package.
DESCRIPTION="Implementation of the DICOM standard"

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="http://gdcm.sourceforge.net/"

COMMIT="2e701ed728a4d7fad9637f7d7ad76c654838c24a"

SRC_URI="https://sourceforge.net/code-snapshots/git/g/gd/gdcm/gdcm.git/gdcm-gdcm-2e701ed728a4d7fad9637f7d7ad76c654838c24a.zip -> ${PN}-${PV}.zip"

LICENSE="Apache-2.0"

SLOT="0"

KEYWORDS="~amd64"

IUSE=""

DEPEND="
	media-libs/openjpeg
	dev-libs/libxml2
	sys-libs/zlib
	app-text/poppler
	dev-libs/openssl
"
RDEPEND="${DEPEND}"

PATCHES=(
	)

src_unpack() {
	if [ "${A}"  != "" ]; then
		unpack ${A}
	fi

	mv ${WORKDIR}/gdcm-gdcm-${COMMIT} ${WORKDIR}/${PN}-${PV}
}

src_prepare() {

	cmake-utils_src_prepare
}

src_configure(){

	local mycmakeargs=()

	mycmakeargs+=(
		-BUILD_TESTING=OFF
		-DGDCM_BUILD_DOCBOOK_MANPAGES=OFF
		-DGDCM_BUILD_APPLICATIONS=OFF
		-DGDCM_BUILD_EXAMPLES=OFF
		-DGDCM_BUILD_SHARED_LIBS=ON
		-DGDCM_BUILD_TESTING=0FF
		-DGDCM_USE_VTK=OFF
		-DGDCM_USE_SYSTEM_OPENJPEG=ON
	)

	cmake-utils_src_configure
}

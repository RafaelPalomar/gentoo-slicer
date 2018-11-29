# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils multilib

# Short one-line description of this package.
DESCRIPTION="3D Slicer is an open source software platform for medical image informatics,
image processing, and three-dimensional visualization"

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://www.slicer.org/"

SRC_URI="https://github.com/Slicer/Slicer/archive/v4.10.0.zip"

LICENSE="BSD"

SLOT="0"

KEYWORDS="~amd64"

IUSE="qtloadable"

DEPEND=" sci-medical/CTK
		 sci-medical/teem
		 sci-libs/jqPlot
		 dev-vcs/subversion
		 dev-qt/qtmultimedia
		 dev-qt/qtxmlpatterns
		 dev-qt/qtsvg
		 dev-qt/qtxml
		 dev-qt/qtwebengine[widgets]
		 dev-qt/qtwebchannel
		 qtloadable? ( dev-libs/rapidjson )
"
RDEPEND="${DEPEND}"

PATCHES=(
	${FILESDIR}/${PN}-${PV}-Adding-check-of-Slicer_USE_CTKAPPLAUNCHER-variable.patch
	${FILESDIR}/${PN}-${PV}-Fixing-ITK-dependences-for-vtkITK.patch
	${FILESDIR}/${PN}-${PV}-Fixing-ITK-dependences-for-vtkTeem.patch
	${FILESDIR}/${PN}-${PV}-Fix-ITK-and-VTK-dependences-for-MRML-Core.patch
	${FILESDIR}/${PN}-${PV}-Remove-dependence-of-ctkAppLauncher-from-qSlicerCore.patch
	${FILESDIR}/${PN}-${PV}-Fix-ITK-requirements-for-Slicer-Base-QtCore.patch
	${FILESDIR}/${PN}-${PV}-Remove_CPack_from_LastConfigureStep.patch
	${FILESDIR}/${PN}-${PV}-Fix-inclusion-of-QDomDocument-in-Plots-logic.patch
)

src_unpack() {
	if [ "${A}"  != "" ]; then
		unpack ${A}
	fi

	mv ${WORKDIR}/Slicer-${PV} ${WORKDIR}/${PN}-${PV}
}

src_prepare() {

	cmake-utils_src_prepare
}

src_configure(){

	local mycmakeargs=()

	mycmakeargs+=(
		-DSlicer_SUPERBUILD=OFF
		-DBUILD_TESTING=OFF
		-DSlicer_BUILD_EXTENSIONMANAGER_SUPPORT=OFF
		-DSlicer_BUILD_CLI_SUPPORT=OFF
		-DSlicer_BUILD_CLI=OFF
		-DCMAKE_CXX_STANDARD=11
		-DSlicer_REQUIRED_QT_VERSION=5.9.6
		-DSlicer_BUILD_DICOM_SUPPORT=OFF
		-DSlicer_BUILD_ITKPython=OFF
		-DSlicer_BUILD_QTLOADABLEMODULES=$(usex qtloadable)
		-DSlicer_BUILD_QT_DESIGNER_PLUGINS=OFF
		-DSlicer_USE_CTKAPPLAUNCHER=OFF
		-DSlicer_USE_PYTHONQT=OFF
		-DSlicer_USE_QtTesting=OFF
		-DSlicer_USE_SimpleITK=OFF
		-DSlicer_VTK_RENDERING_BACKEND=OpenGL2
		-DSlicer_VTK_VERSION_MAJOR=8
		-DTeem_DIR=/usr/lib64
		-DjqPlot_DIR=/usr/share/jqPlot
		-DSlicer_INSTALL_DEVELOPMENT=ON
		-DCMAKE_INSTALL_RPATH=/usr/lib64/Slicer-4.10:/usr/lib64/ctk-0.1:/usr/lib64/Slicer-4.10/qt-loadable-modules
		-DCMAKE_BUILD_WITH_INSTALL_RPATH=ON
	)
	cmake-utils_src_configure
}

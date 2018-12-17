# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

# Short one-line description of this package.
DESCRIPTION="Insight Segmentation and Registratio Toolkit for Slicer"

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://github.com/Slicer/VTK/"

COMMIT="75414fe171e5ae2ed6e4df608deb1d578d9ec7c3"

SRC_URI="https://github.com/Slicer/VTK/archive/${COMMIT}.zip -> ${PN}-${PV}.zip"

LICENSE="Apache-2.0"

SLOT="0"

KEYWORDS="~amd64"

IUSE=""

DEPEND=">dev-cpp/eigen-3.3"
RDEPEND="${DEPEND}"

IUSE="test"

PATCHES=(
	)

src_unpack() {
	if [ "${A}"  != "" ]; then
		unpack ${A}
	fi

	mv ${WORKDIR}/${PN}-${COMMIT} ${WORKDIR}/${PN}-${PV}
}

src_prepare() {

	cmake-utils_src_prepare
}

src_configure(){

	local mycmakeargs=()

	mycmakeargs+=(
		-DBUILD_EXAMPLES=OFF
		-DBUILD_TESTING=$(usex test)
		-DBUILD_SHARED_LIBS=ON
		-DVTK_BUILD_ALL_MODULES=OFF
		-DVTK_ENABLE_KITS=ON
		-DVTK_Group_Qt=ON
		-DVTK_LEGACY_REMOVE=OFF
		-DVTK_QT_VERSION=5
		-DVTK_RENDERING_BACKEND=OpenGL2
		-DModule_vtkGUISupportQt=ON
		-DModule_vtkGUISupportQtOpenGL=ON
		-DModule_vtkGUISupportQtSQL=ON
		-DModule_vtkIOExport=ON
		-DModule_vtkIOGeometry=ON
		-DModule_vtkIOInfovis=ON
		-DModule_vtkIOPLY=On
		-DVTK_Group_StandAlone=OFF
		-DVTK_Group_Rendering=OFF
		-DModule_vtkImagingMorphological=ON
		-DModule_vtkImagingStatistics=ON
		-DModule_vtkImagingStencil=ON
		-DModule_vtkInteractionImage=ON
		-DModule_vtkRenderingFreeTypeFontConfig=ON
		-DModule_vtkRenderingQt=ON
		-DModule_vtkTestingRendering=ON
		-DModule_vtkViewsContext2D=ON
		-DModule_vtkFiltersFlowPaths=ON
		-DModule_vtkGUISupportQtWebkit=ON
		-DModule_vtkGUISupportQtOpenGL=ON
		-DVTK_USE_SYSTEM_EIGEN=ON
	)

	cmake-utils_src_configure
}

src_test()
{
	ctest
}

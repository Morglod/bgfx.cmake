# bgfx.cmake - bgfx building in cmake
# Written in 2017 by Joshua Brookover <joshua.al.brookover@gmail.com>

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

add_executable( geometryv ${BGFX_DIR}/tools/geometryv/geometryv.cpp )
set_target_properties( geometryv PROPERTIES FOLDER "bgfx/tools" )
target_link_libraries( geometryv PUBLIC example-common )
if( BGFX_CUSTOM_TARGETS )
	add_dependencies( tools geometryv )
endif()

if( ${CMAKE_SYSTEM_NAME} MATCHES iOS|tvOS )
	target_link_libraries (geometryv PUBLIC "-framework OpenGLES  -framework Metal -framework UIKit -framework CoreFoundation -framework CoreGraphics -framework QuartzCore")
elseif( APPLE )
	find_library( COCOA_LIBRARY Cocoa )
	find_library( METAL_LIBRARY Metal )
	find_library( QUARTZCORE_LIBRARY QuartzCore )
	mark_as_advanced( COCOA_LIBRARY )
	mark_as_advanced( METAL_LIBRARY )
	mark_as_advanced( QUARTZCORE_LIBRARY )
	target_link_libraries( geometryv PUBLIC ${COCOA_LIBRARY} ${METAL_LIBRARY} ${QUARTZCORE_LIBRARY} )
	target_link_libraries( geometryv PUBLIC "-framework IOKit -framework CoreFoundation" )
endif()

if (IOS)
	set_target_properties(geometryv PROPERTIES MACOSX_BUNDLE ON
										      MACOSX_BUNDLE_GUI_IDENTIFIER geometryv)
endif()

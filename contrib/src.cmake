set (TARGET_NAME soloud)

set (HEADER_PATH ../include)
set (SOURCE_PATH ../src)

set (LINK_LIBRARIES)

# Headers
set (TARGET_HEADERS
		${HEADER_PATH}/soloud.h
		${HEADER_PATH}/soloud_audiosource.h
		${HEADER_PATH}/soloud_ay.h
		${HEADER_PATH}/soloud_bassboostfilter.h
		${HEADER_PATH}/soloud_biquadresonantfilter.h
		${HEADER_PATH}/soloud_bus.h
		${HEADER_PATH}/soloud_c.h
		${HEADER_PATH}/soloud_dcremovalfilter.h
		${HEADER_PATH}/soloud_echofilter.h
		${HEADER_PATH}/soloud_error.h
		${HEADER_PATH}/soloud_fader.h
		${HEADER_PATH}/soloud_fft.h
		${HEADER_PATH}/soloud_fftfilter.h
		${HEADER_PATH}/soloud_file.h
		${HEADER_PATH}/soloud_file_hack_off.h
		${HEADER_PATH}/soloud_file_hack_on.h
		${HEADER_PATH}/soloud_filter.h
		${HEADER_PATH}/soloud_flangerfilter.h
		${HEADER_PATH}/soloud_freeverbfilter.h
		${HEADER_PATH}/soloud_internal.h
		${HEADER_PATH}/soloud_lofifilter.h
		${HEADER_PATH}/soloud_misc.h
		${HEADER_PATH}/soloud_monotone.h
		${HEADER_PATH}/soloud_noise.h
		${HEADER_PATH}/soloud_openmpt.h
		${HEADER_PATH}/soloud_queue.h
		${HEADER_PATH}/soloud_robotizefilter.h
		${HEADER_PATH}/soloud_sfxr.h
		${HEADER_PATH}/soloud_speech.h
		${HEADER_PATH}/soloud_tedsid.h
		${HEADER_PATH}/soloud_thread.h
		${HEADER_PATH}/soloud_vic.h
		${HEADER_PATH}/soloud_vizsn.h
		${HEADER_PATH}/soloud_wav.h
		${HEADER_PATH}/soloud_waveshaperfilter.h
		${HEADER_PATH}/soloud_wavstream.h
		)


# Core
set (CORE_PATH ${SOURCE_PATH}/core)
set (CORE_SOURCES
		${CORE_PATH}/soloud.cpp
		${CORE_PATH}/soloud_audiosource.cpp
		${CORE_PATH}/soloud_bus.cpp
		${CORE_PATH}/soloud_core_3d.cpp
		${CORE_PATH}/soloud_core_basicops.cpp
		${CORE_PATH}/soloud_core_faderops.cpp
		${CORE_PATH}/soloud_core_filterops.cpp
		${CORE_PATH}/soloud_core_getters.cpp
		${CORE_PATH}/soloud_core_setters.cpp
		${CORE_PATH}/soloud_core_voicegroup.cpp
		${CORE_PATH}/soloud_core_voiceops.cpp
		${CORE_PATH}/soloud_fader.cpp
		${CORE_PATH}/soloud_fft.cpp
		${CORE_PATH}/soloud_fft_lut.cpp
		${CORE_PATH}/soloud_file.cpp
		${CORE_PATH}/soloud_filter.cpp
		${CORE_PATH}/soloud_misc.cpp
		${CORE_PATH}/soloud_queue.cpp
		${CORE_PATH}/soloud_thread.cpp
		)


# Audiosources
set (AUDIOSOURCES_PATH ${SOURCE_PATH}/audiosource)
set (AUDIOSOURCES_SOURCES
		# ay
		${AUDIOSOURCES_PATH}/ay/chipplayer.cpp
		${AUDIOSOURCES_PATH}/ay/chipplayer.h
		${AUDIOSOURCES_PATH}/ay/readme.txt
		${AUDIOSOURCES_PATH}/ay/sndbuffer.cpp
		${AUDIOSOURCES_PATH}/ay/sndbuffer.h
		${AUDIOSOURCES_PATH}/ay/sndchip.cpp
		${AUDIOSOURCES_PATH}/ay/sndchip.h
		${AUDIOSOURCES_PATH}/ay/sndrender.cpp
		${AUDIOSOURCES_PATH}/ay/sndrender.h
		${AUDIOSOURCES_PATH}/ay/soloud_ay.cpp

		# monotone
		${AUDIOSOURCES_PATH}/monotone/soloud_monotone.cpp

		# noise
		${AUDIOSOURCES_PATH}/noise/soloud_noise.cpp

		# openmpt
		${AUDIOSOURCES_PATH}/openmpt/soloud_openmpt.cpp
		${AUDIOSOURCES_PATH}/openmpt/soloud_openmpt_dll.c

		# sfxr
		${AUDIOSOURCES_PATH}/sfxr/soloud_sfxr.cpp

		# speech
		${AUDIOSOURCES_PATH}/speech/Elements.def
		${AUDIOSOURCES_PATH}/speech/darray.cpp
		${AUDIOSOURCES_PATH}/speech/darray.h
		${AUDIOSOURCES_PATH}/speech/klatt.cpp
		${AUDIOSOURCES_PATH}/speech/klatt.h
		${AUDIOSOURCES_PATH}/speech/resonator.cpp
		${AUDIOSOURCES_PATH}/speech/resonator.h
		${AUDIOSOURCES_PATH}/speech/soloud_speech.cpp
		${AUDIOSOURCES_PATH}/speech/tts.cpp
		${AUDIOSOURCES_PATH}/speech/tts.h

		# tedsid
		${AUDIOSOURCES_PATH}/tedsid/sid.cpp
		${AUDIOSOURCES_PATH}/tedsid/sid.h
		${AUDIOSOURCES_PATH}/tedsid/soloud_tedsid.cpp
		${AUDIOSOURCES_PATH}/tedsid/ted.cpp
		${AUDIOSOURCES_PATH}/tedsid/ted.h

		# vic
		${AUDIOSOURCES_PATH}/vic/soloud_vic.cpp

		# vizsn
		${AUDIOSOURCES_PATH}/vizsn/soloud_vizsn.cpp

		# wav
		${AUDIOSOURCES_PATH}/wav/dr_flac.h
		${AUDIOSOURCES_PATH}/wav/dr_impl.cpp
		${AUDIOSOURCES_PATH}/wav/dr_mp3.h
		${AUDIOSOURCES_PATH}/wav/dr_wav.h
		${AUDIOSOURCES_PATH}/wav/soloud_wav.cpp
		${AUDIOSOURCES_PATH}/wav/soloud_wavstream.cpp
		${AUDIOSOURCES_PATH}/wav/stb_vorbis.c
		${AUDIOSOURCES_PATH}/wav/stb_vorbis.h
		)


# Backends
# TODO: Other backends
set (BACKENDS_PATH ${SOURCE_PATH}/backend)
set (BACKENDS_SOURCES)

if (SOLOUD_BACKEND_NULL)
	set (BACKENDS_SOURCES
			${BACKENDS_SOURCES}
			${BACKENDS_PATH}/null/soloud_null.cpp)

	add_definitions(-DWITH_NULL)
endif()

if (SOLOUD_BACKEND_SDL2)
	find_package (SDL2 REQUIRED)
	include_directories (${SDL2_INCLUDE_DIR})
	add_definitions (-DWITH_SDL2_STATIC)

	set (BACKENDS_SOURCES
			${BACKENDS_SOURCES}
			${BACKENDS_PATH}/sdl2_static/soloud_sdl2_static.cpp)

	set (LINK_LIBRARIES
			${LINK_LIBRARIES}
			${SDL2_LIBRARY})

endif()

if (SOLOUD_BACKEND_COREAUDIO)
	if (NOT APPLE)
		message (FATAL_ERROR "CoreAudio backend can be enabled only on Apple!")
	endif ()

	add_definitions (-DWITH_COREAUDIO)

	set (BACKENDS_SOURCES
			${BACKENDS_SOURCES}
			${BACKENDS_PATH}/coreaudio/soloud_coreaudio.cpp)

	find_library(AUDIO_UNIT AudioUnit)
	find_library(AUDIO_TBOX Audiotoolbox)
	message("AudioUnit:    " ${AUDIO_UNIT})
	message("Audiotoolbox: " ${AUDIO_TBOX})

	set (LINK_LIBRARIES
			${LINK_LIBRARIES}
			${AUDIO_UNIT}
			${AUDIO_TBOX})
endif()

if (SOLOUD_BACKEND_ALSA)
	find_package (ALSA REQUIRED)
	include_directories (${ALSA_INCLUDE_DIR})
	add_definitions (-DWITH_ALSA)

	set (BACKENDS_SOURCES
			${BACKENDS_SOURCES}
			${BACKENDS_PATH}/alsa/soloud_alsa.cpp)

	set (LINK_LIBRARIES
			${LINK_LIBRARIES}
			${ALSA_LIBRARY})
endif()

if (SOLOUD_BACKEND_PORTAUDIO)
	find_package (Portaudio REQUIRED)
	add_definitions (
			${PORTAUDIO_DEFINITIONS}
			-DWITH_PORTAUDIO
	)

	set (BACKENDS_SOURCES
			${BACKENDS_SOURCES}
			${BACKENDS_PATH}/portaudio/soloud_portaudio_dll.c
			${BACKENDS_PATH}/portaudio/soloud_portaudio.cpp)

	set (LINK_LIBRARIES
			${LINK_LIBRARIES}
			${PORTAUDIO_LIBRARIES}) #TODO support static and local builds of portaudio
endif()

if (SOLOUD_BACKEND_OPENSLES)
	add_definitions (-DWITH_OPENSLES)

	set (BACKENDS_SOURCES
			${BACKENDS_SOURCES}
			${BACKENDS_PATH}/opensles/soloud_opensles.cpp)

	find_library (OPENSLES_LIBRARY OpenSLES)
	set (LINK_LIBRARIES
			${LINK_LIBRARIES}
			${OPENSLES_LIBRARY})
endif()


if (SOLOUD_BACKEND_XAUDIO2)
	add_definitions (-DWITH_XAUDIO2)

	set (BACKENDS_SOURCES
			${BACKENDS_SOURCES}
			${BACKENDS_PATH}/xaudio2/soloud_xaudio2.cpp)
endif()

if (SOLOUD_BACKEND_WINMM)
	add_definitions (-DWITH_WINMM)

	set (BACKENDS_SOURCES
			${BACKENDS_SOURCES}
			${BACKENDS_PATH}/winmm/soloud_winmm.cpp)

	set (LINK_LIBRARIES
			${LINK_LIBRARIES}
			winmm)
endif()

if (SOLOUD_BACKEND_WASAPI)
	add_definitions (-DWITH_WASAPI)

	set (BACKENDS_SOURCES
			${BACKENDS_SOURCES}
			${BACKENDS_PATH}/wasapi/soloud_wasapi.cpp)
endif()

# Filters
set (FILTERS_PATH ${SOURCE_PATH}/filter)
set (FILTERS_SOURCES
		${FILTERS_PATH}/soloud_bassboostfilter.cpp
		${FILTERS_PATH}/soloud_biquadresonantfilter.cpp
		${FILTERS_PATH}/soloud_dcremovalfilter.cpp
		${FILTERS_PATH}/soloud_echofilter.cpp
		${FILTERS_PATH}/soloud_fftfilter.cpp
		${FILTERS_PATH}/soloud_flangerfilter.cpp
		${FILTERS_PATH}/soloud_freeverbfilter.cpp
		${FILTERS_PATH}/soloud_lofifilter.cpp
		${FILTERS_PATH}/soloud_robotizefilter.cpp
		${FILTERS_PATH}/soloud_waveshaperfilter.cpp
		)

# All together
source_group ("Includes"		FILES ${TARGET_HEADERS})
source_group ("Core"			FILES ${CORE_SOURCES})
source_group ("Audiosources"	FILES ${AUDIOSOURCES_SOURCES})
source_group ("Backends"		FILES ${BACKENDS_SOURCES})
source_group ("Filters"			FILES ${FILTERS_SOURCES})

set (TARGET_SOURCES
		${CORE_SOURCES}
		${AUDIOSOURCES_SOURCES}
		${BACKENDS_SOURCES}
		${FILTERS_SOURCES})

if (SOLOUD_DYNAMIC)
	set(BUILD_SHARED_LIBS true)
	set(CMAKE_SKIP_BUILD_RPATH  true)
	set(CMAKE_INSTALL_RPATH "$ORIGIN/../lib")
	add_library(${TARGET_NAME} ${TARGET_SOURCES})
endif ()

if (SOLOUD_STATIC)
	set(BUILD_SHARED_LIBS false)
	add_library(${TARGET_NAME} STATIC ${TARGET_SOURCES})
endif()

target_link_libraries(
		${TARGET_NAME}
		${LINK_LIBRARIES})

target_include_directories(
		${TARGET_NAME} SYSTEM
		PUBLIC
		$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/../include>
		$<INSTALL_INTERFACE:include>)

include(Install)
install(FILES ${TARGET_HEADERS} DESTINATION include/${TARGET_NAME})
export(TARGETS ${TARGET_NAME} FILE ${TARGET_NAME}Config.cmake)

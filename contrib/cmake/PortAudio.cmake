# cliutils.gitlab.io 2018
FIND_PACKAGE(Git QUIET)

if(GIT_FOUND AND EXISTS "${PROJECT_SOURCE_DIR}/../.git")
    # Update submodules as needed
    OPTION(GIT_SUBMODULE "Check submodules during build" ON)
    if(GIT_SUBMODULE)
        message(STATUS "Submodule updates")
        execute_process(COMMAND ${GIT_EXECUTABLE} submodule status)
        execute_process(COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive
                WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/../"
                RESULT_VARIABLE GIT_SUBMOD_RESULT)
        if(NOT GIT_SUBMOD_RESULT EQUAL "0")
            message(FATAL_ERROR "git submodule update --init failed with ${GIT_SUBMOD_RESULT}, please checkout submodules")
        endif()
    endif()
endif()

message("${GIT_SUBMODULES}")
if(NOT EXISTS "${PROJECT_SOURCE_DIR}/../ext/PortAudio/CMakeLists.txt")
    message(FATAL_ERROR "The submodules were not downloaded! GIT_SUBMODULE was turned off or failed. Please update submodules and try again.")
endif()

# IF ENABLED
IF(SOLOUD_BACKEND_PORTAUDIO)
    # IF NOT FOUND IN SYSTEM

    set(ExternalProjectCMakeArgs
            -DCMAKE_INSTALL_PREFIX=${CMAKE_SOURCE_DIR}/external
            -DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER}
            -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
            -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
            -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
            -DCBLAS_ROOT=${CBLAS_ROOT}
            -DEIGEN3_ROOT=${EIGEN3_ROOT}
            )

    #add_external(pcmsolver "")
ENDIF()


   # IF NOT ALREADY DOWNLOADED
     # GIT CLONE OR USE SUBMODULE
   # BUILD
execute_process(COMMAND "/home/krishna/Downloads/final_pkg_ws/build/skiros2_gui/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/krishna/Downloads/final_pkg_ws/build/skiros2_gui/catkin_generated/python_distutils_install.sh) returned error code ")
endif()

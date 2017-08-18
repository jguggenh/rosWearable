# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "readEMG: 1 messages, 0 services")

set(MSG_I_FLAGS "-IreadEMG:/home/jacob/rosWearableWS/src/readEMG/msg;-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(readEMG_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/jacob/rosWearableWS/src/readEMG/msg/EMG.msg" NAME_WE)
add_custom_target(_readEMG_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "readEMG" "/home/jacob/rosWearableWS/src/readEMG/msg/EMG.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(readEMG
  "/home/jacob/rosWearableWS/src/readEMG/msg/EMG.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/readEMG
)

### Generating Services

### Generating Module File
_generate_module_cpp(readEMG
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/readEMG
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(readEMG_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(readEMG_generate_messages readEMG_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/jacob/rosWearableWS/src/readEMG/msg/EMG.msg" NAME_WE)
add_dependencies(readEMG_generate_messages_cpp _readEMG_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(readEMG_gencpp)
add_dependencies(readEMG_gencpp readEMG_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS readEMG_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(readEMG
  "/home/jacob/rosWearableWS/src/readEMG/msg/EMG.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/readEMG
)

### Generating Services

### Generating Module File
_generate_module_eus(readEMG
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/readEMG
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(readEMG_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(readEMG_generate_messages readEMG_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/jacob/rosWearableWS/src/readEMG/msg/EMG.msg" NAME_WE)
add_dependencies(readEMG_generate_messages_eus _readEMG_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(readEMG_geneus)
add_dependencies(readEMG_geneus readEMG_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS readEMG_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(readEMG
  "/home/jacob/rosWearableWS/src/readEMG/msg/EMG.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/readEMG
)

### Generating Services

### Generating Module File
_generate_module_lisp(readEMG
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/readEMG
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(readEMG_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(readEMG_generate_messages readEMG_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/jacob/rosWearableWS/src/readEMG/msg/EMG.msg" NAME_WE)
add_dependencies(readEMG_generate_messages_lisp _readEMG_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(readEMG_genlisp)
add_dependencies(readEMG_genlisp readEMG_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS readEMG_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(readEMG
  "/home/jacob/rosWearableWS/src/readEMG/msg/EMG.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/readEMG
)

### Generating Services

### Generating Module File
_generate_module_nodejs(readEMG
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/readEMG
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(readEMG_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(readEMG_generate_messages readEMG_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/jacob/rosWearableWS/src/readEMG/msg/EMG.msg" NAME_WE)
add_dependencies(readEMG_generate_messages_nodejs _readEMG_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(readEMG_gennodejs)
add_dependencies(readEMG_gennodejs readEMG_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS readEMG_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(readEMG
  "/home/jacob/rosWearableWS/src/readEMG/msg/EMG.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/readEMG
)

### Generating Services

### Generating Module File
_generate_module_py(readEMG
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/readEMG
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(readEMG_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(readEMG_generate_messages readEMG_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/jacob/rosWearableWS/src/readEMG/msg/EMG.msg" NAME_WE)
add_dependencies(readEMG_generate_messages_py _readEMG_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(readEMG_genpy)
add_dependencies(readEMG_genpy readEMG_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS readEMG_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/readEMG)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/readEMG
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(readEMG_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/readEMG)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/readEMG
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(readEMG_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/readEMG)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/readEMG
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(readEMG_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/readEMG)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/readEMG
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(readEMG_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/readEMG)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/readEMG\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/readEMG
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(readEMG_generate_messages_py std_msgs_generate_messages_py)
endif()

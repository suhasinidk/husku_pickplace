#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/krishna/Downloads/final_pkg_ws/src/paintbot/skiros-demo/src/skiros2/skiros2_test_lib"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/krishna/Downloads/final_pkg_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/krishna/Downloads/final_pkg_ws/install/lib/python2.7/dist-packages:/home/krishna/Downloads/final_pkg_ws/build/skiros2_test_lib/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/krishna/Downloads/final_pkg_ws/build/skiros2_test_lib" \
    "/usr/bin/python2" \
    "/home/krishna/Downloads/final_pkg_ws/src/paintbot/skiros-demo/src/skiros2/skiros2_test_lib/setup.py" \
     \
    build --build-base "/home/krishna/Downloads/final_pkg_ws/build/skiros2_test_lib" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/krishna/Downloads/final_pkg_ws/install" --install-scripts="/home/krishna/Downloads/final_pkg_ws/install/bin"

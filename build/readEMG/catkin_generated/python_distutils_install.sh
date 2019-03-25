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
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/jacob/rosWearableWS/src/readEMG"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/jacob/rosWearableWS/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/jacob/rosWearableWS/install/lib/python2.7/dist-packages:/home/jacob/rosWearableWS/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/jacob/rosWearableWS/build" \
    "/usr/bin/python" \
    "/home/jacob/rosWearableWS/src/readEMG/setup.py" \
    build --build-base "/home/jacob/rosWearableWS/build/readEMG" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/jacob/rosWearableWS/install" --install-scripts="/home/jacob/rosWearableWS/install/bin"

#!/bin/sh
echo "_____________________________________________________________________________________________________________"
echo ' __    __  __      ______ __  __       ______  ______  __   __  ______ ______  __  __   __  ______  ______    '
echo '/\ "-./  \/\ \    /\__  _/\ \/ /      /\  ___\/\  __ \/\ "-.\ \/\__  _/\  __ \/\ \/\ "-.\ \/\  ___\/\  == \   '
echo '\ \ \-./\ \ \ \___\/_/\ \\\ \  _"-.    \ \ \___\ \ \/\ \ \ \-.  \/_/\ \\\ \  __ \ \ \ \ \-.  \ \  __\\\ \  __<   '
echo ' \ \_\ \ \_\ \_____\ \ \_\\\ \_\ \_\    \ \_____\ \_____\ \_\\\"\_\ \ \_\\\ \_\ \_\ \_\ \_\\\"\_\ \_____\ \_\ \_\ '
echo '  \/_/  \/_/\/_____/  \/_/ \/_/\/_/     \/_____/\/_____/\/_/ \/_/  \/_/ \/_/\/_/\/_/\/_/ \/_/\/_____/\/_/ /_/ '
echo "_____________________________________________________________________________________________________________"
echo "Splunk> MLTK Container for TensorFlow 2.0, PyTorch and Jupyterlab."
tag="jupyterhub"
base="jupyterhub/jupyterhub"
dockerfile="Dockerfile.5.1.0.hub"
repo="phdrieger/"
if [ -z "$1" ]; then
  echo "No build parameters set. Using default tag jupyterhub for building and running the container."
  echo "You can use ./build.sh [jupyterhub] to build the container."
else
  tag="$1"
fi
case $tag in
	jupyterhub)
		base="jupyterhub/jupyterhub"
		dockerfile="Dockerfile.5.1.0.hub"
		;;
	*)
		echo "Invalid container image tag: $tag, expected [jupyterhub]"
    	break
		;;
esac
if [ -z "$2" ]; then
  echo "No target repo set, using default prefix phdrieger/"
  repo="phdrieger/"
else
  repo="$2"
fi
echo "Using tag [$tag] for building container based on [$base]"
echo "Stop, remove and build container..."
docker stop "$repo"mltk-container-$tag
docker rm "$repo"mltk-container-$tag
docker rmi "$repo"mltk-container-$tag
docker build --rm -t "$repo"mltk-container-$tag:latest --build-arg BASE_IMAGE=$base --build-arg TAG=$tag -f $dockerfile .
if [ -z "$3" ]; then
  version=""
else
  version="$3"
  docker tag "$repo"mltk-container-$tag:latest "$repo"mltk-container-$tag:$version
fi

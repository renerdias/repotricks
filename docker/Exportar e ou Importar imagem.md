

You will need to save the Docker image as a tar file:

docker save -o <path for generated tar file> <image name>

Then copy your image to a new system with regular file transfer tools such as cp, scp, or rsync (preferred for big files). After that you will have to load the image into Docker:

docker load -i <path to image tar file>

You should add filename (not just directory) with -o, for example:

docker save -o c:/myfile.tar centos:16

your image syntax may need the repository prefix (:latest tag is default)

docker save -o C:\path\to\file.tar repository/imagename

PS: You may need to sudo all commands.

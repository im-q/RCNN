### For initial Jetson hardware setup instructions, visit the [wiki Home](https://github.com/open-horizon/cogwerx-jetson-tx2/wiki)

### Docker build instructions and files for deep learning container images
* Jetson TX2 (base)
* CUDA, CUDNN, OpenCV and supporting libs, full and lean variants
* Caffe deep learning framework
* Darknet deep learning framework with Yolo
* NVIDIA Tools: DIGITS, and TensorRT library containers

These docker images are also available at the public openhorizon Docker [registry](https://hub.docker.com/u/openhorizon/) as part of the [Horizon](https://bluehorizon.network) project.


#### To build docker images (some successive images depend on previous. See below for prereqs)

1. Clone this repo locally
2. Build the base Jetson TX2 image. This base image is the prerequisite for later containers like Caffe, Darknet, and other deep learning frameworks
```
docker build -f Dockerfile.cudabase -t openhorizon/aarch64-tx2-cudabase .
```

This CUDNN container is the basis of builds for the containers below:
* BVLC's Caffe
* NVIDIA's Caffe
* Darknet (Yolo)

-----------------------------------------

### Caffe builds
To build Berkley's (BVLC) Caffe container:
1. First build the Jetson TX2 container with CUDNN: aarch64-tx2 (see above)
2. Build the BVLC Caffe container:
```
cd caffe
docker build -f Dockerfile.caffe -t openhorizon/aarch64-tx2-caffe .
```

To build a container with NVIDIA's Caffe: 
1. First build the Jetson TX2 Cudabase container with CUDNN (see above)
2. Build the NVIDIA Caffe container:
```
docker build -f Dockerfile.nvidia.caffe -t openhorizon/aarch64-tx2-nvidia-caffe .
```

### NVIDIA DIGITS
To build NVIDIA DIGITS:
1. First build the NVIDIA Caffe container (see above)
2. Build the NVIDIA DIGITS container:
```
docker build -f Dockerfile.digits -t openhorizon/aarch64-tx2-digits .
```

### Darknet with Yolo
To build darknet with Yolo:
1. First build the Jetson TX2 Cudabase container with CUDNN (see above)
2. Build darknet container:
```
cd darknet
docker build -f Dockerfile.darknet-tx2 -t openhorizon/aarch64-tx2-darknet .
```

### DustyNV's container:
To build Dusty NV's container:
1. First build the 'tensorrt-tx2' container [TensorRT](https://developer.nvidia.com/tensorrt)
```
cd tensorrt
docker build -f Dockerfile.tensorrt -t openhorizon/aarch64-tx2-tensorrt .
cd ../
```

2. Build Dusty NV's container:
```
cd dustyinference
docker build -f Dockerfile.dustyinference -t openhorizon/aarch64-tx2-dustyinference .
```


------------------------------------------------
#### Optional base images:
Base drivers container (smallest): aarch64-tx2-drivers
```
docker build -f Dockerfile.drivers -t openhorizon/aarch64-tx2-drivers .
```

Base CUDA container: openhorizon/aarch64-tx2-cudabase (for OpenCV4Tegra build, and other builds requiring CUDA/CUDNN)
```
docker build -f Dockerfile.cudabase -t openhorizon/aarch64-tx2-cudabase .
cd caffe
docker build -f Dockerfile.opencv4tegra.caffe -t openhorizon/aarch64-tx2-opencv4 .
```

-------------------------------------------------
## Validating
To test the speed of AlexNet on the GPU:
```
docker run --privileged --rm openhorizon/aarch64-tx2-caffe /caffe/build/tools/caffe time --model=/caffe/models/bvlc_alexnet/deploy.prototxt --gpu=0
```
To do the same on the CPU:
```
docker run --privileged --rm openhorizon/aarch64-tx2-caffe /caffe/build/tools/caffe time --model=/caffe/models/bvlc_alexnet/deploy.prototxt
```

To run Digits:
```
docker run --privileged --name digits -p 5001:5001 -d openhorizon/aarch64-tx2-digits
# Now you can connect to http://jetsonip:5001 using your browser 
```

To run Yolo:
```
# as root on host TX2 allow x, e.g. 'xhost +'
# then, assuming you have a usb webcam hooked up:
# tiny yolo model against the VOC data set is the fastest (only 20 classes though)
xhost + && docker run --privileged -e DISPLAY=$DISPLAY -v /tmp:/tmp --rm openhorizon/aarch64-tx2-darknet /darknet/darknet detector demo -c 1 cfg/voc.data cfg/tiny-yolo-voc.cfg tiny-yolo-voc.weights
# regular yolo model is much more accurate and against MS COCO 91 classes; however, 2x slower in my tests:
xhost + && docker run --privileged -e DISPLAY=$DISPLAY -v /tmp:/tmp --rm openhorizon/aarch64-tx2-darknet /darknet/darknet detector demo -c 1 cfg/coco.data cfg/yolo.cfg yolo.weights
```

To run DustyNV's container:
```
xhost + && docker run --privileged -v /dev:/dev -e DISPLAY=$DISPLAY -v /tmp:/tmp --net=host --ipc=host --rm -ti openhorizon/aarch64-tx2-dustyinference bash -c "cd /jetson-inference/build/aarch64/bin && ./imagenet-camera"
```

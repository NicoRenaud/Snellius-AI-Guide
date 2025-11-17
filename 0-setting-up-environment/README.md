# 0. Setting up the environment

We recommend to run machine learning pipelines on Snellius using isolated environments in the form of container images with a set of Python packages. Snellius uses the [Apptainer](https://apptainer.org) container runtime. Containers can be seen as encapsulated images of a specific environment including all required libraries, tools and Python packages. Container images can be based on virtually any Linux distribution targeting the host architecture, but they still rely on the host kernel and kernel drivers.

## Building the containerized environment

Snellius does not provide managed containers, so users must create their own depending on their needs. The script `build_container.sh` can readily be executed to create such container. For the base container, we pull the latest NGC PyTorch container from [here](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/pytorch).
Both downloading and installing the container with additional Python packages can be done like:

```bash
sbatch build_container.job
```

Note that you have to edit the `build_container.job` file to export your project space:

```bash
export PROJECT_SPACE=/projects/0/prjsXXXX
```

You can leave the corresponding lines in the file commented if you have enter your path in your bashrc.
By default, the container will be stored on your project space in the `container` folder

Extra dependencies, such as your own python package can be added to the environment in the `%post` section by adding the command

```bash
pip install my_awsome_package
``` 

## Interacting with a containerized environment

The Python environment from an image can be accessed either interactively by spawning a shell instance within a container (`apptainer shell` command) or by executing commands within a container (`apptainer exec` command). Do not expect there to be premade runscripts (`apptainer run` command) within the container; you need to execute your own script inside the container.

To inspect which specific packages are included in the images you can use this simple command:

```
export CONTAINER=$PROJECT_SPACE/container/snellius-ai-guide-torch-2.7-nvcr.25-10.sif
apptainer exec $CONTAINER bash -c 'pip list'
``` 
## Installing additional Python packages in a container 

You might find yourself in a situation where you want to install extra package inside your container. The first option is of course to build your image once again after adding the desired python packages to the `%post` section of the `build_container.sh` script. Another option is to use a virtual environment on top of the conda environment. For this example, we want to add the HDF5 Python package `h5py` to the environment:

```
export CONTAINER=$PROJECT_SPACE/container/snellius-ai-guide-torch-2.7-nvcr.25-10.sif
apptainer shell $CONTAINER
(pytorch) apptainer> python -m venv h5-env --system-site-packages
(pytorch) apptainer> source h5-env/bin/activate
(h5-env) (pytorch) apptainer> pip install h5py
```

This will create an `h5-env` environment in the working directory. The `--system-site-packages` flag gives the virtual environment access to the packages from the container. Now one can execute a script with and import the `h5py` package. To execute a script called `my-script.py` within the container using the virtual environment, use the additional activation command:

```
apptainer exec $CONTAINER bash -c 'source h5-env/bin/activate && python my-script.py'
```

This approach allows extending the environment without rebuilding the container from scratch every time a new package is added. The drawback is that the virtual environment is disjoint from the container, which makes it difficult to move as the path to the virtual environment needs to be updated accordingly. Moreover, installing Python packages typically creates thousands of small files. This puts a lot of strain on the Lustre file system and might exceed your file quota. 



### Table of contents

- [Home](..#readme)
- [1. QuickStart](https://github.com/Lumi-supercomputer/LUMI-AI-Guide/tree/main/1-quickstart#readme)
- [2. Setting up your own environment](https://github.com/Lumi-supercomputer/LUMI-AI-Guide/tree/main/2-setting-up-environment#readme)
- [3. File formats for training data](https://github.com/Lumi-supercomputer/LUMI-AI-Guide/tree/main/3-file-formats#readme)
- [4. Data Storage Options](https://github.com/Lumi-supercomputer/LUMI-AI-Guide/tree/main/4-data-storage#readme)
- [5. Multi-GPU and Multi-Node Training](https://github.com/Lumi-supercomputer/LUMI-AI-Guide/tree/main/5-multi-gpu-and-node#readme)
- [6. Monitoring and Profiling jobs](https://github.com/Lumi-supercomputer/LUMI-AI-Guide/tree/main/6-monitoring-and-profiling#readme)
- [7. TensorBoard visualization](https://github.com/Lumi-supercomputer/LUMI-AI-Guide/tree/main/7-TensorBoard-visualization#readme)
- [8. MLflow visualization](https://github.com/Lumi-supercomputer/LUMI-AI-Guide/tree/main/8-MLflow-visualization#readme)
- [9. Wandb visualization](https://github.com/Lumi-supercomputer/LUMI-AI-Guide/tree/main/9-Wandb-visualization#readme)

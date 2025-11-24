# 1. Downloading the data  

Most machine learning pipelines require the use of a large dataset to train the model. In this tutorial, we are using HuggingFace's [tiny-imagenet-200](https://huggingface.co/datasets/slegroux/tiny-imagenet-200-clean) dataset.  To download this dataset simply use the prvided bash script:

```bash
sbatch download_data.job
```

As before, don't forget to edit the job file with the path of your project space:

```bash
export PROJECT_SPACE=/projects/0/prjsXXXX
```

Please have a look at the terms of access for the ImageNet Dataset [here](https://www.image-net.org/download.php).

## Binding folers to the container 

If you look at the the shell script we have provided you will notice that we are using new arguments in the `apptainer` call:

```bash
apptainer exec --env "PROJECT_SPACE=$PROJECT_SPACE" -B $BIND_PATH $CONTAINER python download_data.py
```

Fist the command `apptainer exec` will execute the command entered at the end of the line, in our case `python download.py`. The `--env` argument is here used to specify a new environment variable within the container. This is sometimes handy to commnicate variables form your shell script to the container.

More importantly, we use here the command `-B $BIND_PATH` this allows us to bind the folder specified by `$BIND_PATH` to the container. A bare containder doesn't have access to any of your folder. If you need to access specific folders during the execution of the command, in our case here where to store the dataset, you must bind this folder to the container with the `-B` option.  



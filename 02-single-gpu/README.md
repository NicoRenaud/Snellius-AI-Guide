# 2. First Run on a single GPU

In this first example we are training a vision transformer on the [Tiny ImageNet Dataset](https://paperswithcode.com/dataset/tiny-imagenet) we have just downloaded. This example is similar to the code you can already run on your laptop using a single GPU or CPU. The next chapters will explain how to scale up this training run to use multiple gpus on multiple nodes.

To run the Vision Transformer example, we need to use the provided batch job script [`run.sh`](run.sh) that you can use to run the [`visiontransformer.py`](visiontransformer.py) script on a single GPU.

To run the provided script yourself, you first need to edit the script to add your project space:

```bash
export PROJECT_SPACE=/projects/0/prjsXXXX
```

You can submit then the job to the Snellius scheduler by running:

```bash
sbatch run.sh
```

Note that in the shell script we have provided, we are binding the path to the dataset to the container with the command:

```bash
apptainer exec -B $BIND_PATH $CONTAINER python ....
```

As explained in the previous chapter, the `-B` option allows to bind the directory specified by `$BIND_PATH` to the container so that our python script can access the datra stored there. 

Once the job starts running, a `slurm-<jobid>.out` file will be created in this directory. This file contains the output of the job and will be updated as the job progresses. The output will show Loss and Accuracy values for each epoch, similar to the following:

```bash
Epoch 1, Loss: 4.68622251625061
Accuracy: 9.57%
Epoch 2, Loss: 4.104039922332763
Accuracy: 15.795%
Epoch 3, Loss: 3.7419378942489625
Accuracy: 19.525%
Epoch 4, Loss: 3.6926351853370667
Accuracy: 21.265%
...
```

Congratulations! You have run your first training job on Snellius. 


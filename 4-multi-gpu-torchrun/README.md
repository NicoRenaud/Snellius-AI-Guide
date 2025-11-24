# 4. Multi GPUs run using torchrun

PyTorch provides a dedicated executable so simpligy the deployment of multi-gpu runs. This tool, `torchrun` replace part of the scheduling done otherwise by SLURM. A few modifications are therefore required

## Job submission script

Since torchrun will take care of the task scheduling we only ask 1 task per node in the job script

```bash
#SBATCH --ntasks-per-node=1
```

Since we want to use all the GPUs of the node we keep `#SBATCH --gpus-per-node=4` and all the other options the same as before. 

Instead of executing our python script we are now using `torchrun` with:

```bash
srun apptainer exec --nv -B $BIND_PATH $CONTAINER torchrun \
        --standalone \
        --nnodes=1 \
        --nproc_per_node=4 \
        ddp_visiontransformer.py --data_path $IMAGENET
```


## Python script

One major change compared to the previous chapter is that `torchrun` automatically defines the environment varialbles `RANK` and `LOCAL_RANK` that we can use in the python script. So we for example read the local rank from the LOCAL_RANK environment variable instead of the SLURM variables:

```python
local_rank = int(os.environ['LOCAL_RANK'])
torch.cuda.set_device(local_rank)
```
# 4. Multi Nodes run using torchrun

One great advantage of `torchrun` is that it allows to easily deploy runs over multiple nodes with a few simple modifications of the submission script. As you can see in the script most of the job submission remains the same as for a singe node run using torchrun. The main difference comes in the argument used for torchrun:

```bash
srun apptainer exec --nv -B $BIND_PATH $CONTAINER torchrun \
	--nnodes=$SLURM_JOB_NUM_NODES \
	--nproc_per_node=4 \
	--rdzv_id=\$SLURM_JOB_ID \
	--rdzv_backend=c10d \
	--rdzv_endpoint="$MASTER_ADDR:$MASTER_PORT" \
	ddp_visiontransformer.py --data_path $IMAGENET --num_workers 7
```

To orchestrate a multi-node run,. `torchrun` needs to know the _rendez-vous_ (`rdzvs`) adresses of the master process and the of the other ones. This is what the new argument of `torchrun` provides. In the vast majority of cases the values of the arguments provided here can be used safely. 

Note as well that we set the number of workers to 7. This means that each process  will use 8 CPUs (7 workers + 1 master). Since we have 4 processes, one for each GPUs we have set the number of `cpus-per-tasks` to 32. This is because from a SLURM perspective we have 1 task per node, `torchrun`. 

We of course require to use mutliple nodes (here 2):

```bash
#SBATCH --nodes=2
```
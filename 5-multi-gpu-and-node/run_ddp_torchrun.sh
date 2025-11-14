#!/bin/bash
#SBATCH --partition=gpu_h100
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=16
#SBATCH --gpus-per-node=4
#SBATCH --time=1:00:00
#SBATCH --exclusive



# enter your project space path e.g. PROJECT_SPACE=/projects/0/prjsXXXX
# if you didn't add the path to your bashrc
PROJECT_SPACE=/scratch-shared/nicolasr

if [ -z "$PROJECT_SPACE" ]; then
  echo "Error: PROJECT_SPACE is not set. Please set the project space path in this script. Example: export PROJECT_SPACE=/projects/0/prjsXXXX"
  exit 1
fi

CONTAINER=$PROJECT_SPACE/containers/snellius-ai-guide-torch-2.7-nvcr.25-10.sif
IMAGENET=$PROJECT_SPACE/datasets/imagenet/tiny-imagenet-200.hf
WORKERS=${SLURM_CPUS_PER_TASK:-16}
BIND_PATH=$PROJECT_SPACE

# Tell RCCL to use Slingshot interfaces and GPU RDMA
export NCCL_SOCKET_IFNAME=hsn0,hsn1,hsn2,hsn3
export NCCL_NET_GDR_LEVEL=PHB

apptainer exec -B $BIND_PATH $CONTAINER bash -c 'python -m torch.distributed.run --standalone --nnodes=1 --nproc_per_node=8 ddp_visiontransformer.py'

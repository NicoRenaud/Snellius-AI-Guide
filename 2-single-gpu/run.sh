#!/bin/bash
#SBATCH --nodes=1
#SBATCH --partition=gpu_a100
#SBATCH --gpus-per-task=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --time=10:00:00

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

apptainer exec -B $BIND_PATH $CONTAINER python visiontransformer.py --data_path $IMAGENET --num_workers $WORKERS

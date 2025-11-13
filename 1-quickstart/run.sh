#!/bin/bash
#SBATCH --nodes=1
#SBATCH --partition=rome
#SBATCH --ntasks-per-node=1
#SBATCH --time=10:00:00
#SBATCH --exclusive

# enter your project space path e.g. PROJECT_SPACE=/projects/0/prjsXXXX
# if you didn't add the path to your bashrc
PROJECT_SPACE=/scracth-shared/nicolasr

if [ -z "$PROJECT_SPACE" ]; then
  echo "Error: PROJECT_SPACE is not set. Please set the project space path in this script. Example: export PROJECT_SPACE=/projects/0/prjsXXXX"
  exit 1
fi


CONTAINER=$PROJECT_SPACE/containers/snellius-ai-guide-torch-2.7-nvcr.25-10.sif
IMAGENET=$PROJECT_SPACE/datasets/imagenet/imagenet-200.hf
WORKERS=${SLURM_CPUS_PER_TASK:-16}
BIND_PATH=$PROJECT_SPACE

apptainer exec -B $BIND_PATH $CONTAINER python visiontransformer.py --data_path $IMAGENET --workers $WORKERS

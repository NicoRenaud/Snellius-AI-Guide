# Snellius AI guide


This Guide is adapted from the excellent [LUMI-AI-Guide](https://github.com/Lumi-supercomputer/LUMI-AI-Guide)

This guide is designed to assist users in migrating their machine learning applications from smaller-scale computing environments to Snellius. We will walk you through a detailed example of training an image classification model using [PyTorch's Vision Transformer (VIT)](https://pytorch.org/vision/main/models/vision_transformer.html) on the [ImageNet dataset](https://www.image-net.org/).

All Python and bash scripts referenced in this guide are accessible in this [GitHub repository](https://github.com/surf-ml/snellius-ai-guide/tree/main). We start with a basic python script, [visiontransformer.py](2-first-run/visiontransformer.py), that could run on your local machine and modify it over the next chapters to run it efficiently on Snellius.

Even though this guide uses PyTorch, most of the covered topics are independent of the used machine learning framework. We therefore believe this guide is helpful for all new ML users on Snellius while also providing a concrete example that runs on Snellius.

### Requirements

Before proceeding, please ensure you meet the following prerequisites:

* A basic understanding of machine learning concepts and Python programming. This guide will focus primarily on aspects specific to training models on Snellius.
* An active user account on Snellius and familiarity with its basic operations.
* If you wish to run the included examples, you need to be part of a project with GPU hours on Snellius.


### Set up

To use this tutorial, you must first clone this repository to your Snellius via the following command:

```bash
git clone https://github.com/surf-ml/Snellius-AI-guide
```

We recommend using your `/project/` or `/scratch-shared/` directory to clone the repository as your home directory (`$HOME`) has a capacity of 20 GB and is intended to store user configuration files and personal data.


### Table of contents

The guide is structured into the following sections:

- [00. Setting up the environment](00-setting-up-environement/README.md)
- [01. Downloading the data](01-downloading-data/README.md)
- [02. Single CPU/GPU run](02-single-gpu/README.md)
- [03. Multi GPU run with srun](03-multi-gpu-srun/README.md)
- [04. Multi GPU run with torchrun](04-multi-gpu-torchrun/README.md)
- [05. Multi Node run with torchrun](05-multi-nodes-torchrun/README.md)
- [06. Multi Node run with deepspeed](05-multi-nodes-deepspeed/README.md)  
- [07. Monitoring and Profiling jobs](07-monitoring-and-profiling/README.md)
- [08. TensorBoard visualization](08-TensorBoard-visualization/README.md)
- [09. MLflow visualization](09-MLflow-visualization/README.md)
- [10. Wandb visualization](10-Wandb-visualization/README.md)
  
### Further reading

- [Snellius Documentation](https://servicedesk.surf.nl/wiki/spaces/WIKI/pages/30660184/Snellius)

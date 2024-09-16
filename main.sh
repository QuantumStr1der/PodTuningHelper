#!/bin/bash
set +x

# Check if a Hugging Face token is provided
if [ -z "$1" ]; then
  echo "Error: Hugging Face token is required as the first argument."
  exit 1
fi

HUGGINGFACE_TOKEN=$1

# Ask for the LoRA trigger word
read -p "Enter the trigger word for your LoRA: " trigger

sed -i "s/m0del/$trigger/g" PodTuningHelper/config.env
sed -i "s/m0del/$trigger/g" PodTuningHelper/multidatabackend.json

# Install SimpleTuner and dependencies
apt update
apt install unzip
git clone --branch=release https://github.com/bghira/SimpleTuner.git
cd SimpleTuner || exit
git checkout a2b170ef4e41bab6269110189f86f297a9484d96
python -m venv .venv
source .venv/bin/activate
pip install -U poetry pip
poetry install --no-root
pip install optimum-quanto
cd ..

# Create folders and move files
mv PodTuningHelper/config.env SimpleTuner/config
mv PodTuningHelper/multidatabackend.json SimpleTuner/config
mkdir -p SimpleTuner/datasets/"$trigger"
unzip PodTuningHelper/dataset.zip -d SimpleTuner/datasets/"$trigger"
mkdir -p SimpleTuner/cache/vae/"$trigger"
mkdir -p SimpleTuner/cache/text/"$trigger"

# Log into Hugging Face using the passed token
huggingface-cli login --token $HUGGINGFACE_TOKEN

# Disable W&B visualization
export WANDB_MODE=disabled

# Start training
cd SimpleTuner || exit
bash train.sh
echo -e "\n\e[32mTraining Complete:\e[0m Go to SimpleTuner/outputs/models to view and save checkpoints\n"

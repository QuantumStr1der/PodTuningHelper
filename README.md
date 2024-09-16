# PodTuningHelper
A simple tool designed to streamline the setup and configuration of SimpleTuner + Flux on RunPod. Perfect for those looking to accelerate and simplify their LoRA (Low-Rank Adaptation) tasks on RunPod.

# How to Use
**Before using make sure to accept EULA for Flux dev model on Hugging Face, otherwise SimpleTuner will not be able to access and download the model.*

1. Deploy your Run Pod instance, connect to Jupyter Lab and open a terminal in workspace.
2. Clone this repository into workspace.
`git clone https://github.com/QuantumStr1der/PodTuningHelper.git`
3. Upload your dataset as an archive under the PodTuningHelper folder named `dataset.zip`.
4. Run `bash PodTuningHelper/main.sh HUGGINGFACE_TOKEN` with `HUGGINGFACE_TOKEN` as your Hugging Face access token from the same account you accepted the Flux EULA on.
5. PodTuningHelper will install SimpleTuner, connect to Hugging Face, and start training your LoRA, checkpoints  save to `SimpleTuner/outputs`

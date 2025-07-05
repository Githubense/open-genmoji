#!/bin/bash
# OpenGenmoji Quick Start Script
# Run this to activate the environment and generate an emoji

echo "🚀 OpenGenmoji Environment Setup"
echo "================================"

# Activate conda environment
source /opt/anaconda3/etc/profile.d/conda.sh
conda activate OpenGenmoji

echo "✅ Environment activated: OpenGenmoji"
echo "✅ Python: $(python --version)"

# Check available LoRA models
echo ""
echo "📦 Available LoRA Models:"
ls -la lora/*.safetensors

echo ""
echo "🎨 Example Usage:"
echo "python genmoji.py 'emoji of happy cat' --direct --lora diverse-emoji"
echo "python genmoji.py 'emoji of flying pig' --direct --lora flux-dev --width 160 --height 160 --upscale 5"

echo ""
echo "📝 Generated emojis will be saved in: output/"
echo "🔧 For iOS development, see: iOS_SETUP_NOTES.md"

echo ""
echo "💡 Quick Test (uncomment to run):"
echo "# python genmoji.py 'emoji of smiling sun' --direct --lora diverse-emoji --width 160 --height 160 --upscale 2"

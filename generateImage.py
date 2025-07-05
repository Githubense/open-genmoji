from mflux import Flux1, Config, ModelConfig
import os


def generate_image(prompt: str, lora: str, width: int, height: int):
    # Load the model with aggressive memory optimization
    flux = Flux1(
        model_config=ModelConfig.dev(),
        quantize=4,  # More aggressive quantization (4-bit instead of 8-bit)
        lora_paths=[
            f"{os.path.abspath(os.path.dirname(__file__))}/lora/{lora}.safetensors"
        ],
        lora_scales=[1.0],
    )

    # Generate an image with reduced inference steps for memory efficiency
    image = flux.generate_image(
        seed=7,
        prompt=prompt,
        config=Config(
            num_inference_steps=20,  # Reduced from 20 to 10 for faster/less memory usage
            height=width,
            width=height,
        ),
    )

    return image.image

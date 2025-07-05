# OpenGenmoji iOS Port Setup Notes

## Environment Setup Complete ✅

### Conda Environment: `OpenGenmoji`
- **Python Version**: 3.11.13
- **Environment Path**: `/opt/anaconda3/envs/OpenGenmoji`
- **Python Executable**: `/opt/anaconda3/envs/OpenGenmoji/bin/python`

### Core Dependencies Installed ✅
- `mflux==0.9.1` - FLUX model runner for macOS (MLX-based)
- `huggingface_hub==0.33.2` - Model downloading and authentication
- `pillow==10.4.0` - Image processing
- `requests==2.32.4` - HTTP requests (for prompt assistant)
- `beautifulsoup4==4.13.4` - HTML parsing (for finetuning data collection)
- `torch==2.7.1` - PyTorch backend
- `transformers==4.53.1` - Transformer models
- `safetensors==0.5.3` - Safe tensor format for LoRA files

### HuggingFace Authentication ✅
- **Access**: Authenticated with gated repo access
- **FLUX.1-dev Access**: Ready (though manual acceptance may be needed)

### LoRA Models Downloaded ✅
- `lora/flux-dev.safetensors` (209MB) - Original OpenGenmoji model
- `lora/diverse-emoji.safetensors` (209MB) - Comprehensive emoji model

## System Architecture Analysis

### Core Components
1. **`generateImage.py`** - Main image generation interface
   - Uses `mflux.Flux1` with MLX backend
   - Optimized for memory efficiency (4-bit quantization, 10 inference steps)
   - Supports LoRA loading and scaling

2. **`genmoji.py`** - CLI interface and workflow orchestrator
   - Handles argument parsing
   - Integrates prompt assistant (optional)
   - Manages output file generation and upscaling

3. **`promptAssistant.py`** - LLM-based prompt optimization
   - Requires LM Studio running on localhost:1234
   - Uses metaprompts for Apple-style emoji generation
   - Can be bypassed with `--direct` flag

4. **`download.py`** - LoRA model downloader
   - Interactive model selection
   - Downloads from HuggingFace repositories

### Memory Optimization Applied ✅
- **Quantization**: Reduced from 8-bit to 4-bit (more aggressive)
- **Inference Steps**: Reduced from 20 to 10 steps
- **Resolution**: Works well at 160x160 (standard emoji size)
- **Generation Time**: ~51 seconds per 160x160 emoji on Mac

### Tested Functionality ✅
- ✅ Basic emoji generation (64x64, 160x160)
- ✅ LoRA model loading (both flux-dev and diverse-emoji)
- ✅ Full workflow with CLI interface
- ✅ Image upscaling and output management
- ✅ Direct mode (bypassing prompt assistant)

## iOS Port Development Considerations

### Swift Integration Requirements
1. **FLUX Model Integration**
   - Consider Core ML conversion of FLUX.1-dev
   - LoRA support in Core ML (may need custom implementation)
   - Alternative: Use native PyTorch Mobile or ONNX Runtime

2. **Memory Management**
   - iOS memory constraints more severe than macOS
   - Consider on-device quantization strategies
   - Implement progressive loading/unloading

3. **Model Storage**
   - FLUX.1-dev is ~24GB unquantized
   - LoRA files are ~209MB each
   - Consider model downloading vs. bundling strategies

### Native iOS Implementation Options
1. **Core ML Approach**
   - Convert FLUX to Core ML format
   - Implement LoRA as additional Core ML models
   - Pros: Native iOS integration, optimized performance
   - Cons: Conversion complexity, LoRA support challenges

2. **PyTorch Mobile Approach**
   - Use PyTorch Mobile runtime
   - Bundle Python models directly
   - Pros: Easier porting, existing Python codebase
   - Cons: Larger app size, potential performance impact

3. **ONNX Runtime Approach**
   - Convert to ONNX format
   - Use ONNX Runtime for iOS
   - Pros: Good performance, industry standard
   - Cons: Conversion complexity

### Recommended Development Path
1. **Phase 1**: Proof of concept with PyTorch Mobile
2. **Phase 2**: Core ML conversion for optimized performance
3. **Phase 3**: Custom implementation for maximum efficiency

### Performance Benchmarks (macOS)
- **64x64 emoji**: ~43 seconds
- **160x160 emoji**: ~51 seconds
- **Memory usage**: Optimized for 4-bit quantization
- **Model loading**: ~12 seconds initial load

### Key Files for iOS Port
- `generateImage.py` - Core generation logic to port
- `lora/info.json` - Model metadata and configuration
- `metaprompt/` - Prompt templates for UI integration
- Memory optimization parameters in `generateImage.py`

## Current Status: Ready for iOS Development
The Python implementation is fully functional and optimized. All dependencies are installed, models are downloaded, and the system generates high-quality emojis efficiently. The codebase is ready to be analyzed and ported to native iOS.

## Next Steps for iOS Port
1. Analyze FLUX.1-dev architecture for Core ML compatibility
2. Research LoRA implementation in iOS ML frameworks
3. Design iOS UI for emoji generation workflow
4. Implement progressive model loading for iOS memory constraints
5. Create emoji gallery and management system
6. Integrate with iOS keyboard/sticker functionality

FROM nvidia/cuda:11.8.0-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    ffmpeg \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip

# Torch compatível com XTTS v2 (Tesla P4 OK)
RUN pip3 install \
    torch==2.1.0+cu118 \
    torchaudio==2.1.0+cu118 \
    -f https://download.pytorch.org/whl/cu118

# Coqui TTS com XTTS v2
RUN pip3 install TTS==0.22.0 fastapi uvicorn

EXPOSE 5002

CMD ["tts-server", \
     "--model_name", "tts_models/multilingual/multi-dataset/xtts_v2", \
     "--port", "5002", \
     "--use_cuda", "true"]

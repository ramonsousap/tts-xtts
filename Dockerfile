FROM nvidia/cuda:11.6.2-runtime-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

RUN apt update && apt install -y \
    python3.9 \
    python3.9-distutils \
    python3-pip \
    ffmpeg \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1

RUN python3 -m pip install --upgrade pip

# Torch compatível com Tesla P4
RUN pip install torch==1.13.1+cu116 torchaudio==0.13.1+cu116 \
    --extra-index-url https://download.pytorch.org/whl/cu116

# Coqui TTS (XTTS v2 compatível)
RUN pip install TTS==0.14.3 fastapi uvicorn python-multipart numpy==1.23.5

EXPOSE 5002

CMD ["tts-server", \
     "--model_name", "tts_models/multilingual/multi-dataset/xtts_v2", \
     "--port", "5002", \
     "--use_cuda", "true"]

FROM python:3.10-slim

ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    WEB_ADDRESS=0.0.0.0:9988 \
    ENABLE_STS=0

RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg git libsndfile1 libgomp1 build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .
RUN pip install --upgrade pip setuptools wheel \
    && pip install torch==2.1.2 torchaudio==2.1.2 --index-url https://download.pytorch.org/whl/cpu \
    && pip install -r requirements.txt --no-deps

COPY . .
RUN chmod +x ./cloudflare-start.sh

EXPOSE 9988
CMD ["./cloudflare-start.sh"]

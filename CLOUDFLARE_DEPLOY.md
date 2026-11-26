# Cloudflare Containers deployment

This repository uses Cloudflare Containers (not static Pages) because the application requires Python, PyTorch, FFmpeg and Coqui TTS.

## Before enabling model startup

The XTTS model is governed by the Coqui Public Model License (CPML). The upstream project describes the model as non-commercial unless a separate commercial license is obtained. Read the license first:
- https://coqui.ai/cpml.txt

The Worker configuration deliberately sets `COQUI_TOS_AGREED=0`. Change it to `1` only after you personally read and accept the applicable CPML terms. Do not enable it for commercial use unless you have the required commercial license.

## Cloudflare setup

1. In Cloudflare Dashboard, open Workers & Pages and create a Worker using Workers Builds connected to this GitHub repository.
2. Set the production branch to `main`, root directory to `/`, and deploy command to `npx wrangler deploy`.
3. Ensure the account has Cloudflare Containers enabled and review the pricing for the `standard-4` instance (4 vCPU, 12 GiB RAM, 20 GB disk).
4. Only after accepting CPML, change `vars.COQUI_TOS_AGREED` in `wrangler.jsonc` from `0` to `1`.
5. Trigger a production build. Check Workers & Pages > Containers for the instance status and logs.

The first build and first model initialization may take a long time. This is a CPU-only deployment; it does not provide an NVIDIA GPU. Generated audio and uploaded voice samples are stored on the container filesystem and may not survive container replacement. Add persistent storage (for example R2) before relying on long-term retention.

## Important

A successful Worker deployment does not by itself prove the model is ready. Test the homepage, voice upload, text-to-speech generation, and generated-audio download after the container reports healthy.

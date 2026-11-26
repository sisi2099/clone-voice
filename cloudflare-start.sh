#!/bin/sh
set -eu

if [ "${COQUI_TOS_AGREED:-0}" != "1" ]; then
  echo "TTS startup blocked: review the Coqui Public Model License (CPML) and set COQUI_TOS_AGREED=1 only if you accept its non-commercial terms."
  exit 1
fi

# Download/initialize the project's required voice-conversion model on first boot.
python code_dev.py
exec python app.py

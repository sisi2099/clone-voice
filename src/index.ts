import { Container, getContainer } from "@cloudflare/containers";

interface Env {
  TTS_CONTAINER: DurableObjectNamespace<TTSContainer>;
  COQUI_TOS_AGREED: string;
}

export class TTSContainer extends Container {
  defaultPort = 9988;
  sleepAfter = "10m";
  enableInternet = true;
  envVars = {
    WEB_ADDRESS: "0.0.0.0:9988",
    ENABLE_STS: "0",
    COQUI_TOS_AGREED: "0",
  };
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const url = new URL(request.url);
    if (url.pathname === "/_cloudflare_health") {
      return Response.json({ ok: true, service: "clone-voice" });
    }
    const container = getContainer(env.TTS_CONTAINER, "aniu-tts");
    return container.fetch(request);
  },
};

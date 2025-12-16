from fastapi import FastAPI
from TTS.api import TTS
import uuid

app = FastAPI()

tts = TTS(
    model_name="tts_models/multilingual/multi-dataset/your_tts",
    progress_bar=False,
    gpu=False
)

@app.get("/tts")
def synthesize(text: str):
    out = f"/output/{uuid.uuid4()}.wav"
    tts.tts_to_file(text=text, file_path=out)
    return {"file": out}

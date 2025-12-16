from fastapi import FastAPI, HTTPException
from TTS.api import TTS
import uuid
import os
import traceback

app = FastAPI()

OUTPUT_DIR = "/output"
os.makedirs(OUTPUT_DIR, exist_ok=True)

tts = TTS(
    model_name="tts_models/multilingual/multi-dataset/your_tts",
    progress_bar=False,
    gpu=False
)

@app.get("/tts")
def synthesize(text: str):
    try:
        out = f"{OUTPUT_DIR}/{uuid.uuid4()}.wav"
        tts.tts_to_file(
            text=text,
            file_path=out,
            speaker="female-en-5",
            language="pt-br"
        )
        return {"file": out}
    except Exception as e:
        print("TTS ERROR:")
        traceback.print_exc()
        raise HTTPException(status_code=500, detail=str(e))


# server_fastapi_1.py
import uvicorn   # pip install uvicorn 
from fastapi import FastAPI, HTTPException, Query   # pip install fastapi 
from fastapi.middleware.cors import CORSMiddleware # cors issue
from pydantic import BaseModel
from fastapi.responses import FileResponse
from pydub.generators import Sine
from transformers import pipeline
import scipy.io.wavfile as wavfile
from audiocraft.models import musicgen
from audiocraft.utils.notebook import display_audio
import torch
# Create the FastAPI application
model = musicgen.MusicGen.get_pretrained('medium', device='cuda')
model.set_generation_params(duration=30)

app = FastAPI()

# cors 이슈
origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# A simple example of a GET request
@app.get("/") # 
def read_root():
    return "Hello!"

class MusicRequest(BaseModel):
    prompt: str

@app.get("/generate_music")
async def generate_music(genre: str = Query(default=None), tempo: str = Query(default=None), mood: str = Query(default=None)):
    try:
        # 텍스트로부터 오디오 생성
        res = model.generate([f'{genre}, {tempo}, {mood}'], 
        progress=True)
        print(res);
        # display_audio(res, 32000)
        return {"music": res}
        # 오디오 파일 저장
        # output_path = "musicgen_out.wav"
        # wavfile.write(output_path, rate=music["sampling_rate"], data=music["audio"])

        # return FileResponse(output_path, media_type="audio/wav", filename="musicgen_out.wav")
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
# Run the server
if __name__ == "__main__":
    uvicorn.run("server_fastapi_1:app",
            reload= True,   # Reload the server when code changes
            host="127.0.0.1",   # Listen on localhost 
            port=5000,   # Listen on port 5000 
            log_level="info"   # Log level
            )
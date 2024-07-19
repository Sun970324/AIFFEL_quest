# server_fastapi_1.py
import uvicorn   # pip install uvicorn 
from fastapi import FastAPI, HTTPException   # pip install fastapi 
from fastapi.middleware.cors import CORSMiddleware # cors issue
from pydantic import BaseModel
from fastapi.responses import FileResponse
from pydub.generators import Sine
from transformers import pipeline
import scipy.io.wavfile as wavfile

# Create the FastAPI application
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
    return "Hello 아이펠!"

@app.get('/example')
async def root():
    return {"example":"This is example", "data": 0}

synthesiser = pipeline("text-to-audio", "facebook/musicgen-small")


# 요청 데이터 형식 정의
class MusicRequest(BaseModel):
    prompt: str

@app.post("/generate_music")
async def generate_music(request: MusicRequest):
    try:
        # 텍스트로부터 오디오 생성
        music = synthesiser(request.prompt, forward_params={"do_sample": True})

        # 오디오 파일 저장
        output_path = "musicgen_out.wav"
        wavfile.write(output_path, rate=music["sampling_rate"], data=music["audio"])

        return FileResponse(output_path, media_type="audio/wav", filename="musicgen_out.wav")
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
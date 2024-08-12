import uvicorn   # pip install uvicorn 
from fastapi import FastAPI, HTTPException   # pip install fastapi 
from fastapi.middleware.cors import CORSMiddleware
import logging
import tensorflow as tf
import os
import numpy as np
import base64
from io import BytesIO
from PIL import Image
# Create the FastAPI application
app = FastAPI()

# CORS configuration
origins = ["*"]
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Set up logging
logging.basicConfig(level=logging.INFO)

logger = logging.getLogger(__name__)
IMG_SIZE = 160
IMG_SHAPE = (IMG_SIZE, IMG_SIZE, 3)
base_model = tf.keras.applications.Xception(input_shape=IMG_SHAPE,
                                            include_top=False,
                                            weights=None)  # 가중치 없음, 아래에서 로드

global_average_layer = tf.keras.layers.GlobalAveragePooling2D()
dense_layer = tf.keras.layers.Dense(units=2048, activation='relu')
dropout_layer = tf.keras.layers.Dropout(rate=0.2)
prediction_layer = tf.keras.layers.Dense(units=5, activation='softmax')

model = tf.keras.Sequential([
    base_model,
    global_average_layer,
    dense_layer,
    dropout_layer,
    prediction_layer
])

checkpoint_dir = "./"
checkpoint_file_path = os.path.join(checkpoint_dir, 'checkpoint.weights.h5')

def decode_image(encoded_image):
    # base64 디코딩 후 이미지 변환
    decoded_bytes = base64.b64decode(encoded_image)
    image = Image.open(BytesIO(decoded_bytes))
    image = image.resize((IMG_SIZE, IMG_SIZE))
    return np.array(image)

@app.get("/")
async def read_root():
    logger.info("Root URL was requested")
    return "꽃 사진 분류 모델"

@app.post('/predict')
async def predict(data: dict):
  try:
    # 입력 데이터를 numpy 배열로 변환 및 전처리
    encoded_image = data["image"]
    input_data = decode_image(encoded_image) 
    input_data = np.expand_dims(input_data, axis=0)
    input_data = tf.keras.applications.xception.preprocess_input(input_data)
    # 예측 수행
    prediction = model.predict(input_data)
    predicted_class = np.argmax(prediction, axis=1)[0]
    
    return {"predicted": int(predicted_class)}
  except Exception as e:
    raise HTTPException(status_code=400, detail=f"Prediction failed: {e}")

# Run the server
if __name__ == "__main__":
    uvicorn.run("exploration01:app",
            reload= True,   # Reload the server when code changes
            host="127.0.0.1",   # Listen on localhost 
            port=5000,   # Listen on port 5000 
            log_level="info"   # Log level
            )
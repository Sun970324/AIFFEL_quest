# AIFFEL Campus Code Peer Review Templete
- 코더 : 이유진, 윤선웅
- 리뷰어 : 유제민


# PRT(Peer Review Template)
[ㅇ]  **1. 주어진 문제를 해결하는 완성된 코드가 제출되었나요?**
- 문제에서 요구하는 기능이 정상적으로 작동하는지?
    - model = tf.keras.models.load_model("./checkpoint.h5")
    - def decode_image(encoded_image):
    - # base64 디코딩 후 이미지 변환
    - decoded_bytes = base64.b64decode(encoded_image)
    - image = Image.open(BytesIO(decoded_bytes))
    - image = image.resize((IMG_SIZE, IMG_SIZE))
    - return np.array(image)
  정상 동작 합니다.

    
[ㅇ]  **2. 핵심적이거나 복잡하고 이해하기 어려운 부분에 작성된 설명을 보고 해당 코드가 잘 이해되었나요?**
- 해당 코드 블럭에 doc string/annotation/markdown이 달려 있는지 확인
- 해당 코드가 무슨 기능을 하는지, 왜 그렇게 짜여진건지, 작동 메커니즘이 뭔지 기술.
- 주석을 보고 코드 이해가 잘 되었는지 확인
    - @app.post('/predict')
    - async def predict(data: Item):
    - try:
    - # 입력 데이터를 numpy 배열로 변환 및 전처리
    - encoded_image = data.image
    - print(encoded_image)
    - input_data = decode_image(encoded_image)
    - input_data = np.expand_dims(input_data, axis=0)
    - input_data = tf.keras.applications.xception.preprocess_input(input_data)
    - # 예측 수행
    - prediction = model.predict(input_data)
    - print(prediction)
    - predicted_class = np.argmax(prediction, axis=1)[0]
    - return {"predicted": int(predicted_class)}
    - except Exception as e:
    - raise HTTPException(status_code=400, detail=f"Prediction failed: {e}")
  각 파트별 기능들의 설명이 잘 되어 있다 생각합니다.
        
[ㅇ]  **3. 에러가 난 부분을 디버깅하여 “문제를 해결한 기록”을 남겼나요? 또는 “새로운 시도 및 추가 실험”을 해봤나요?**
- 문제 원인 및 해결 과정을 잘 기록하였는지 확인
- 문제에서 요구하는 조건에 더해 추가적으로 수행한 나만의 시도, 실험이 기록되어 있는지 확인
    - VGG16 외에 Xception 모델로 테스트 진행
    - Xception 테스트 결과
      Xception의 기본모델은 훈련데이터 정확도는 올라가지만 검증데이터 정확도는 개선되지 않음 → 과적합이라고 판단
      과적합이 일어남으로 dense layer의 노드 개수를 2048개 → 1024개로 줄여봄. 결과는 기본 모델이랑 비슷하게 나와 모델 성능에 크게 영향을 주지 못함
      dropout 적용 : 그래프 상 traning accuracy는 거의 1까지 근접하였지만 validation accuracy는 더 이상 개선이 되지 않아 과적합으로 보임.(87.5%)
      과적합 방지를 위해 데이터 증강 기법으로 데이터를 더 추가. 하지만 과적합은 여전히 발생, 모델 성능 또한 개선이 되지 않음(87.5%)
      L2규제 적용 ; 오히려 성능이 더 덜어짐(84.375)
        
[ ]  **4. 회고를 잘 작성했나요?**
- 프로젝트 결과물에 대해 배운점과 아쉬운점, 느낀점 등이 상세히 기록 되어 있나요?
- 딥러닝 모델의 경우, 인풋이 들어가 최종적으로 아웃풋이 나오기까지의 전체 흐름을 도식화하여 모델 아키텍쳐에 대한 이해를 돕고 있는지 확인
- 회고 작성은 따로 못 찾았습니다.
        
[ ]  **5. 코드가 간결하고 효율적인가요?**
- 파이썬 스타일 가이드 (PEP8)를 준수하였는지 확인
- 코드 중복을 최소화하고 범용적으로 사용할 수 있도록 모듈화(함수화) 했는지
    - 잘 작성되었다고 생각되는 부분을 근거로 첨부합니다.
    - @app.post('/predict')
    - async def predict(data: Item):
    - try:
    - # 입력 데이터를 numpy 배열로 변환 및 전처리
    - encoded_image = data.image
    - print(encoded_image)
    - input_data = decode_image(encoded_image)
    - input_data = np.expand_dims(input_data, axis=0)
    - input_data = tf.keras.applications.xception.preprocess_input(input_data)
    - # 예측 수행
    - prediction = model.predict(input_data)
    - print(prediction)
    - predicted_class = np.argmax(prediction, axis=1)[0]
    - return {"predicted": int(predicted_class)}
    - except Exception as e:
    - raise HTTPException(status_code=400, detail=f"Prediction failed: {e}")
      이미지 예측 코드를 하나로 잘 정리했습니다.

# 참고 링크 및 코드 개선


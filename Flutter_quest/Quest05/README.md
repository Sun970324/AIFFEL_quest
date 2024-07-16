# AIFFEL Campus Code Peer Review Templete
- 코더 : 유제민 
- 리뷰어 : 


# PRT(Peer Review Template)
[o]  **1. 주어진 문제를 해결하는 완성된 코드가 제출되었나요?**
- 문제에서 요구하는 기능이 정상적으로 작동하는지?
    - 해당 조건을 만족하는 부분의 코드 및 결과물을 근거로 첨부
      
  void _onBtnClick(String str) async {
    Uri uri = Uri.https(url, '/$str');
    var response = await http.get(uri);
    final result = jsonDecode(response.body)['predicted_$str'];
    setState(() {
      text = '예측 결과 : $result';
    });
    print(text);
  }

  각 버튼에 따른 url을 통해 결과 값과 확률 값을 따로 받아 옵니다.

 
[o]  **2. 핵심적이거나 복잡하고 이해하기 어려운 부분에 작성된 설명을 보고 해당 코드가 잘 이해되었나요?**
- 해당 코드 블럭에 doc string/annotation/markdown이 달려 있는지 확인
- 해당 코드가 무슨 기능을 하는지, 왜 그렇게 짜여진건지, 작동 메커니즘이 뭔지 기술.
- 주석을 보고 코드 이해가 잘 되었는지 확인
    - 잘 작성되었다고 생각되는 부분을 근거로 첨부합니다.

  final String _imagePath = 'assets/image/jellyfish.jpg'; // 예시 이미지
  final String url = '9a6a-124-56-101-127.ngrok-free.app'; // 서버 url

  각 변수 값이 무엇인지 잘 알려주었습니다.
      
        
[o]  **3. 에러가 난 부분을 디버깅하여 “문제를 해결한 기록”을 남겼나요? 또는 “새로운 시도 및 추가 실험”을 해봤나요?**
- 문제 원인 및 해결 과정을 잘 기록하였는지 확인
- 문제에서 요구하는 조건에 더해 추가적으로 수행한 나만의 시도, 실험이 기록되어 있는지 확인
    - 잘 작성되었다고 생각되는 부분을 캡쳐해 근거로 첨부합니다.

@app.get('/label')
async def prediction_label():
    try:
        result = await vgg16_prediction_model.prediction_model(vgg16_model, True)
        logger.info("Prediction was requested and done")
        return result
    except Exception as e:
        logger.error("Prediction failed: %s", e)
        raise HTTPException(status_code=500, detail="Internal Server Error")

@app.get('/score')
async def prediction_score():
    try:
        result = await vgg16_prediction_model.prediction_model(vgg16_model, False)
        logger.info("Prediction was requested and done")
        return result
    except Exception as e:
        logger.error("Prediction failed: %s", e)
        raise HTTPException(status_code=500, detail="Internal Server Error")

  플러터에서 결과 값과 확률 값을 구분하지 않고 서버에서 구분하는 것이 새롭다고 생각합니다.

        
[o]  **4. 회고를 잘 작성했나요?**
- 프로젝트 결과물에 대해 배운점과 아쉬운점, 느낀점 등이 상세히 기록 되어 있나요?
- 딥러닝 모델의 경우, 인풋이 들어가 최종적으로 아웃풋이 나오기까지의 전체 흐름을 도식화하여 모델 아키텍쳐에 대한 이해를 돕고 있는지 확인

이번 프로젝트를 통해 AI 모델의 결과 값을 서버에서 보내주는 것을 잘 알 수 있었습니다.

        
[o]  **5. 코드가 간결하고 효율적인가요?**
- 파이썬 스타일 가이드 (PEP8)를 준수하였는지 확인
- 코드 중복을 최소화하고 범용적으로 사용할 수 있도록 모듈화(함수화) 했는지
    - 잘 작성되었다고 생각되는 부분을 근거로 첨부합니다.

  void _onBtnClick(String str) async {
    Uri uri = Uri.https(url, '/$str');
    var response = await http.get(uri);
    final result = jsonDecode(response.body)['predicted_$str'];
    setState(() {
      text = '예측 결과 : $result';
    });
    print(text);
  }

코드가 정말 깔끔하고 군더더기 없다 생각합니다.


# 참고 링크 및 코드 개선


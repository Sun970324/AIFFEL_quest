피어리뷰

코더: 윤선웅, 김소영
리뷰어: 유제민, 김재이, 김원영

* 요구된 내용이 모두 완성되었고, 배포까지 완료해주셨습니다.
* 엔드투엔드 과정이 잘 구현되어 있는데 코드를 간결히 작성해주셔서, 리뷰하면서도 많이 배울 수 있었습니다.

---

- [o]  **1. 주어진 문제를 해결하는 완성된 코드가 제출되었나요? (완성도)**
    - 문제에서 요구하는 최종 결과물이 첨부되었는지 확인
    - 문제를 해결하는 완성된 코드란 프로젝트 루브릭 3개 중 2개, 퀘스트 문제 요구조건 등을 지칭

    - [o] 1. Data Centric AI 맛보기 (데이터 품질을 우선 올리기)
    - [o] 2. 하이퍼파라미터 튜닝 (케라스 튜너를 사용해 하이퍼파라미터의 품질 보장해보기)
    - [o] (옵션) 3. 모델 배포 (텐서플로우 방식으로 모델 저장하고 배포하기)
    - [] (옵션) 4. TFLite 모델 만들기 (경량 모델 저장 및 서명)

    * 1. 데이터 전처리: 노드의 내용에 따라 labelerrors.com에서 오류가 있는 라벨들을 확인한 후, 해당 인덱스와 바른 라벨을 딕셔너리로 저장해 함수를 통한 라벨링 업데이트를 진행해주셨다.

      ```
      def visualize_and_correct_label(wrong_id):
        for item in wrong_id:
            image_id = item['id']
            correct_answer = item['answer']
            
            # Display the image
            plt.imshow(x_test[image_id])
            plt.title(f"Original Label: {class_names[y_test[image_id][0]]}")
            plt.show()
            
            # Get the actual current label
            current_label = class_names[y_test[image_id][0]]
            
            if current_label != correct_answer:
                # Update the label to the correct one
                y_test[image_id] = class_names.index(correct_answer)
                print(f"'{correct_answer}'로 변경. ID: {image_id}")
            else:
                print(f"{image_id}의 라벨이 이미 '{current_label}'입니다.")

        wrong_id = [
          {'id': 2405, 'answer': 'frog'},
          {'id': 6877, 'answer': 'ship'},
          {'id': 8058, 'answer': 'horse'},
          {'id': 2532, 'answer': 'automobile'},
          {'id': 7657, 'answer': 'horse'},
          {'id': 1969, 'answer': 'truck'},
          {'id': 2804, 'answer': 'dog'},
          {'id': 6792, 'answer': 'truck'},
          {'id': 1227, 'answer': 'dog'},
          {'id': 5191, 'answer': 'dog'},
          {'id': 5690, 'answer': 'deer'},
          {'id': 1718, 'answer': 'ship'},
          {'id': 2592, 'answer': 'deer'},
          {'id': 4794, 'answer': 'bird'},
          {'id': 5960, 'answer': 'cat'},
          {'id': 165, 'answer': 'bird'},
          {'id': 9227, 'answer': 'truck'},
          {'id': 5632, 'answer': 'dog'},
          {'id': 9352, 'answer': 'truck'},
          {'id': 7846, 'answer': 'cat'},
          {'id': 6966, 'answer': 'ship'},
          {'id': 5468, 'answer': 'cat'}
        ]
        visualize_and_correct_label(wrong_id)
      ```
       <img width="270" alt="스크린샷 2024-08-29 오후 5 56 08" src="https://github.com/user-attachments/assets/7b1f3244-710c-4f11-9b8a-df70ad298f53">

      

    * 2. 하이퍼파라미터 설정: 케라스 튜너의 Random Search 를 사용해 얻은 best_model 에 근거한 파라미터 활용하심.
 
      ```
      from kerastuner.tuners import RandomSearch

      tuner = RandomSearch(
          build_model,
          objective='val_accuracy',
          max_trials=10,
          executions_per_trial=2, 
          directory='./best_model/1', 
          project_name='cifar10_tuning'
      )
      ```

    * 옵션이었던 [모델 배포](https://github.com/Sun970324/AIFFEL_quest/blob/main/Exploration_quest/cifar10_best_model/docker.png)도 도커를 통해 완성해주셨습니다.

      
- [o]  **2. 프로젝트에서 핵심적인 부분에 대한 설명이 주석(닥스트링) 및 마크다운 형태로 잘 기록되어있나요? (설명)**
    - [o]  하이퍼 파라미터 선정 이유
    - [o]  데이터 전처리 이유 또는 방법 설명
      
    * 피어 리뷰 중의 설명으로 대체되었는데, 마크다운으로도 추가되면 좋을 것 같습니다.

- [o]  **3. 체크리스트에 해당하는 항목들을 수행하였나요? (문제 해결)**
    - [o]  데이터를 분할하여 프로젝트를 진행했나요? 데이터가 train, validation, test 데이터로 구분되었는가: 검증 데이터와 테스트 데이터가 따로 구분되어 있지는 않았으나 목적에는 부합함.
    - [o]  하이퍼파라미터를 변경해가며 여러 시도를 했나요? 노드대로 하이퍼파라미터 개선 진행됨.
    - (해당 없음) []  각 실험을 시각화하여 비교하였나요?
    - [o]  모든 실험 결과가 기록되었나요? 모두 기록되어 있음.

- [o]  **4. 프로젝트에 대한 회고가 상세히 기록 되어 있나요? (회고, 정리)**
    - [o]  배운 점
    - [o]  아쉬운 점 
    - [o]  느낀 점 
    - [o]  어려웠던 점
 
    * 회고가 작성된 [프로그램 파일](https://github.com/Sun970324/AIFFEL_quest/blob/main/Exploration_quest/cifar10_best_model/mlops.ipynb) 하단에 기록되어 있습니다.

- [x]  **5.  앱으로 구현하였나요?**
    - (해당 없음) []  구현된 앱이 잘 동작한다.
    - (해당 없음) []  모델이 잘 동작한다. 

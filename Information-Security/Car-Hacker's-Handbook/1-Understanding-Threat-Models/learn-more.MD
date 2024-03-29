- [TPMS란?](#tpms란)
- [ECU란?](#ecu란)
- [CAN이란?](#can이란)
  - [특징](#특징)
  - [장점](#장점)
  - [CAN 통신 프로토콜](#can-통신-프로토콜)
- [GSM이란?](#gsm이란)
- [차량 내외부의 데이터 흐름과 통신](#차량-내외부의-데이터-흐름과-통신)
- [CVSS](#cvss)

# TPMS란?

: Tire Pressure Monitoring System

+ 타이어의 상태를 알아보는 데 가장 중요한 척도 중 하나인 공기압을 감지하는 시스템
+ 직접방식
  + 타이어 공기 주입 밸브에 센서가 부착되는 형태, 타이어 내 공기압과 온도를 감지해 자체 송신기를 통해 차내 수신기로 정보를 실시간으로 전달
  + MCU, 압력센서, 온도센서, RF송신기, 배터리로 구성
  + 동일 주파수 대역을 사용하는 TPMS 간 간섭/오작동을 막기 위해 각 자동차에 전용 인증코드 부여
+ 간접방식
  + TPMS 도입 초기 주로 사용
  + 바퀴 회전수에 대한 정보를 토대로 공기압 상태를 판별(공기압이 높을수록 타이어 둘레가 커지고 낮으면 작아지는 원리 이용)

---

# ECU란?

: Electronic Control Unit, 전자제어장치

+ 자동차용 컴퓨터
+ 차량 센서들의 정보를 입력받아 이를 토대로 차량을 제어
+ ACU(airbag), ECU(engine), TCU(transmission), BCU(brake), OBD(On-Board-Diagnostics) 포함

---

# CAN이란?

: Controller Area Network

## 특징

+ 다중통신망(Multi Master Network), CSMA/CD+AMP(Carrier Sense Multiple Access/Collision Detection with Arbitration on Message Priority)
+ 차량 내 호스트 컴퓨터 없이 마이크로 컨트롤러/장치들이 서로 통신하기 위해 설계된 표준통신규격
+ 차량 내 ECU들은 CAN 프로토콜을 통해 통신, 하나의 CAN 버스 네트워크에 연결됨
+ 각 노드마다 ID 가짐

<img src="https://www.fescaro.com/wp-content/uploads/2016/10/%EA%B7%B8%EB%A6%BC3.jpg" width=500>

## 장점

+ 메시지 지향성 프로토콜
  + 노드 주소에 의해 데이터를 교환하는 게 아니라 메시지 우선순위에 따라 ID 할당하고 이를 통해 메시지 구별
  + 한 노드로부터 전송 받은 메시지가 본인 노드에 필요한 메시지인지 판단하고 필요하지 않으면 무시
+ 보완적인 에러 감지 메커니즘
  + 메시지 전송 시 에러 감지되면 해당 메시지 즉시 자동 재전송하여 에러 회복 시간 짧음
+ 멀티 마스터 능력
  + 버스 마스터 노드 없이, 모든 노드가 마스터로서 버스가 비어 있다면 언제든지 메시지 전송 가능
  + 두 노드에서 동시 전송할 시, ID가 낮은 우선순위가 높은 메시지부터 전송
+ 결점 있는 노드의 감지와 비활성화
  + 실시간으로 결함 있는 노드를 감지해 해당 노드 비활성화
+ 전기적 노이즈에 강함
+ 저렴한 가격 및 구성의 용이성
+ 서로 다른 모듈 간 통신을 위해 많은 선을 필요로 했던 UART(1:1) 방식으로 ECU를 연결할 때 발생하는 무게 증가, 유지보수 문제, 연비 하락 등의 문제 해결

<img src="https://ni.scene7.com/is/image/ni/bd378304156?scl=1" width=400>

## CAN 통신 프로토콜

+ 차량용 네트워크의 백본망 구성
+ ID 길이에 따라 모드 구분
  + 표준 CAN(2.0A)
    + 11-bit 식별자, 1Mbps 이상의 고속 통신 가능
    + CAN 2.0A 컨트롤러에서 보낸 메시지 데이터만 유효
  + 확장 CAN(2.0B)
    + 29-bit 식별자, 125Kbps까지의 통신 가능
    + CAN 2.0A/B 모두 송수신 가능
+ CAN Controller/Transceiver으로 구현됨
  + CAN controller
    + 내부 버퍼를 가지며 Transceiver에서 전달되는 수신 메시지의 유효 여부를 ID 기반으로 판별하고, 유효할 시 MCU로 전달
  + CAN transceiver
    + MCU가 전송하고자 하는 데이터를 CAN 통신용 데이터로 변환하고, CAN 버스에서 전달된 CAN 통신용 데이터를 MCU 송수신용 데이터로 변환

<img src="https://www.fescaro.com/wp-content/uploads/2016/10/%EA%B7%B8%EB%A6%BC1.jpg" width=500>

---

# GSM이란?

: Global System for Mobile Communications

+ 가장 널리 사용되는 무선 휴대 통신 시스템

---

# 차량 내외부의 데이터 흐름과 통신

+ 내부: 인포테인먼트/내비게이션 콘솔, USB, OBD-2 연결 단자, CAN 버스 연결 지점
+ 외부: 이동통신, 와이파이, 블루투스, TPMS, KES

---

# CVSS

: Common Vulnerability Scoring System

+ 기본(0-10), 취약성의 내재적 특성
  + 영향: 취약성의 기밀성 영향, 무결성 영향, 가용성 영향
  + 이용 가능성: 액세스 벡터(취약성이 액세스된 방법), 액세스 복잡도(공격의 복잡도), 인증(공격자가 취약성 악용을 위해 인증해야 하는 횟수)
+ 임시, 시간의 흐름에 따라 변경되는 취약성 위협의 특성
  + 이용 가능성: 취약성을 악용하는 데 사용할 수 있는 기술/코드의 가용성, 시간의 흐름에 따라 변경됨
  + 조치 레벨: 취약성에 대해 사용 가능한 조치 레벨
  + 보고서 신뢰도: 취약성이 존재하는 경우 신뢰도 레벨과 기술 세부사항의 신뢰성
+ 환경: 사용자 환경의 영향을 받는 취약성의 특성, 가장 중요한 자산에 가장 높은 점수 부여
  + 잠재적인 부수적 손상 가능성(CDP): 생산성/수익의 경제적 손실/자산의 도난이나 파손으로 인한 물리적 자산의 수명이 감소할 가능성
  + 대상 분포(TD): 사용자 환경에서 취약한 시스템의 비율
  + 기밀성 요구사항(CR): 이 자산에서 취약성이 악용된 경우 신뢰도 상실로 인한 영향 수준
  + 무결성 요구사항(IR): 취약성이 악용된 경우 신뢰도 상실로 인한 영향 수준
  + 가용성 요구사항(AR): 취약성이 악용된 경우 자산의 가용성으로 인한 영향 수준
+ `IT 산업을 위한 것, 산업 시스템에는 부적합할 수 있음`
  + CVSS 점수가 낮은 취약점이라도 치명적으로 작용할 수 있음
  + CVSS 점수에 따라 패치 순서를 정하는 산업 조직은 거의 없음
  + [취약점 평가하는 CVSS 점수, 이대로 괜찮은가?](https://www.boannews.com/media/view.asp?idx=74913)
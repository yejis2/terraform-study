# terraform-basic

## 01. EC2 웹 서버 배포 + 리소스 생성 그래프 확인
Ubuntu 에 apache(httpd) 를 설치하고 index.html 생성(닉네임 출력)하는 userdata 를 작성해서 설정 배포 후 웹 접속 - 해당 테라폼 코드(파일)를 작성
- main.tf
  - Terraform provider 설정
  - Ubuntu 기반 EC2 배포
  - user_data에 apache 설치 및 html 파일 내용 변경하는 스크립트 작성
  - default VPC 사용
  - Security group 포트 번호 설정하여 웹 접속 가능하도록 함
  - EC2 인스턴스에 Public IP 할당

## 02. AWS S3/DynamoDB 백엔드
AWS S3/ DynamoDB 백엔드 설정 실습
- main.tf
  - Terraform provider 설정
  - S3 Bucket 생성
  - DynamoDB table 생성

## 03. lifecycle의 precondition
lifecycle의 precondition 실습 내용에서 step0.txt ~ step6.txt 총 7개의 파일 이름 중 하나가 일치 시 검증 조건 만족으로 코드 작성
- main.tf
  - precondition 내부에서 or 조건 사용하여 조건 만족 시 파일 생성하도록 함

## 05. AWS 서비스 리소스 배포 + 리소스 생성 그래프 확인
Hashicorp AWS Provider Document 에 Example Usage 중 아무거나 1개의 AWS 서비스 리소스 배포 실습
- main.tf
  - Terraform provider 설정
  - Ubuntu 기반 EC2 배포
  - user_data에 apache 설치 및 html 파일 내용 변경하는 스크립트 작성
  - VPC 및 Subnet 등 network 환경 생성
  - Security group 포트 번호 설정하여 웹 접속 가능하도록 함
  - EC2 인스턴스에 Public IP 할당
- backend.tf
  - Terraform backend 를 S3와 DynamoDB 로 구성
# :blue_book: 답변형 게시판

## ![Java](https://img.shields.io/badge/java-%23ED8B00.svg?style=for-the-badge&logo=java&logoColor=white) ![CSS3](https://img.shields.io/badge/css3-%231572B6.svg?style=for-the-badge&logo=css3&logoColor=white) ![HTML5](https://img.shields.io/badge/html5-%23E34F26.svg?style=for-the-badge&logo=html5&logoColor=white) ![JavaScript](https://img.shields.io/badge/javascript-%23323330.svg?style=for-the-badge&logo=javascript&logoColor=%23F7DF1E) ![Oracle](https://img.shields.io/badge/Oracle-F80000?style=for-the-badge&logo=oracle&logoColor=white) ![Apache Tomcat](https://img.shields.io/badge/apache%20tomcat-%23F8DC75.svg?style=for-the-badge&logo=apache-tomcat&logoColor=black)

## :open_book: Summary 
>
> * 데이터베이스에 저장되어 있는 글을 작성 순서에 따라 정렬하여 테이블 형식으로 출력. 
> * '글쓰기' 기능으로 글 제목, 글 내용, 작성자ID 를 사용자가 입력하면 이에 대응 되는 글 번호, 부모 글 번호, 작성 날짜를 자동으로 설정하여 데이터베이스에 저장. 
> * '글쓰기' 기능이 아닌, 사전에 작성되어 있던 글 제목을 클릭하여 '답글쓰기' 기능 사용시 사전 글의 글 번호가 답글의 부모 글 번호로 설정되고 후에 계층형 sql 에 사용, 나머지는 '글쓰기' 기능과 동일. 
> * 글 제목을 클릭하여 '수정하기' 기능 사용시 block 되어 있던 글 제목과 글 내용이 풀리면서 새로운 정보로 update 가능. 
> * 글 제목을 클릭하여 '삭제하기' 기능 사용시 글 번호를 기준으로 이에 대응되는 데이터 삭제
> * '섹션 번호' 와 '페이지 번호' 하나의 페이지에는 특정 개수의 글이, 하나의 섹션에는 특정 개수의 페이지가 출력될수 있도록 기능을 설정.   
 
***

## :open_book: Main Functions
> :hammer_and_wrench: 게시판 조회
> 

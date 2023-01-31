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
> ### :mag: 게시판 조회
> 
> <img src="https://user-images.githubusercontent.com/116073413/215736078-fe43ec33-9a5b-4226-b39a-d168cd0428b3.jpg" width="50%" height="50%"/>
> 
> 데이터 베이스의 정보를 모두 출력합니다. 기본적으로 글번호를 기준으로 정렬하지만, 계층형 쿼리의 order sibling by 를 사용하여 계층 구조를 유지하며 정렬한 테이블을 출력합니다.

<br/><br/>

> ### :memo: 게시글 쓰기
> 
> <img src="https://user-images.githubusercontent.com/116073413/215739715-3c1b7c00-6906-4daa-a9c6-c5eea5f60dd2.png" width="50%" height="50%"/>
> 
> 글 제목, 작성자 ID, 글 내용을 사용자가 입력하고, 글 번호, 부모글 번호, 작성일 은 자동으로 설정됩니다. 

<br/><br/>

> ### :notebook: 게시글 조회
> 
> <img src="https://user-images.githubusercontent.com/116073413/215738887-73c7fd94-1eef-45a9-aaf8-7ba09e1da504.png" width="50%" height="50%"/>
> 
> 글 제목을 클릭하면 해당 글의 글번호를 기준으로 데이터베이스에서 데이터를 가져오고 출력합니다.


 


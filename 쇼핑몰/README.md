
# Spring Project : HTA_mall
스프링을 이용한 쇼핑몰 사이트 입니다.
<br/><br/>

## :hourglass: Develop Period
23.02.01 (09:00) ~ 23.02.16 (16:00)
<br/><br/>

## :hammer_and_wrench: Tech Stack
![MySQL](https://img.shields.io/badge/mysql-%2300f.svg?style=for-the-badge&logo=mysql&logoColor=white)
![Spring](https://img.shields.io/badge/spring-%236DB33F.svg?style=for-the-badge&logo=spring&logoColor=white)
![jQuery](https://img.shields.io/badge/jquery-%230769AD.svg?style=for-the-badge&logo=jquery&logoColor=white)
![JavaScript](https://img.shields.io/badge/javascript-%23323330.svg?style=for-the-badge&logo=javascript&logoColor=%23F7DF1E)
![CSS3](https://img.shields.io/badge/css3-%231572B6.svg?style=for-the-badge&logo=css3&logoColor=white)
![HTML5](https://img.shields.io/badge/html5-%23E34F26.svg?style=for-the-badge&logo=html5&logoColor=white)
![Apache Tomcat](https://img.shields.io/badge/apache%20tomcat-%23F8DC75.svg?style=for-the-badge&logo=apache-tomcat&logoColor=black)
![Apache Maven](https://img.shields.io/badge/Apache%20Maven-C71A36?style=for-the-badge&logo=Apache%20Maven&logoColor=white)
<br/><br/>

## :runner: Team Memmber
- Joo young Kim
- Han byeol Kim
- Won woo Seo
- Jun soo Lee
- Sung hwan Cho
- Seong min Cho
- Won jun Jung
<br/><br/>

## :compass: Setting
- 이 프로젝트에는 소스코드만 포함되어 있습니다. 추가설정이 필요합니다. <br/>
Schema : [Htamall_schema.txt](https://github.com/wonuseo/htamart/files/10752578/Htamall_schema.txt)<br/>
EntityManagerFactory : [EntityManagerFactory.txt](https://github.com/wonuseo/htamart/files/10752455/EntityManagerFactory.txt)<br/>
Build Tool (Maven) : [pom.txt](https://github.com/wonuseo/htamart/files/10751738/pom.txt)<br/>
persistence.xml : [persistence.txt](https://github.com/wonuseo/htamart/files/10752469/persistence.txt)<br/>
<br/><br/>

## :open_book: Summary 
 * 아이디 중복체크를 하지 않으면 회원가입을 할 수 없습니다.
 * 로그인이 성공적으로 진행되면 세션을 유지 시키고, 로그아웃으로 세션을 해제합니다.
 * 전체 카테고리와 검색, 슬라이드쇼를 통해 상품목록으로 이동합니다.
 * 추천상품, 상품목록의 이름으로 상품 상세 페이지로 이동합니다.
 * 상세 페이지에서 수량, 바로 구매와 장바구니로 결제 방식을 선택 할 수 있습니다.
 * 장바구니에서 담은 상품을 선택적으로 구매 가능합니다.
 * 주문/결제 시 자동으로 로그인된 고객의 정보가 들어가며 수정 가능합니다.
<br/><br/>

## :gear: Main Functions
> ### :slightly_smiling_face: 회원가입/로그인
>
> <img src="https://user-images.githubusercontent.com/87034370/219252111-33d2229b-5933-45fa-8503-1f176f040132.png" width="40%" height="30%" title="px(픽셀) 크기 설정" alt="RubberDuck"></img><img src="https://user-images.githubusercontent.com/87034370/219252141-48091c15-7e04-4248-a7d2-675e67baf24e.png" width="40%" height="30%" title="px(픽셀) 크기 설정" alt="RubberDuck"></img><br/>
> ```java
> public void createUser(User user) throws Exception {
>		EntityManager em = DBUtil.getEntityManager();
>		EntityTransaction tx = em.getTransaction();
>		try {
>			tx.begin();
>			user.setUserDate(new Date());
>			em.persist(user);
>			tx.commit();
>		} finally {
>			em.close();
>		}
> } 
> public boolean checkId(String userId) throws Exception {
>		EntityManager em = DBUtil.getEntityManager();
>		Long count = null;
>		try {
>			count = em.createQuery("select count(u) from User u where u.userId = :userId", Long.class)
>					.setParameter("userId", userId)
>					.getSingleResult();
>		} finally {
>			em.close();
>		}	
>		return count == 0;
>	}
> public boolean validateUser(String userId, String userPassword) throws Exception{
>		EntityManager em = DBUtil.getEntityManager();		
>		Long count = null;
>		try {
>			count = em.createQuery("select count(u) from User u where u_id = :u_id and u_password = :u_password", Long.class)
>					.setParameter("u_id", userId)
>					.setParameter("u_password", userPassword)
>					.getSingleResult();		
>		} finally {
>			em.close();			
>		}		
>		return count == 1;
>	}
> ```
> <br/><br/>
> ```js
> function dedupId() {
>		axios.post('userinfo/dedupId', {}, {
>			params : {
>				u_id : document.getElementById("userId").value
>			}
>		})
>		 .then(function (resData) {
>			 validate(resData['data']);
>		 })
>	}
>	function validate(val) {
>		const userId = document.getElementById("userId").value;	
>		if(userId == ""){
>			alert('아이디를 입력하세요');
>			return;
>		}else if(val == true) {
>			alert('사용가능한 아이디 입니다.')
>			document.getElementById("submit").disabled=false;
>			document.getElementById("userId").readOnly=true;
>		}else {
>			alert('이미 존재하는 아이디 입니다.');
>		}
>	}
>	function login(obj) {
>		axios.post('userinfo/validateUser', {}, {
>			params : {
>				userId : document.getElementById("userId1").value,
>				userPassword : document.getElementById("userPassword1").value
>			}
>		})
>		 .then(function (resData) {
>			 if(resData['data'] == true) {
>				 obj.submit();
>			 }else{
>				 alert('아이디(로그인 전용 아이디) 또는 비밀번호를 잘못 입력했습니다. 입력하신 내용을 다시 확인해주세요.');
>			 }
>		 })
>	}
> ```
> <br/>
> 회원가입/로그인은 하나의 창에서 토글로 구분하고 있습니다.<br/>
> 첫번째 코드는 회원가입/로그인의 중복체크와 검증의 주요 로직입니다. <br/>
> 두번쨰 코드로 검증로직을 비동기로 사용하고 있습니다.
<br/><br/>
> ### :shopping_cart: 장바구니
>
> <img src="https://user-images.githubusercontent.com/116073413/219250849-db93e494-f60a-4baf-aba4-6d2ee5aa3f87.jpg" width="40%" height="40%"/> <img src="https://user-images.githubusercontent.com/116073413/219251506-7acc3f6e-8ad8-4c1d-8539-5c7d2e866da0.jpg" width="40%" height="40%"/>
>
> ```java
> //onload 로 즉시 실행. 장바구니의 길이가 0 이면 상품 주문 버튼 disabled	
>	function cartSize() {
>		if(document.querySelectorAll(".form-checkbox").length == 0) {
>			document.getElementById("input_55").disabled=true;
>		}
>	}
> //체크가 된 checkbox의 개수가 0 이면 상품 주문 버튼 disabled
>	function checkBox() {
>		 var checkboxes = document.querySelectorAll('input[type="checkbox"]:checked');
>		 if(checkboxes.length == 0 ) {
>			 document.getElementById("input_55").disabled=true;
>		 }else{
>			 document.getElementById("input_55").disabled=false;
>		 }
>	}
> ```
> 사용자가 장바구니에 추가한 품목의 이미지, 수량, 이름, 총 가격을 출력하고, 만약 장바구니에 추가된 품목이 없을 경우, 알맞은 메시지를 출력하고 '상품 주문' 버튼은 비활성화 
> 됩니다.
> 
<br/><br/>
> ### :mag: 검색 기능
> <img src="https://user-images.githubusercontent.com/122413012/219260768-fbf78ae7-aea5-4f14-b7d9-c23979c8e08b.PNG" width="40%" height="30%" title="px(픽셀) 크기 설정" alt="RubberDuck"></img> <img src="https://user-images.githubusercontent.com/122413012/219260797-bf23aa27-a0a5-4673-b05c-eef0affda1f9.PNG" width="40%" height="30%" title="px(픽셀) 크기 설정" alt="RubberDuck"></img>
> ```java
> @Controller
> @RequestMapping("SearchController")
> public class SearchController {
>	
>	@Autowired
>	private ProductDAO productdao;
>	
>	@GetMapping(value="/productsearch")
>	public ModelAndView getProductSearch(@RequestParam(value = "keyword") String keyword) throws Exception {
>		ModelAndView mv = new ModelAndView();
>		
>		if(keyword != null && keyword.length() != 0) {
>			mv.addObject("productallData", productdao.findElement(keyword));
>		} else {
>			mv.addObject("productallData");
>		}
>		mv.setViewName("list");
>		
>		return mv;  
>	}
>
> @Repository
> public class ProductDAO {
>	
>	public List<Product> findElement(String keyword) {
>		EntityManager em = DBUtil.getEntityManager();
>		
>		List<Product> all = null;
>		
>		try {
>			all = em.createQuery("select p from Product p where p.productName like '%" + keyword + "%' ")
>					.getResultList();
>		} finally {
>			em.close();
>		}
>		
>		return all;
>	}
> ```
> 사용자가 검색을 할 시 검색한 키워드를 SQL에서 Like 연산자를 사용해 검색된 단어가 일치한 관련된 상품이 나오게끔 로직을 구현했습니다. <br>
> 존재하지 않는 상품이나 잘못된 입력을 통해서 검색을 할 시 사용자에게 "검색하신 상품이 없습니다"라고 응답을 보냅니다.
 <br/><br/>
>
### :bread: 리스트 기능
<img src="https://user-images.githubusercontent.com/113893324/219275831-456eb3eb-e202-4488-bdb1-990724c1c1cd.png" width="40%" height="30%" title="px(픽셀) 크기 설정" alt="RubberDuck"></img>

```java
@Controller
@RequestMapping("category")
public class CategoryController {
	
	@Autowired
	private ProductDAO dao;
	
	@GetMapping(value = "/list")
	public ModelAndView getCategory(@RequestParam("cat") String cat) throws Exception{
		ModelAndView mv= new ModelAndView();
		
		String c_id = null;
		if(cat.equals("fruit")) {
			c_id = "1";
		}else if (cat.equals("vegetable")){
			c_id ="2";
		}else if (cat.equals("meat")){
			c_id ="3";
		}else if (cat.equals("seafood")){
			c_id ="4";
		}
		
		List<Product> all = dao.getAllProduct(c_id);
		
		mv.addObject("productallData", all);
		mv.setViewName("list");
		
		return mv;
	}
}

public class ProductDAO {

public List<Product> getAllProduct(String c_id) {
		EntityManager em = DBUtil.getEntityManager();
		
		Category c = new Category();
		c.setCategoryId(c_id);
		
		List<Product> all = null;
		try {
			all = em.createQuery("select p from Product p where p.category = :category")
					.setParameter("category", c)
					.getResultList();
		}finally {
			em.close();
		}
		
		return all;
	}
}
```
<br/><br/>
	
## :face_with_head_bandage: Trouble Shooting
> 
> :heavy_check_mark: 회원가입시 데이터가 추가된 시간을 입력하려고 했으나 원하는 Date 형식으로 저장되지 않음.
> * @Temporal 어노테이션을 사용하여 db 에 맞는 Date 형식을 저장.
>
> :heavy_check_mark: 깃허브를 사용하여 조원간 파일을 공유할때 필요없는 파일까지 같이 공유가 됨.
> * gitignore 파일을 사용하여 공유될 필요가 없는 파일은 제외시킴.
>
> :heavy_check_mark: 로그인 성공시 그 정보를 서버 어디에 저장시켜 로그인 상태를 유지시킬지 고민.
> * Model api 를 사용하여 로그인 정보를 저장하여 session 관리.
>
> :heavy_check_mark: form 태그 내에 있는 정보를 바로 controller 로 보내지 않고 jsp 내에서 가공을 한 후 보낼 필요가 있었음.
> * onClick 함수를 사용하거나 EventHandler 를 사용.
>



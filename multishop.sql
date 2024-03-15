-- 회원
ALTER TABLE Member
	DROP CONSTRAINT PK_Member; -- 회원 기본키

-- 회원
DROP TABLE Member;

-- 회원
CREATE TABLE Member (
	userid  VARCHAR2(20)  NOT NULL, -- 아이디
	name    varchar2(30)  NOT NULL, -- 이름
	pwd     varchar2(120)  NOT NULL, -- 비밀번호
	hp1     char(3)       NOT NULL, -- 연락처1
	hp2     char(4)       NOT NULL, -- 연락처2
	hp3     char(4)       NOT NULL, -- 연락처3
	post    char(5)       NOT NULL, -- 우편번호
	addr1   varchar2(100) NULL,     -- 주소1
	addr2   varchar2(100) NULL,     -- 주소2
	indate  DATE          NULL,     -- 가입일
	mileage number(8)     NULL,     -- 마일리지
	mstate  number(1)     NULL      -- 회원상태
);

-- 회원 기본키
CREATE UNIQUE INDEX PK_Member
	ON Member ( -- 회원
		userid ASC -- 아이디
	);

-- 회원
ALTER TABLE Member
	ADD
		CONSTRAINT PK_Member -- 회원 기본키
		PRIMARY KEY (
			userid -- 아이디
		);
        
desc member;
-----------------------------------------------------
-- 상위 카테고리
ALTER TABLE upCategory
	DROP CONSTRAINT PK_upCategory; -- 상위 카테고리 기본키

-- 상위 카테고리
DROP TABLE upCategory;

-- 상위 카테고리
CREATE TABLE upCategory (
	upcg_code number(8)    NOT NULL, -- 상위 카테고리 코드
	upcg_name varchar2(30) NOT NULL  -- 상위 카테고리명
);

-- 상위 카테고리 기본키
CREATE UNIQUE INDEX PK_upCategory
	ON upCategory ( -- 상위 카테고리
		upcg_code ASC -- 상위 카테고리 코드
	);

-- 상위 카테고리
ALTER TABLE upCategory
	ADD
		CONSTRAINT PK_upCategory -- 상위 카테고리 기본키
		PRIMARY KEY (
			upcg_code -- 상위 카테고리 코드
		);
-----------------------------------------------------
-- 하위 카테고리
ALTER TABLE downCategory
	DROP CONSTRAINT FK_upCategory_TO_downCategory; -- 상위 카테고리 -> 하위 카테고리

-- 하위 카테고리
ALTER TABLE downCategory
	DROP CONSTRAINT PK_downCategory; -- 하위 카테고리 기본키

-- 하위 카테고리
DROP TABLE downCategory;

-- 하위 카테고리
CREATE TABLE downCategory (
	upcg_code   number(8)    NOT NULL, -- 상위 카테고리 코드
	downcg_code number(8)    NOT NULL, -- 하위 카테고리 코드
	downcg_name varchar2(30) not NULL      -- 하위 카테고리명
);

-- 하위 카테고리 기본키
CREATE UNIQUE INDEX PK_downCategory
	ON downCategory ( -- 하위 카테고리
		upcg_code   ASC, -- 상위 카테고리 코드
		downcg_code ASC  -- 하위 카테고리 코드
	);

-- 하위 카테고리
ALTER TABLE downCategory
	ADD
		CONSTRAINT PK_downCategory -- 하위 카테고리 기본키
		PRIMARY KEY (
			upcg_code,   -- 상위 카테고리 코드
			downcg_code  -- 하위 카테고리 코드
		);

-- 하위 카테고리
ALTER TABLE downCategory
	ADD
		CONSTRAINT FK_upCategory_TO_downCategory -- 상위 카테고리 -> 하위 카테고리
		FOREIGN KEY (
			upcg_code -- 상위 카테고리 코드
		)
		REFERENCES upCategory ( -- 상위 카테고리
			upcg_code -- 상위 카테고리 코드
		)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;
-----------------------------------------------------
-- 상품
ALTER TABLE Products
	DROP CONSTRAINT FK_downCategory_TO_Products; -- 하위 카테고리 -> 상품

-- 상품
ALTER TABLE Products
	DROP CONSTRAINT FK_upCategory_TO_Products; -- 상위 카테고리 -> 상품

-- 상품
ALTER TABLE Products
	DROP CONSTRAINT PK_Products; -- 상품 기본키

-- 상품
DROP TABLE Products;

-- 상품
CREATE TABLE Products (
	pnum        number(8)      NOT NULL, -- 상품번호
	pname       varchar2(30)   NOT NULL, -- 상품명
	pimage1     varchar2(100)  NULL,     -- 이미지1
	pimage2     varchar2(100)  NULL,     -- 이미지2
	pimage3     varchar2(100)  NULL,     -- 이미지3
	price       number(8)      NOT NULL, -- 상품 정가
	saleprice   number(8)      NOT NULL, -- 상품 판매가
	pqty        number(8)      NULL,     -- 상품 수량
	point       number(8)      NULL,     -- 포인트
	pspec       varchar2(20)   NULL,     -- 스펙
	pcontents   varchar2(1000) NULL,     -- 상품설명
	pcompany    varchar2(50)   NULL,     -- 제조사
	pdate       DATE           NULL,     -- 등록일
	upcg_code   number(8)      NULL,     -- 상위 카테고리 코드
	downcg_code number(8)      NULL      -- 하위 카테고리 코드
);

-- 상품 기본키
CREATE UNIQUE INDEX PK_Products
	ON Products ( -- 상품
		pnum ASC -- 상품번호
	);

-- 상품
ALTER TABLE Products
	ADD
		CONSTRAINT PK_Products -- 상품 기본키
		PRIMARY KEY (
			pnum -- 상품번호
		);

-- 상품
ALTER TABLE Products
	ADD
		CONSTRAINT FK_downCategory_TO_Products -- 하위 카테고리 -> 상품
		FOREIGN KEY (
			upcg_code,   -- 상위 카테고리 코드
			downcg_code  -- 하위 카테고리 코드
		)
		REFERENCES downCategory ( -- 하위 카테고리
			upcg_code,   -- 상위 카테고리 코드
			downcg_code  -- 하위 카테고리 코드
		)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;

-- 상품
ALTER TABLE Products
	ADD
		CONSTRAINT FK_upCategory_TO_Products -- 상위 카테고리 -> 상품
		FOREIGN KEY (
			upcg_code -- 상위 카테고리 코드
		)
		REFERENCES upCategory ( -- 상위 카테고리
			upcg_code -- 상위 카테고리 코드
		)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION;
-----------------------------------------------------
select * from tab;
desc upcategory;
desc downcategory;
desc products;
desc member;



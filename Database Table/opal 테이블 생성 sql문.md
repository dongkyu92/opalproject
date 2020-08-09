# opal 테이블 생성 sql문

```sql

-- super Table Create SQL
CREATE TABLE super
(
    super_cd      VARCHAR2(50)    NOT NULL, 
    super_name    VARCHAR2(50)    NULL, 
    CONSTRAINT SUPER_PK PRIMARY KEY (super_cd)
)
/

COMMENT ON TABLE super IS '관리자'
/

COMMENT ON COLUMN super.super_cd IS '관리자 코드'
/

COMMENT ON COLUMN super.super_name IS '관리자 이름'
/


-- super Table Create SQL
CREATE TABLE farm
(
    farm_cd         INT              NOT NULL, 
    farm_name       VARCHAR2(50)     NULL, 
    farm_pnum       VARCHAR2(50)     NULL, 
    farm_content    VARCHAR2(4000)    NULL, 
    CONSTRAINT FARM_PK PRIMARY KEY (farm_cd)
)
/

COMMENT ON TABLE farm IS '농가'
/

COMMENT ON COLUMN farm.farm_cd IS '농가 코드'
/

COMMENT ON COLUMN farm.farm_name IS '농가 이름'
/

COMMENT ON COLUMN farm.farm_pnum IS '농가 전화번호'
/

COMMENT ON COLUMN farm.farm_content IS '농가 소개'
/


CREATE TABLE customer
(
    cust_cd INT NOT NULL primary key, 
    cust_name VARCHAR2(50) NOT NULL, 
    cust_id VARCHAR2(50) NOT NULL, 
    cust_pw VARCHAR2(100) NOT NULL, 
    cust_gender VARCHAR2(50) NOT NULL, 
    cust_email VARCHAR2(50) NOT NULL, 
    cust_pnum VARCHAR2(50) NOT NULL, 
    cust_address VARCHAR2(200) NOT NULL,
    cust_birthday_date date NOT NULL,
    cust_signup_date date default sysdate, 
    cust_info_update_date date default sysdate,
    enabled char(1) default '1',
    AUTHORITY varchar2(50) DEFAULT'ROLE_CUSTOMER' NOT NULL
);


CREATE SEQUENCE customer_SEQ START WITH 1 INCREMENT BY 1;
commit;

-- super Table Create SQL
CREATE TABLE sick
(
    sick_cd      VARCHAR2(50)    NOT NULL, 
    sick_name    VARCHAR2(50)    NOT NULL, 
    super_cd     VARCHAR2(50)    NOT NULL, 
    CONSTRAINT SICK_PK PRIMARY KEY (sick_cd)
)
/

COMMENT ON TABLE sick IS '질병데이터'
/

COMMENT ON COLUMN sick.sick_cd IS '질병 코드'
/

COMMENT ON COLUMN sick.sick_name IS '질병 이름'
/

COMMENT ON COLUMN sick.super_cd IS '관리자 코드'
/

ALTER TABLE sick
    ADD CONSTRAINT FK_sick_super_cd_super_super_c FOREIGN KEY (super_cd)
        REFERENCES super (super_cd)
/


-- farm Table Create SQL
CREATE TABLE product
(
    product_cd         INT              NOT NULL, 
    product_name       VARCHAR2(50)     NOT NULL, 
    product_content    VARCHAR2(200)    NOT NULL, 
    product_price      INT              NOT NULL, 
    product_su         VARCHAR2(200)    NOT NULL, 
    product_url        VARCHAR2(200)    NULL, 
    farm_cd            INT              NOT NULL, 
    CONSTRAINT PRODUCT_PK PRIMARY KEY (product_cd)
)
/

COMMENT ON TABLE product IS '상품'
/

COMMENT ON COLUMN product.product_cd IS '상품 코드'
/

COMMENT ON COLUMN product.product_name IS '상품 이름'
/

COMMENT ON COLUMN product.product_content IS '상품 소개'
/

COMMENT ON COLUMN product.product_price IS '상품 가격'
/

COMMENT ON COLUMN product.product_su IS '상품 수'
/

COMMENT ON COLUMN product.product_url IS '상품 이미지'
/

COMMENT ON COLUMN product.farm_cd IS '농가 코드'
/

ALTER TABLE product
    ADD CONSTRAINT FK_product_farm_cd_farm_farm_c FOREIGN KEY (farm_cd)
        REFERENCES farm (farm_cd)
/


-- super Table Create SQL
CREATE TABLE cart
(
    cart_cd        INT             NOT NULL, 
    cust_cd        VARCHAR2(50)    NOT NULL, 
    product_cd     INT             NOT NULL, 
    cart_amount    INT             NOT NULL, 
    CONSTRAINT CART_PK PRIMARY KEY (cart_cd)
)
/

COMMENT ON TABLE cart IS '장바구니'
/

COMMENT ON COLUMN cart.cart_cd IS '장바구니 코드'
/

COMMENT ON COLUMN cart.cust_cd IS '고객 코드'
/

COMMENT ON COLUMN cart.product_cd IS '상품 코드'
/

COMMENT ON COLUMN cart.cart_amount IS '장바구니 수량'
/

ALTER TABLE cart
    ADD CONSTRAINT FK_cart_product_cd_product_pro FOREIGN KEY (product_cd)
        REFERENCES product (product_cd)
/

ALTER TABLE cart
    ADD CONSTRAINT FK_cart_cust_cd_customer_cust_ FOREIGN KEY (cust_cd)
        REFERENCES customer (cust_cd)
/


-- super Table Create SQL
CREATE TABLE order
(
    order_cd      VARCHAR2(50)    NOT NULL, 
    order_date    DATE            NOT NULL, 
    cart_cd       INT             NOT NULL, 
    CONSTRAINT ORDER_PK PRIMARY KEY (order_cd)
)
/

COMMENT ON TABLE order IS '주문'
/

COMMENT ON COLUMN order.order_cd IS '주문 코드'
/

COMMENT ON COLUMN order.order_date IS '주문 날짜'
/

COMMENT ON COLUMN order.cart_cd IS '장바구니 코드'
/

ALTER TABLE order
    ADD CONSTRAINT FK_order_cart_cd_cart_cart_cd FOREIGN KEY (cart_cd)
        REFERENCES cart (cart_cd)
/


-- super Table Create SQL
CREATE TABLE c_super
(
    super_cd    VARCHAR2(50)    NOT NULL, 
    cust_cd     VARCHAR2(50)    NOT NULL
)
/

COMMENT ON TABLE c_super IS '고객관리'
/

COMMENT ON COLUMN c_super.super_cd IS '관리자 코드'
/

COMMENT ON COLUMN c_super.cust_cd IS '고객 코드'
/

ALTER TABLE c_super
    ADD CONSTRAINT FK_c_super_super_cd_super_supe FOREIGN KEY (super_cd)
        REFERENCES super (super_cd)
/

ALTER TABLE c_super
    ADD CONSTRAINT FK_c_super_cust_cd_customer_cu FOREIGN KEY (cust_cd)
        REFERENCES customer (cust_cd)
/


-- super Table Create SQL
CREATE TABLE badfood
(
    food_cd      VARCHAR2(50)     NOT NULL, 
    food_name    VARCHAR2(50)     NOT NULL, 
    food_img     VARCHAR2(200)    NULL, 
    sick_cd      VARCHAR2(50)     NOT NULL, 
    CONSTRAINT BADFOOD_PK PRIMARY KEY (food_cd, sick_cd)
)
/

COMMENT ON TABLE badfood IS '나쁜음식'
/

COMMENT ON COLUMN badfood.food_cd IS '음식 코드'
/

COMMENT ON COLUMN badfood.food_name IS '음식 이름'
/

COMMENT ON COLUMN badfood.food_img IS '음식 사진'
/

COMMENT ON COLUMN badfood.sick_cd IS '질병 코드'
/

ALTER TABLE badfood
    ADD CONSTRAINT FK_badfood_sick_cd_sick_sick_c FOREIGN KEY (sick_cd)
        REFERENCES sick (sick_cd)
/


-- super Table Create SQL
CREATE TABLE goodfood
(
    food_cd      VARCHAR2(50)     NOT NULL, 
    food_name    VARCHAR2(50)     NOT NULL, 
    food_img     VARCHAR2(200)    NULL, 
    g_img        VARCHAR2(200)    NULL, 
    sick_cd      VARCHAR2(50)     NOT NULL, 
    CONSTRAINT GOODFOOD_PK PRIMARY KEY (food_cd, sick_cd)
)
/

COMMENT ON TABLE goodfood IS '좋은음식'
/

COMMENT ON COLUMN goodfood.food_cd IS '음식 코드'
/

COMMENT ON COLUMN goodfood.food_name IS '음식 이름'
/

COMMENT ON COLUMN goodfood.food_img IS '음식 사진'
/

COMMENT ON COLUMN goodfood.g_img IS '그래프 사진'
/

COMMENT ON COLUMN goodfood.sick_cd IS '질병 코드'
/

ALTER TABLE goodfood
    ADD CONSTRAINT FK_goodfood_sick_cd_sick_sick_ FOREIGN KEY (sick_cd)
        REFERENCES sick (sick_cd)
/


-- super Table Create SQL
CREATE TABLE c_farm
(
    super_cd    VARCHAR2(50)    NOT NULL, 
    farm_cd     INT             NOT NULL
)
/

COMMENT ON TABLE c_farm IS '농가관리'
/

COMMENT ON COLUMN c_farm.super_cd IS '관리자 코드'
/

COMMENT ON COLUMN c_farm.farm_cd IS '농가 코드'
/

ALTER TABLE c_farm
    ADD CONSTRAINT FK_c_farm_super_cd_super_super FOREIGN KEY (super_cd)
        REFERENCES super (super_cd)
/

ALTER TABLE c_farm
    ADD CONSTRAINT FK_c_farm_farm_cd_farm_farm_cd FOREIGN KEY (farm_cd)
        REFERENCES farm (farm_cd)
/


-- super Table Create SQL
CREATE TABLE organic
(
    organic_cd      INT             NOT NULL, 
    organic_num     VARCHAR2(50)    NULL, 
    organic_farm    VARCHAR2(50)    NULL, 
    farm_cd         INT             NULL, 
    CONSTRAINT ORGANIC_PK PRIMARY KEY (organic_cd)
)
/

COMMENT ON TABLE organic IS '친환경인증'
/

COMMENT ON COLUMN organic.organic_cd IS '친환경인증 코드'
/

COMMENT ON COLUMN organic.organic_num IS '친환경인증 번호'
/

COMMENT ON COLUMN organic.organic_farm IS '친환경인증 농가'
/

COMMENT ON COLUMN organic.farm_cd IS '농가 코드'
/

ALTER TABLE organic
    ADD CONSTRAINT FK_organic_farm_cd_farm_farm_c FOREIGN KEY (farm_cd)
        REFERENCES farm (farm_cd)
/


-- super Table Create SQL
CREATE TABLE gap
(
    gap_cd      INT             NOT NULL, 
    gap_num     VARCHAR2(50)    NOT NULL, 
    gap_farm    VARCHAR2(50)    NOT NULL, 
    farm_cd     INT             NULL, 
    CONSTRAINT GAP_PK PRIMARY KEY (gap_cd)
)
/

COMMENT ON TABLE gap IS 'gap인증'
/

COMMENT ON COLUMN gap.gap_cd IS 'gap인증 코드'
/

COMMENT ON COLUMN gap.gap_num IS 'gap인증 번호'
/

COMMENT ON COLUMN gap.gap_farm IS 'gap인증 농가'
/

COMMENT ON COLUMN gap.farm_cd IS '농가 코드'
/

ALTER TABLE gap
    ADD CONSTRAINT FK_gap_farm_cd_farm_farm_cd FOREIGN KEY (farm_cd)
        REFERENCES farm (farm_cd)
/

alter table farm add(farm_url VARCHAR2(200));
select*from farm;

update farm set farm_url = 'farmurl11' where farm_cd = 11;

```


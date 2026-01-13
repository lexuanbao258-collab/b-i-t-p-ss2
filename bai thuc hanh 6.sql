create database EcommerceDB;
create schema  shop;
CREATE TABLE shop.users (
    user_id   SERIAL PRIMARY KEY,
    username  VARCHAR(50)  UNIQUE NOT NULL,
    email     VARCHAR(100) UNIQUE NOT NULL,
    password  VARCHAR(100) NOT NULL,
    role      VARCHAR(20)  NOT NULL,
    CONSTRAINT chk_users_role
        CHECK (role IN ('Customer','Admin'))
);
CREATE TABLE shop.categories (
    category_id   SERIAL PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL
);
CREATE TABLE shop.products (
    product_id   SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price        NUMERIC(10,2) NOT NULL,
    stock        INT NOT NULL,
    category_id  INT,
    CONSTRAINT chk_products_price
        CHECK (price > 0),
    CONSTRAINT chk_products_stock
        CHECK (stock >= 0),
    CONSTRAINT fk_products_category
        FOREIGN KEY (category_id)
        REFERENCES shop.categories(category_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);
CREATE TABLE shop.orders (
    order_id    SERIAL PRIMARY KEY,
    user_id     INT NOT NULL,
    order_date  DATE NOT NULL,
    status      VARCHAR(20) NOT NULL,
    CONSTRAINT chk_orders_status
        CHECK (status IN ('Pending','Shipped','Delivered','Cancelled')),
    CONSTRAINT fk_orders_user
        FOREIGN KEY (user_id)
        REFERENCES shop.users(user_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);
CREATE TABLE shop.orderdetails (
    order_detail_id SERIAL PRIMARY KEY,
    order_id        INT NOT NULL,
    product_id      INT NOT NULL,
    quantity        INT NOT NULL,
    price_each      NUMERIC(10,2) NOT NULL,
    CONSTRAINT chk_orderdetails_quantity
        CHECK (quantity > 0),
    CONSTRAINT chk_orderdetails_price_each
        CHECK (price_each > 0),
    CONSTRAINT fk_orderdetails_order
        FOREIGN KEY (order_id)
        REFERENCES shop.orders(order_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_orderdetails_product
        FOREIGN KEY (product_id)
        REFERENCES shop.products(product_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);
CREATE TABLE shop.payments (
    payment_id   SERIAL PRIMARY KEY,
    order_id     INT NOT NULL,
    amount       NUMERIC(10,2) NOT NULL,
    payment_date DATE NOT NULL,
    method       VARCHAR(30) NOT NULL,
    CONSTRAINT chk_payments_amount
        CHECK (amount >= 0),
    CONSTRAINT chk_payments_method
        CHECK (method IN ('Credit Card','Momo','Bank Transfer','Cash')),
    CONSTRAINT fk_payments_order
        FOREIGN KEY (order_id)
        REFERENCES shop.orders(order_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

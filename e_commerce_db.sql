CREATE TABLE public.categories (
    category_ID SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE 
);


-- public.categories
INSERT INTO public.categories (category_name) VALUES
('Electronics'),
('Clothing'),
('Books'),
('Home Appliances'),
('Beauty & Personal Care'),
('Sports & Outdoors'),
('Groceries'),
('Toys & Games');

SELECT * FROM public.categories; 


CREATE TABLE public.customers (
    customer_ID SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE, 
    phone VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100)
);

--public.customers
INSERT INTO public.customers (first_name, last_name, email, phone, address, city, state) VALUES
('Aarav', 'Sharma', 'aarav.sharma@example.com', '9812345670', '123, Gandhi Marg', 'Mumbai', 'Maharashtra'),
('Aditi', 'Singh', 'aditi.singh@example.com', '9812345671', '45B, Nehru Road', 'Delhi', 'Delhi'),
('Rohan', 'Patel', 'rohan.patel@example.com', '9812345672', '789, MG Road', 'Bengaluru', 'Karnataka'),
('Priya', 'Verma', 'priya.verma@example.com', '9812345673', '101, Residency Road', 'Hyderabad', 'Telangana'),
('Kabir', 'Gupta', 'kabir.gupta@example.com', '9812345674', '50, Park Street', 'Kolkata', 'West Bengal'),
('Ananya', 'Reddy', 'ananya.reddy@example.com', '9812345675', '22, Anna Salai', 'Chennai', 'Tamil Nadu'),
('Siddharth', 'Jain', 'siddharth.jain@example.com', '9812345676', '33, Raja Ram Mohan Roy Rd', 'Pune', 'Maharashtra'),
('Meera', 'Das', 'meera.das@example.com', '9812345677', '15, Lal Bahadur Shastri Rd', 'Ahmedabad', 'Gujarat'),
('Vivek', 'Kumar', 'vivek.kumar@example.com', '9812345678', '99, Vaishali Nagar', 'Jaipur', 'Rajasthan'),
('Ishani', 'Nair', 'ishani.nair@example.com', '9812345679', '6, Panampilly Nagar', 'Kochi', 'Kerala');

SELECT * FROM public.customers; 




CREATE TABLE public.products (
    product_ID SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    description TEXT, 
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0), 
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0), 
    category_ID INT, 
    CONSTRAINT fk_category
        FOREIGN KEY (category_ID)
        REFERENCES public.categories (category_ID)
        ON UPDATE CASCADE 
        ON DELETE SET NULL 
);


-- public.products
INSERT INTO public.products (product_name, description, price, stock_quantity, category_id) VALUES
('Smartphone X', 'Latest model with AI camera', 45000.00, 150, 1), 
('Laptop Pro 15', 'High-performance laptop for professionals', 85000.00, 80, 1), 
('Men''s Casual Shirt', 'Comfortable cotton casual shirt', 899.50, 500, 2), 
('Women''s Denim Jeans', 'Stylish high-waist denim jeans', 1499.00, 350, 2), 
('The Alchemist', 'A philosophical novel by Paulo Coelho', 350.00, 1000, 3), 
('India After Gandhi', 'The History of the World''s Largest Democracy by Ramachandra Guha', 999.00, 250, 3), 
('Smart LED TV 50-inch', '4K UHD Smart TV with voice assistant', 40000.00, 60, 4), 
('Washing Machine 7kg', 'Fully automatic front-load washing machine', 22000.00, 40, 4), 
('Herbal Face Wash', 'Natural ingredients for glowing skin', 250.00, 700, 5), 
('Cricket Bat - English Willow', 'Professional grade cricket bat', 12000.00, 30, 6), 
('Organic Basmati Rice 5kg', 'Premium quality long-grain rice', 750.00, 1200, 7), 
('Remote Control Car', 'High-speed remote control car for kids', 1200.00, 200, 8); 

SELECT * FROM public.products; 




CREATE TABLE public.orders (
    order_ID SERIAL PRIMARY KEY,
    customer_ID INT NOT NULL, 
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount NUMERIC(10, 2) NOT NULL CHECK (total_amount >= 0),
    status VARCHAR(50) NOT NULL DEFAULT 'Pending',
    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id)
        REFERENCES public.Customers (customer_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT 
);


-- public.orders
INSERT INTO public.orders (customer_id, order_date, total_amount, status) VALUES
(1, '2024-01-15 10:30:00', 45899.50, 'Delivered'),   
(2, '2024-01-20 14:00:00', 85000.00, 'Shipped'),     
(3, '2024-02-01 11:45:00', 1499.00, 'Pending'),     
(4, '2024-02-05 09:10:00', 1349.00, 'Delivered'), 
(5, '2024-03-10 16:20:00', 41200.00, 'Processing'),  
(1, '2024-03-12 18:00:00', 750.00, 'Delivered'),    
(6, '2024-04-01 08:30:00', 22000.00, 'Shipped'),     
(7, '2024-04-15 17:00:00', 12000.00, 'Pending');    

SELECT * FROM public.orders; 



CREATE TABLE public.order_items (
    order_item_ID SERIAL PRIMARY KEY,
    order_ID INT NOT NULL, 
    product_ID INT NOT NULL, 
    quantity INT NOT NULL CHECK (quantity > 0), 
    unit_price NUMERIC(10, 2) NOT NULL CHECK (unit_price >= 0), 
    CONSTRAINT fk_order
        FOREIGN KEY (order_ID)
        REFERENCES public.orders (order_ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE, 
    CONSTRAINT fk_product
        FOREIGN KEY (product_ID)
        REFERENCES public.products (product_ID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT, 
    CONSTRAINT unique_order_product UNIQUE (order_ID, product_ID) 
);

-- public.order_items
INSERT INTO public.order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 45000.00), 
(1, 3, 1, 899.50),   
(2, 2, 1, 85000.00), 
(3, 4, 1, 1499.00),  
(4, 5, 1, 350.00),   
(4, 9, 1, 250.00),   
(5, 7, 1, 40000.00), 
(5, 12, 1, 1200.00), 
(6, 11, 1, 750.00),  
(7, 8, 1, 22000.00), 
(8, 10, 1, 12000.00); 

SELECT * FROM public.order_items; 


CREATE INDEX idx_products_category_ID ON public.products (category_ID);
CREATE INDEX idx_orders_customer_ID ON public.orders (customer_ID);
CREATE INDEX idx_order_items_order_ID ON public.order_Items (order_ID);
CREATE INDEX idx_order_items_product_ID ON public.order_Items (product_ID);





--  Get customer's orders with product details
SELECT
    c.first_name,
    c.last_name,
    o.order_id,
    o.order_date,
    o.total_amount,
    o.status,
    p.product_name,
    oi.quantity,
    oi.unit_price
FROM
    public.customers c
JOIN
    public.orders o ON c.customer_id = o.customer_id
JOIN
    public.order_items oi ON o.order_id = oi.order_id
JOIN
    public.products p ON oi.product_id = p.product_id
ORDER BY
    o.order_date DESC, c.customer_id, p.product_name;



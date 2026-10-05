CREATE DATABasE RetailAnalyticsDB;
USE RetailAnalyticsDB;
CREATE TABLE items
(
item_id INT PRIMARY KEY AUTO_INCREMENT,
item_name VARCHAR(100),
category VARCHAR(50),
brand VARCHAR(50),
purchase_price DECIMAL(10,2),
selling_price DECIMAL(10,2),
stock_quantity INT,
supplier_name VARCHAR(100)
);
INSERT INTO items
(item_name,category,brand,purchase_price,selling_price,stock_quantity,supplier_name)
VALUES
('Laptop','Electronics','HP',45000,52000,40,'ABC Traders'),
('Mobile','Electronics','Samsung',18000,22000,80,'XYZ Electronics'),
('Refrigerator','Electronics','LG',28000,34000,25,'Cool Appliances'),
('Office Chair','Furniture','Nilkamal',2200,3500,100,'Furniture World'),
('Dining Table','Furniture','Godrej',12000,17000,30,'Furniture World'),
('Rice 10kg','Grocery','India Gate',700,900,250,'Fresh Foods'),
('Cooking Oil','Grocery','Fortune',120,170,300,'Fresh Foods'),
('T-Shirt','Clothing','Levis',500,900,150,'Fashion Hub');

CREATE TABLE orders
(
order_id INT PRIMARY KEY AUTO_INCREMENT,
order_date DATE,
customer_name VARCHAR(100),
city VARCHAR(50),
payment_mode VARCHAR(30),
quantity INT,
item_id INT,
FOREIGN KEY(item_id)
REFERENCES items(item_id)
);
INSERT INTO orders
(order_date,customer_name,city,payment_mode,quantity,item_id)
VALUES
('2026-01-02','Rahul','Delhi','UPI',2,2),
('2026-01-03','Priya','Noida','Cash',1,1),
('2026-01-05','Amit','Delhi','Card',3,6),
('2026-01-07','Neha','Mumbai','UPI',1,3),
('2026-01-09','Rohit','Pune','Card',2,4),
('2026-01-10','Pooja','Delhi','Cash',5,7),
('2026-01-12','Ankit','Jaipur','UPI',2,8),
('2026-01-14','Komal','Delhi','Card',1,5),
('2026-01-16','Mohit','Noida','UPI',2,2),
('2026-01-18','Nisha','Lucknow','Cash',1,1);

#1.	Display all items.
select * from items;

#2.	Display all orders.
select * from orders;

#3.	Show Electronics products.
select item_id, item_name, category from items where category = "Electronics";

#4.	Display orders from Delhi.
select * from orders where city = "Delhi";

#5.	Show products with stock greater than 100.
select item_id, item_name, category, stock_quantity from items where stock_quantity > 100;

#6.	Display orders paid using UPI.
select order_id, order_date, quantity from orders where payment_mode = "UPI";

#7.	Display products costing more than ₹20,000.
select item_id, item_name, category, purchase_price from items where purchase_price > 20000;

#8.	Display unique cities.
select distinct city from orders;

#9.	Sort items by selling price.
select item_id, item_name, category, brand, selling_price from items order by selling_price desc;  

#10. 	Display top 5 expensive products
select item_id, item_name, category, brand, selling_price from items order by selling_price desc limit 5;  

#11. 	Display customer name, item name and quantity
select o.customer_name, i.item_name, o.quantity from orders o inner join items i on o.item_id = i.item_id;

#12. 	Display category and customer name.
select i.category, o.customer_name from items i inner join orders o on i.item_id = o.item_id;

#13. 	Display brand and quantity sold.
select i.brand, o.quantity as "Quantity Sold" from items i inner join orders o on i.item_id = o.item_id;

select i.brand, sum(o.quantity) as "Quantity Sold" from items i inner join orders o on i.item_id = o.item_id group by 1;

#14. 	Display selling price with customer.
select o.customer_name, i.selling_price from items i inner join orders o on i.item_id = o.item_id;

#15. 	Display supplier name with customer
select o.customer_name, i.supplier_name from items i inner join orders o on i.item_id = o.item_id;

#16.	Product-wise quantity sold.
select i.item_name, sum(o.quantity) as quantity_sold from items i inner join orders o on i.item_id = o.item_id group by i.item_name;

#17.	Category-wise sales quantity.
select i.category, sum(o.quantity) as Sold_Quantity from items i inner join orders o on i.item_id = o.item_id group by i.category;

#18.	Brand-wise quantity sold.
select i.brand, sum(o.quantity) as Sold_Quantity from items i inner join orders o on i.item_id = o.item_id group by i.brand;

#19.	Supplier-wise sales.
select i.supplier_name, sum(o.quantity) as quantity_sold, sum(i.selling_price * o.quantity) as sale_amount
from items i inner join orders o
on i.item_id = o.item_id
group by i.supplier_name;

#20.	City-wise orders.
select o.city, sum(o.quantity) as order_quantity, sum(i.selling_price * o.quantity) as order_sale_amount 
from orders o left join items i 
on o.item_id = i.item_id 
group by city; 

#21.	Payment mode analysis.
select o.payment_mode, sum(i.selling_price * o.quantity) as Sale_Amount 
from orders o left join items i
on o.item_id = i.item_id
group by 1;

#22.	Number of orders per product.
select i.item_id, i.item_name, count(o.order_id) as number_of_products
from items i right join orders o 
on o.item_id = i.item_id
group by 1,2;

#23.	Category-wise products.
select category, item_name from items;

#24.	Brand-wise products.
select brand, item_name from items;

#25.	Supplier-wise products.
select supplier_name, item_name from items;

#26.	Most sold product.
select i.item_id, i.item_name, sum(o.quantity) as sold_quantity 
from items i right join orders o
on i.item_id = o.item_id
group by i.item_id, i.item_name 
order by sold_quantity desc limit 1; 

#27.	Least sold product.
select i.item_id, i.item_name, sum(o.quantity) as sold_quantity 
from items i right join orders o
on i.item_id = o.item_id
group by i.item_id, i.item_name 
order by sold_quantity limit 1; 

#28.	Highest selling price product.
select i.item_id, i.item_name, i.selling_price, o.quantity
from items i right join orders o
on i.item_id = o.item_id
order by i.selling_price desc limit 1;

#29.	Lowest selling price product.
select i.item_id, i.item_name, i.selling_price, o.quantity
from items i right join orders o
on i.item_id = o.item_id
order by i.selling_price limit 1;

#30.	Average selling price.
select round(avg(selling_price),2) as avg_selling_price from items;

#31.	Total stock available.
select item_id, item_name, sum(stock_quantity) as stock_available from items group by item_id, item_name;

#stock available after orders:
select i.item_id, i.item_name, (sum(i.stock_quantity) - sum(o.quantity)) as Available_Quantity 
from items i left join orders o 
on i.item_id = o.item_id 
group by 1,2;

#32.	Total quantity sold.
select sum(quantity) as total_quantity_sold from orders; 

#33.	Total number of products.
select count(item_name) as total_product_count from items;

#34.	Total number of orders.
select count(order_id) as total_orders from orders;

#35.	Average order quantity
select round(avg(quantity),2) as average_order_quantity from orders;

#36.	Which category is most popular?
select i.category, sum(o.quantity) as order_quantity from items i right join orders o on i.item_id = o.item_id group by i.category order by order_quantity desc limit 1;

#37.	Which city places the most orders?
select * from orders;
select city, count(order_id) as total_orders 
from orders
group by city
order by total_orders desc limit 1;

#38.	Which supplier's products sell the most?
select i.supplier_name, sum(o.quantity) as Quantity_Sold 
from items i right join orders o
on i.item_id = o.item_id
group by i.supplier_name
order by Quantity_Sold desc limit 1;

#39.	Which payment mode is most used?
select payment_mode, count(order_id) as order_count from orders group by payment_mode order by order_count desc limit 1;

#40.	Which product has never been ordered?
select i.item_id, i.item_name 
from items i left join orders o
on i.item_id = o.item_id 
where o.item_id is null;

#41.	Which products have low stock (less than 20)?
select item_id, item_name from items where stock_quantity < 20;

#42.	Which customers bought Electronics?
select o.customer_name, o.city, i.category, i.item_name 
from orders o inner join items i 
on o.item_id = i.item_id
where i.category = 'Electronics';

#43.	Which customers bought Furniture?
select o.customer_name, o.city, i.category, i.item_name 
from orders o inner join items i 
on o.item_id = i.item_id
where i.category = 'Furniture';

#44.	Which brand generated the highest sales quantity?
select i.brand, sum(o.quantity) as sale_qty
from items i right join orders o
on i.item_id = o.item_id
group by i.brand
order by sale_qty desc limit 1;

#45.	Which product has the highest stock?
select item_name, stock_quantity from items order by stock_quantity desc limit 1;

#46.	Which product has the lowest stock?
select item_name, stock_quantity from items order by stock_quantity limit 1;

#47.	Which city purchased the highest quantity?
select city, sum(quantity) as total_quantity from orders group by city order by total_quantity desc limit 1;

#48.	Which supplier has the highest number of products?
select supplier_name, count(item_id) as product_count from items group by supplier_name order by product_count desc limit 1;

#49.	Which product category should be restocked first?
select category, sum(stock_quantity) as total_stock from items group by category order by total_stock limit 1;

#50.	Create a KPI report showing: Total Products, Total Orders, Total Quantity Sold, Total Stock Available, Average Selling Price
select COUNT(i.item_id) as total_products,
    (select COUNT(order_id) from orders) as total_orders,
    (select sum(quantity) from orders) as total_quantity_sold,
    sum(i.stock_quantity) as total_stock_available,
    round(avg(i.selling_price), 2) as average_selling_price
from items i;

#51. 	Calculate Revenue Generated by Each Product
select i.item_id, i.item_name, sum(i.selling_price * o.quantity) as revenue
from items i inner join orders o
on i.item_id = o.item_id
group by i.item_id, i.item_name;

#52. 	Top 3 Revenue-Generating Products
select i.item_id, i.item_name, sum(i.selling_price * o.quantity) as revenue
from items i inner join orders o
on i.item_id = o.item_id
group by i.item_id, i.item_name
order by revenue desc limit 3;

#53. 	Category-wise Revenue
select i.category, sum(i.selling_price * o.quantity) as revenue
from items i inner join orders o
on i.item_id = o.item_id
group by i.category;

#54. 	Supplier-wise Revenue
select i.supplier_name, sum(i.selling_price * o.quantity) as revenue
from items i inner join orders o
on i.item_id = o.item_id
group by i.supplier_name;

#55. 	Average Revenue Per Order
select round(avg(i.selling_price * o.quantity), 2) as average_revenue_per_order
from orders o
inner join items i
on o.item_id = i.item_id;



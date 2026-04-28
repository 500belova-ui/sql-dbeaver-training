DROP TABLE IF EXISTS support_tickets;
DROP TABLE IF EXISTS shipments;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    city VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    category_id INT REFERENCES categories(id),
    name VARCHAR(150) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    status VARCHAR(30) NOT NULL,
    total_amount NUMERIC(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(id),
    product_id INT REFERENCES products(id),
    quantity INT NOT NULL,
    price_at_moment NUMERIC(10, 2) NOT NULL
);

CREATE TABLE payments (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(id),
    amount NUMERIC(10, 2) NOT NULL,
    status VARCHAR(30) NOT NULL,
    payment_method VARCHAR(50),
    paid_at TIMESTAMP
);

CREATE TABLE shipments (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(id),
    status VARCHAR(30) NOT NULL,
    tracking_number VARCHAR(100),
    shipped_at TIMESTAMP,
    delivered_at TIMESTAMP
);

CREATE TABLE support_tickets (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    order_id INT REFERENCES orders(id),
    subject VARCHAR(200) NOT NULL,
    status VARCHAR(30) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO users (full_name, email, city) VALUES
('Anna Petrova', 'anna@test.com', 'Yerevan'),
('Mike Brown', 'mike@test.com', 'London'),
('Sofia Green', 'sofia@test.com', 'Berlin'),
('David Smith', 'david@test.com', 'Paris'),
('Lena Ivanova', 'lena@test.com', 'Yerevan');

INSERT INTO categories (name) VALUES
('Electronics'),
('Books'),
('Clothes'),
('Home');

INSERT INTO products (category_id, name, price, stock_quantity, is_active) VALUES
(1, 'Wireless Mouse', 25.00, 40, TRUE),
(1, 'Keyboard', 45.00, 20, TRUE),
(2, 'SQL for Beginners', 18.50, 15, TRUE),
(2, 'Testing Web Applications', 30.00, 8, TRUE),
(3, 'T-Shirt', 12.00, 100, TRUE),
(4, 'Coffee Mug', 9.99, 50, TRUE),
(NULL, 'Mystery Product', 99.99, 5, TRUE),
(1, 'Old Headphones', 15.00, 0, FALSE);

INSERT INTO orders (user_id, status, total_amount, created_at) VALUES
(1, 'paid', 70.00, '2026-04-01 10:00:00'),
(1, 'delivered', 18.50, '2026-04-02 12:30:00'),
(2, 'created', 45.00, '2026-04-03 09:15:00'),
(3, 'paid', 30.00, '2026-04-04 14:20:00'),
(4, 'cancelled', 12.00, '2026-04-05 16:45:00'),
(5, 'paid', 109.98, '2026-04-06 11:10:00');

INSERT INTO order_items (order_id, product_id, quantity, price_at_moment) VALUES
(1, 1, 1, 25.00),
(1, 2, 1, 45.00),
(2, 3, 1, 18.50),
(3, 2, 1, 45.00),
(4, 4, 1, 30.00),
(5, 5, 1, 12.00),
(6, 6, 1, 9.99),
(6, 7, 1, 99.99);

INSERT INTO payments (order_id, amount, status, payment_method, paid_at) VALUES
(1, 70.00, 'success', 'card', '2026-04-01 10:05:00'),
(2, 18.50, 'success', 'paypal', '2026-04-02 12:35:00'),
(4, 30.00, 'success', 'card', '2026-04-04 14:25:00'),
(5, 12.00, 'failed', 'card', NULL),
(6, 109.98, 'success', 'card', '2026-04-06 11:15:00');

INSERT INTO shipments (order_id, status, tracking_number, shipped_at, delivered_at) VALUES
(1, 'shipped', 'TRK-1001', '2026-04-01 18:00:00', NULL),
(2, 'delivered', 'TRK-1002', '2026-04-02 18:00:00', '2026-04-04 13:00:00'),
(5, 'cancelled', NULL, NULL, NULL);

INSERT INTO support_tickets (user_id, order_id, subject, status, created_at) VALUES
(1, 1, 'Where is my order?', 'open', '2026-04-02 09:00:00'),
(2, 3, 'Payment button does not work', 'open', '2026-04-03 10:00:00'),
(4, 5, 'I want to cancel my order', 'closed', '2026-04-05 17:00:00'),
(5, 6, 'Wrong product in order', 'open', '2026-04-07 08:30:00');
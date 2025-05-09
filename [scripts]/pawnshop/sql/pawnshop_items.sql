CREATE TABLE pawnshop_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    seller_cid VARCHAR(50),
    item_name VARCHAR(50),
    item_label VARCHAR(50),
    amount INT,
    price INT,
    UNIQUE (id)
);

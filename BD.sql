DROP TABLE IF EXISTS inventory; 

CREATE TABLE inventory (
item_name VARCHAR (50) NOT NULL,
quantity INTEGER DEFAULT 0 CHECK (quantity >=0),
category VARCHAR (50),
is_available BOOLEAN DEFAULT TRUE
);
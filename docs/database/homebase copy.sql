-- Create schema for Homebase
CREATE SCHEMA homebase;

-- Users
CREATE TABLE users(
    user_id serial PRIMARY KEY,
    name varchar(50) NOT NULL,
    email varchar(100) UNIQUE NOT NULL,
    password varchar(255) NOT NULL,
    joined_date date NOT NULL
);

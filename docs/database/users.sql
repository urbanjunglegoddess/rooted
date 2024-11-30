--Database: users
--Schema:main
--Table: users,

-- DROP TABLE IF EXISTS users;
CREATE SEQUENCE user_id_seq
    START WITH 100000000
    INCREMENT BY 1
    MINVALUE 100000000
    MAXVALUE 999999999
    NO CYCLE;

CREATE TABLE users (
   user_id BIGINT PRIMARY KEY NOT NULL UNIQUE DEFAULT nextval('user_id_seq'),
    name varchar(100),
    first_name varchar(100),
    last_name varchar(100),
    username VARCHAR(100) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    full_name VARCHAR(255),
    profile_picture TEXT, -- URL of the profile picture
    bio TEXT,
    location VARCHAR(100),
     city varchar(100),
	state varchar(100),
	country varchar(100),
    website_url TEXT,
    gender VARCHAR(50),
    ethnicity varchar(50),
	language varchar(100),
	sec_language varchar(100),
	other_languages text,
    date_of_birth DATE,
    is_active BOOLEAN DEFAULT TRUE,
    joined TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




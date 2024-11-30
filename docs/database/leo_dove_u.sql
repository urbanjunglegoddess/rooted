create database leo_dove_u;

-- Schema for Homebase
CREATE SCHEMA homebase;

-- Table for Homebase
CREATE TABLE homebase.HomebaseTable (
    homebase_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    description TEXT
);

-- Schema for Phantom Rail
CREATE SCHEMA phantom_rail;

-- Table for Phantom Rail
CREATE TABLE phantom_rail.PhantomRailTable (
    phantom_rail_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    route VARCHAR(255),
    description TEXT
);

-- Schema for Big Biz District
CREATE SCHEMA big_biz_district;

-- Table for Big Biz District
CREATE TABLE big_biz_district.BigBizDistrictTable (
    big_biz_district_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    description TEXT
);

-- Schema for Playground
CREATE SCHEMA playground;

-- Table for Playground
CREATE TABLE playground.PlaygroundTable (
    playground_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    description TEXT
);

-- Schema for Rising
CREATE SCHEMA rising;

-- Table for Rising
CREATE TABLE rising.RisingTable (
    rising_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    description TEXT
);

-- Schema for Mouseion
CREATE SCHEMA mouseion;

-- Table for Mouseion
CREATE TABLE mouseion.MouseionTable (
    mouseion_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    description TEXT
);

-- Schema for Afro Art Collective
CREATE SCHEMA afro_art_collective;

-- Table for Afro Art Collective
CREATE TABLE afro_art_collective.AfroArtCollectiveTable (
    afro_art_collective_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    description TEXT
);

-- Schema for Jungle Book
CREATE SCHEMA jungle_book;

-- Table for Jungle Book
CREATE TABLE jungle_book.JungleBookTable (
    jungle_book_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    description TEXT
);


-- Table for Businesses
CREATE TABLE Businesses (
    business_id SERIAL PRIMARY KEY,
    business_name VARCHAR(255) NOT NULL,
    business_description TEXT,
    founding_date DATE,
    industry VARCHAR(100),
    website_url VARCHAR(255),
    about_us TEXT,
    logo_url VARCHAR(255)
);

-- Table for Business Plan
CREATE TABLE business_plan (
    plan_id SERIAL PRIMARY KEY,
    business_id INT REFERENCES Businesses(business_id),
    plan_content TEXT
);

-- Table for Investment Profile
CREATE TABLE investment (
    investment_id SERIAL PRIMARY KEY,
    business_id INT REFERENCES Businesses(business_id),
    funding_goal DECIMAL(15, 2),
    current_funding DECIMAL(15, 2),
    investor_count INT
);

-- Table for Products
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    business_id INT REFERENCES Businesses(business_id),
    product_name VARCHAR(255),
    description TEXT,
    price DECIMAL(10, 2)
);

-- Table for Services
CREATE TABLE services (
    service_id SERIAL PRIMARY KEY,
    business_id INT REFERENCES Businesses(business_id),
    service_name VARCHAR(255),
    description TEXT,
    price DECIMAL(10, 2)
);

-- Table for Crowdfunding Profile
CREATE TABLE crowdfunding (
    crowdfunding_id SERIAL PRIMARY KEY,
    business_id INT REFERENCES Businesses(business_id),
    campaign_name VARCHAR(255),
    campaign_description TEXT,
    funding_goal DECIMAL(15, 2),
    current_funding DECIMAL(15, 2),
    end_date DATE
);

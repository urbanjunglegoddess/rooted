CREATE TABLE users(
    user_id BIGINT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    profile_picture_url TEXT,
    first_name VARCHAR(50),
    middle_name VARCHAR(50),
    last_name VARCHAR(50),
    nickname VARCHAR(50),
    mobile_phone VARCHAR(15),
    house_phone VARCHAR(15),
    work_phone VARCHAR(15),
    home_address TEXT,
    email VARCHAR(100) UNIQUE NOT NULL,
    personal_website VARCHAR(255),
    gender VARCHAR(10),
    ethnicity VARCHAR(50),
    work_status VARCHAR(50),
    birthdate DATE,
    highest_education VARCHAR(100),
    biometric_data BYTEA, -- Byte array for biometric data
    password VARCHAR(255) -- Store the hashed password
);

ALTER TABLE PUBLIC.USERS 
ADD COLUMN profile_id INT;
ALTER TABLE PUBLIC.USERS 
ADD COLUMN business_id INT;
ALTER TABLE PUBLIC.USERS 
ADD COLUMN business_profile_id INT; 

-- Create a table for authentication methods
CREATE TABLE authentication_methods(
    method_id SERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users(user_id),
    method_name VARCHAR(50) NOT NULL,
    UNIQUE(user_id, method_name)
);

-- Create a table for user_roles
CREATE TABLE user_roles(
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL
);

-- Create a table for user_permissions
CREATE TABLE user_permissions(
    permission_id SERIAL PRIMARY KEY,
    role_id INT REFERENCES user_roles(role_id),
    permission_name VARCHAR(100) NOT NULL
);


-- Create a function to generate a random 10-digit number
CREATE OR REPLACE FUNCTION generate_unique_id()
    RETURNS BIGINT AS $$
BEGIN
    -- Generate a random number between 1000000000 and 9999999999
    -- by generating two 5-digit random numbers and concatenating them.
    RETURN (floor(random() * 90000 + 10000)::BIGINT * 100000 + floor(random() * 90000 + 10000)::BIGINT);
END;
$$ LANGUAGE plpgsql;


DROP FUNCTION generate_unique_id;

-- Insert a new user with a random 10-digit ID
INSERT INTO users (user_id, username)
VALUES (generate_unique_id()::BIGINT, 'john_doe');


CREATE TABLE widgets(
    widget_id SERIAL PRIMARY KEY,
    widget_name VARCHAR(100) NOT NULL,
    description TEXT
    -- Add other widget properties as needed
);


CREATE TABLE notifications(
    notification_id SERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users(user_id),
    content TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
    -- Add other notification-related fields as needed
);


CREATE TABLE user_settings(
    setting_id SERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users(user_id),
    setting_name VARCHAR(100) NOT NULL,
    setting_value TEXT,
    UNIQUE(user_id, setting_name)
);

CREATE TABLE messages(
    message_id SERIAL PRIMARY KEY,
    sender_id BIGINT REFERENCES users(user_id),
    receiver_id BIGINT REFERENCES users(user_id),
    message_content TEXT,
    timestamp TIMESTAMPTZ DEFAULT NOW()
);


CREATE TABLE groups(
    group_id SERIAL PRIMARY KEY,
    group_name VARCHAR(100)
    -- Add other group-related fields as needed
);

CREATE TABLE user_activity(
    activity_id SERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users(user_id),
    activity_type VARCHAR(50) NOT NULL,
    activity_timestamp TIMESTAMPTZ DEFAULT NOW()
    -- Add other activity-related fields as needed
);


CREATE TABLE auth_tokens(
    token_id SERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users(user_id),
    token_value VARCHAR(255),
    expiration_timestamp TIMESTAMPTZ
    -- Add other token-related fields as needed
);


CREATE TABLE user_profiles (
    profile_id SERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users(user_id),
    display_name VARCHAR(100), 
    profile_picture_url TEXT,
    first_name VARCHAR(50),
    middle_name VARCHAR(50),
    last_name VARCHAR(50),
    nickname VARCHAR(50),
    mobile_phone VARCHAR(15),
    email VARCHAR(100),
    personal_website TEXT,
    ethnicity VARCHAR(50),
    work_status VARCHAR(50),
    biometric_data BYTEA
);

CREATE TABLE user_preferences (
    user_id BIGINT PRIMARY KEY REFERENCES users(user_id),
    theme_preference VARCHAR(50),
    notification_settings JSONB, -- Store notification preferences as JSON
    language_preference VARCHAR(10)
);

CREATE TABLE user_social_media (
    user_id BIGINT PRIMARY KEY REFERENCES users(user_id),
    facebook_profile VARCHAR(100),
    twitter_profile VARCHAR(100),
    linkedin_profile VARCHAR(100),
    instagram_profile VARCHAR(100)
);

CREATE TABLE user_interests (
    user_id BIGINT PRIMARY KEY REFERENCES users(user_id),
    interest_name VARCHAR(100)
);

CREATE TABLE user_activity_log (
    log_id SERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users(user_id),
    activity_type VARCHAR(50),
    activity_description TEXT,
    timestamp TIMESTAMPTZ DEFAULT NOW()
);


CREATE TABLE user_addresses (
    address_id SERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users(user_id),
    address_type VARCHAR(50),
    street_address TEXT,
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    country VARCHAR(50)
);

CREATE TABLE user_privacy_settings (
    user_id BIGINT PRIMARY KEY REFERENCES users(user_id),
    profile_visibility BOOLEAN,
    contact_visibility BOOLEAN
);







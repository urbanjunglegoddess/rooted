-- Create a PostgreSQL database
CREATE DATABASE entrepreneur_freelancer_db;

-- Connect to the newly created database
\c entrepreneur_freelancer_db;

-- Create the Client/Customer Relationship table
CREATE TABLE client_relationship (
    client_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_phone VARCHAR(15),
    contact_email VARCHAR(255),
    company_name VARCHAR(255),
    project_details TEXT,
    billing_history TEXT,
    communication_records TEXT,
    payment_history TEXT,
    notes TEXT
);

-- Create the Income and Expense Tracking table
CREATE TABLE income_expense_tracking (
    transaction_id SERIAL PRIMARY KEY,
    transaction_date DATE NOT NULL,
    income_source VARCHAR(255),
    income_description TEXT,
    income_amount NUMERIC(10, 2),
    expense_category VARCHAR(255),
    expense_description TEXT,
    expense_amount NUMERIC(10, 2),
    payment_method VARCHAR(50),
    notes TEXT
);

-- Create the Project Management table
CREATE TABLE project_management (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(255) NOT NULL,
    client_name VARCHAR(255),
    project_description TEXT,
    project_deadline DATE,
    task_lists TEXT,
    task_assignees TEXT,
    task_status TEXT,
    task_deadlines TEXT,
    task_notes TEXT,
    attachments BYTEA
);

-- Create the Inventory/Product table (if applicable)
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    product_description TEXT,
    sku_id VARCHAR(50),
    pricing NUMERIC(10, 2),
    quantity_on_hand INT,
    supplier_info TEXT,
    product_type VARCHAR(100),
    product_category VARCHAR(255),
    product_image BYTEA,
    notes TEXT
);

-- Create the Time Tracking and Invoicing table
CREATE TABLE time_tracking_invoicing (
    entry_id SERIAL PRIMARY KEY,
    entry_date DATE NOT NULL,
    project_client_name VARCHAR(255),
    task_description TEXT,
    hours_worked NUMERIC(6, 2),
    billable_rate NUMERIC(10, 2),
    total_amount NUMERIC(10, 2),
    invoice_generation_status VARCHAR(50),
    notes TEXT
);

-- Create other tables following a similar pattern for each category

-- Don't forget to customize the table structures as needed for your specific requirements
-- Create the Content and Marketing table
CREATE TABLE content_marketing (
    content_id SERIAL PRIMARY KEY,
    content_title VARCHAR(255) NOT NULL,
    content_type VARCHAR(50),
    publication_date DATE,
    target_audience TEXT,
    performance_metrics JSONB,
    keywords TEXT,
    notes TEXT,
    attachments BYTEA
);

-- Create the Contacts and Networking table
CREATE TABLE contacts_networking (
    contact_id SERIAL PRIMARY KEY,
    contact_name VARCHAR(255) NOT NULL,
    organization_name VARCHAR(255),
    contact_phone VARCHAR(15),
    contact_email VARCHAR(255),
    event_attended TEXT,
    notes TEXT,
    next_steps TEXT,
    interaction_date DATE
);

-- Create the File and Document Repository table
CREATE TABLE document_repository (
    document_id SERIAL PRIMARY KEY,
    document_name VARCHAR(255) NOT NULL,
    description TEXT,
    version VARCHAR(50),
    upload_date DATE,
    access_permissions JSONB,
    category_folder VARCHAR(255),
    notes TEXT,
    document_file BYTEA
);

-- Create the Tax and Financial Records table
CREATE TABLE tax_financial_records (
    record_id SERIAL PRIMARY KEY,
    record_type VARCHAR(255) NOT NULL,
    record_date DATE,
    amount NUMERIC(10, 2),
    category VARCHAR(255),
    notes TEXT
);

-- Create the Client Feedback and Testimonials table
CREATE TABLE client_feedback_testimonials (
    feedback_id SERIAL PRIMARY KEY,
    client_name VARCHAR(255) NOT NULL,
    project_name VARCHAR(255),
    feedback_review TEXT,
    rating INT,
    usage_permissions JSONB,
    date_received DATE,
    notes TEXT
);

-- Create the Goal Tracking and Progress table
CREATE TABLE goal_tracking_progress (
    goal_id SERIAL PRIMARY KEY,
    goal_description TEXT NOT NULL,
    target_date DATE,
    current_status VARCHAR(255),
    milestones_achieved TEXT,
    action_steps TEXT,
    notes TEXT
);

-- Create the Social Media Analytics table
CREATE TABLE social_media_analytics (
    analytics_id SERIAL PRIMARY KEY,
    platform VARCHAR(50) NOT NULL,
    date DATE,
    post_metrics JSONB,
    audience_demographics JSONB,
    notes TEXT
);

-- Create the Employee or Contractor table (if applicable)
CREATE TABLE employees_contractors (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_phone VARCHAR(15),
    contact_email VARCHAR(255),
    role_position VARCHAR(255),
    hire_date DATE,
    payroll_details TEXT,
    performance_reviews TEXT,
    notes TEXT
);

-- Create other tables following a similar pattern for each category

-- Don't forget to customize the table structures as needed for your specific requirements
-- Create the Market Research and Competitor table
CREATE TABLE market_research_competitor (
    research_id SERIAL PRIMARY KEY,
    market_data TEXT,
    competitor_name VARCHAR(255),
    competitor_profile TEXT,
    pricing_strategy TEXT,
    market_share_statistics TEXT,
    notes TEXT
);

-- Create the Equipment and Asset Inventory table (if applicable)
CREATE TABLE equipment_asset_inventory (
    asset_id SERIAL PRIMARY KEY,
    asset_name VARCHAR(255) NOT NULL,
    description TEXT,
    serial_number VARCHAR(50),
    maintenance_history TEXT,
    location VARCHAR(255),
    purchase_date DATE,
    warranty_info TEXT,
    notes TEXT
);

-- You can continue creating additional tables for other categories as needed

-- Don't forget to customize the table structures according to your specific requirements



-- Create the Services table
CREATE TABLE services (
    service_id SERIAL PRIMARY KEY,
    service_name VARCHAR(255) NOT NULL,
    description TEXT,
    hourly_rate NUMERIC(10, 2),
    hours_to_perform Integer,
    availability BOOLEAN,
    notes TEXT
);


-- Create a position table
CREATE TABLE positions (id SERIAL PRIMARY KEY,
		title VARCHAR(255) NOT NULL
		);
		
		
		-- Insert titles into the Positions table
INSERT INTO positions (title)
VALUES
    ('Herbalist'),
    ('Data Analyst'),
    ('Data Engineer'),
    ('Business Intelligence Analyst'),
    ('Business Analyst'),
    ('Project Manager'),
    ('Business Development Manager'),
    ('Business Consultant'),
    ('Data Warehouse Architect'),
    ('Data Scientist'),
    ('Cloud Solutions Architect'),
    ('Software Engineer'),
    ('Software Architect'),
    ('Blockchain Developer'),
    ('DApp Developer'),
    ('Blockchain Security'),
    ('Web 3.0 Developer'),
    ('Cybersecurity Software Developer'),
    ('Business Continuity Planner'),
    ('CSO (Chief Strategy Officer)'),
    ('CEO (Chief Executive Officer)');

		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		

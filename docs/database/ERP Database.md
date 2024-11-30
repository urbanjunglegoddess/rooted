Creating a comprehensive PostgreSQL database schema for an ERP (Enterprise Resource Planning) system involves meticulously designing various modules that cover all aspects of a business's operations. Below is an exhaustive and detailed list of database schemas, tables, and their respective fields tailored for an ERP system. This structure is optimized for integration with a React Native application, ensuring seamless data flow and user experience.

---

## 1. **Authentication and Authorization**

### **Schema: auth**

#### **Tables:**

- **users**
  - `user_id` (PK, UUID)
  - `username` (VARCHAR, unique, not null)
  - `password_hash` (VARCHAR, not null)
  - `email` (VARCHAR, unique, not null)
  - `first_name` (VARCHAR)
  - `last_name` (VARCHAR)
  - `phone_number` (VARCHAR)
  - `status` (ENUM: active, inactive, suspended)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **roles**
  - `role_id` (PK, UUID)
  - `role_name` (VARCHAR, unique, not null)
  - `description` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **permissions**
  - `permission_id` (PK, UUID)
  - `permission_name` (VARCHAR, unique, not null)
  - `description` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **user_roles**
  - `user_role_id` (PK, UUID)
  - `user_id` (FK to users.user_id, not null)
  - `role_id` (FK to roles.role_id, not null)
  - `assigned_at` (TIMESTAMP, default now())

- **role_permissions**
  - `role_permission_id` (PK, UUID)
  - `role_id` (FK to roles.role_id, not null)
  - `permission_id` (FK to permissions.permission_id, not null)
  - `assigned_at` (TIMESTAMP, default now())

- **password_resets**
  - `reset_id` (PK, UUID)
  - `user_id` (FK to users.user_id, not null)
  - `token` (VARCHAR, unique, not null)
  - `expires_at` (TIMESTAMP, not null)
  - `created_at` (TIMESTAMP, default now())

- **audit_logs**
  - `log_id` (PK, UUID)
  - `user_id` (FK to users.user_id)
  - `action` (VARCHAR, not null)
  - `description` (TEXT)
  - `ip_address` (INET)
  - `created_at` (TIMESTAMP, default now())

---

## 2. **Customer Relationship Management (CRM)**

### **Schema: crm**

#### **Tables:**

- **customers**
  - `customer_id` (PK, UUID)
  - `company_name` (VARCHAR, not null)
  - `contact_first_name` (VARCHAR)
  - `contact_last_name` (VARCHAR)
  - `email` (VARCHAR, unique)
  - `phone_number` (VARCHAR)
  - `address_line1` (VARCHAR)
  - `address_line2` (VARCHAR)
  - `city` (VARCHAR)
  - `state` (VARCHAR)
  - `postal_code` (VARCHAR)
  - `country` (VARCHAR)
  - `status` (ENUM: lead, prospect, customer, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **leads**
  - `lead_id` (PK, UUID)
  - `customer_id` (FK to customers.customer_id)
  - `source` (VARCHAR)
  - `status` (ENUM: new, contacted, qualified, disqualified)
  - `assigned_to` (FK to auth.users.user_id)
  - `notes` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **contacts**
  - `contact_id` (PK, UUID)
  - `customer_id` (FK to customers.customer_id, not null)
  - `first_name` (VARCHAR, not null)
  - `last_name` (VARCHAR, not null)
  - `email` (VARCHAR)
  - `phone_number` (VARCHAR)
  - `position` (VARCHAR)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **interactions**
  - `interaction_id` (PK, UUID)
  - `customer_id` (FK to customers.customer_id)
  - `user_id` (FK to auth.users.user_id)
  - `interaction_type` (ENUM: call, email, meeting, other)
  - `subject` (VARCHAR)
  - `description` (TEXT)
  - `interaction_date` (TIMESTAMP)
  - `created_at` (TIMESTAMP, default now())

- **opportunities**
  - `opportunity_id` (PK, UUID)
  - `customer_id` (FK to customers.customer_id)
  - `name` (VARCHAR, not null)
  - `description` (TEXT)
  - `value` (DECIMAL)
  - `stage` (ENUM: qualification, proposal, negotiation, closed_won, closed_lost)
  - `expected_close_date` (DATE)
  - `assigned_to` (FK to auth.users.user_id)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **customer_segments**
  - `segment_id` (PK, UUID)
  - `segment_name` (VARCHAR, unique, not null)
  - `description` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **customer_segment_assignments**
  - `assignment_id` (PK, UUID)
  - `customer_id` (FK to customers.customer_id, not null)
  - `segment_id` (FK to customer_segments.segment_id, not null)
  - `assigned_at` (TIMESTAMP, default now())

---

## 3. **Supplier and Procurement Management**

### **Schema: procurement**

#### **Tables:**

- **suppliers**
  - `supplier_id` (PK, UUID)
  - `company_name` (VARCHAR, not null)
  - `contact_first_name` (VARCHAR)
  - `contact_last_name` (VARCHAR)
  - `email` (VARCHAR, unique)
  - `phone_number` (VARCHAR)
  - `address_line1` (VARCHAR)
  - `address_line2` (VARCHAR)
  - `city` (VARCHAR)
  - `state` (VARCHAR)
  - `postal_code` (VARCHAR)
  - `country` (VARCHAR)
  - `status` (ENUM: active, inactive, pending)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **purchase_orders**
  - `purchase_order_id` (PK, UUID)
  - `supplier_id` (FK to suppliers.supplier_id, not null)
  - `order_number` (VARCHAR, unique, not null)
  - `order_date` (DATE, not null)
  - `expected_delivery_date` (DATE)
  - `status` (ENUM: draft, sent, received, canceled)
  - `total_amount` (DECIMAL)
  - `created_by` (FK to auth.users.user_id)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **purchase_order_items**
  - `purchase_order_item_id` (PK, UUID)
  - `purchase_order_id` (FK to purchase_orders.purchase_order_id, not null)
  - `product_id` (FK to inventory.products.product_id, not null)
  - `quantity` (INTEGER, not null)
  - `unit_price` (DECIMAL, not null)
  - `total_price` (DECIMAL, computed as quantity * unit_price)
  - `received_quantity` (INTEGER, default 0)
  - `status` (ENUM: ordered, partially_received, received, canceled)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **supplier_contacts**
  - `supplier_contact_id` (PK, UUID)
  - `supplier_id` (FK to suppliers.supplier_id, not null)
  - `first_name` (VARCHAR, not null)
  - `last_name` (VARCHAR, not null)
  - `email` (VARCHAR)
  - `phone_number` (VARCHAR)
  - `position` (VARCHAR)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **procurement_requests**
  - `request_id` (PK, UUID)
  - `requested_by` (FK to auth.users.user_id, not null)
  - `department` (VARCHAR)
  - `description` (TEXT)
  - `status` (ENUM: pending, approved, rejected)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **procurement_approvals**
  - `approval_id` (PK, UUID)
  - `request_id` (FK to procurement_requests.request_id, not null)
  - `approved_by` (FK to auth.users.user_id, not null)
  - `approval_date` (TIMESTAMP, default now())
  - `status` (ENUM: approved, rejected)
  - `comments` (TEXT)

---

## 4. **Inventory and Warehouse Management**

### **Schema: inventory**

#### **Tables:**

- **products**
  - `product_id` (PK, UUID)
  - `sku` (VARCHAR, unique, not null)
  - `name` (VARCHAR, not null)
  - `description` (TEXT)
  - `category_id` (FK to product_categories.category_id)
  - `unit_price` (DECIMAL, not null)
  - `cost_price` (DECIMAL)
  - `currency` (VARCHAR, default 'USD')
  - `barcode` (VARCHAR, unique)
  - `status` (ENUM: active, inactive, discontinued)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **product_categories**
  - `category_id` (PK, UUID)
  - `category_name` (VARCHAR, unique, not null)
  - `description` (TEXT)
  - `parent_category_id` (FK to product_categories.category_id)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **warehouses**
  - `warehouse_id` (PK, UUID)
  - `name` (VARCHAR, unique, not null)
  - `location` (VARCHAR)
  - `address_line1` (VARCHAR)
  - `address_line2` (VARCHAR)
  - `city` (VARCHAR)
  - `state` (VARCHAR)
  - `postal_code` (VARCHAR)
  - `country` (VARCHAR)
  - `capacity` (INTEGER)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **inventory_levels**
  - `inventory_level_id` (PK, UUID)
  - `product_id` (FK to products.product_id, not null)
  - `warehouse_id` (FK to warehouses.warehouse_id, not null)
  - `quantity_on_hand` (INTEGER, default 0)
  - `reorder_level` (INTEGER, default 0)
  - `reorder_quantity` (INTEGER, default 0)
  - `last_updated` (TIMESTAMP, default now())

- **stock_movements**
  - `stock_movement_id` (PK, UUID)
  - `product_id` (FK to products.product_id, not null)
  - `from_warehouse_id` (FK to warehouses.warehouse_id)
  - `to_warehouse_id` (FK to warehouses.warehouse_id)
  - `quantity` (INTEGER, not null)
  - `movement_type` (ENUM: inbound, outbound, transfer, adjustment)
  - `reference_id` (VARCHAR) -- e.g., related order or invoice
  - `movement_date` (TIMESTAMP, default now())
  - `created_at` (TIMESTAMP, default now())

- **inventory_audits**
  - `audit_id` (PK, UUID)
  - `product_id` (FK to products.product_id, not null)
  - `warehouse_id` (FK to warehouses.warehouse_id, not null)
  - `counted_quantity` (INTEGER, not null)
  - `audited_by` (FK to auth.users.user_id)
  - `audit_date` (TIMESTAMP, default now())
  - `notes` (TEXT)
  - `created_at` (TIMESTAMP, default now())

- **product_variants**
  - `variant_id` (PK, UUID)
  - `product_id` (FK to products.product_id, not null)
  - `variant_name` (VARCHAR, not null)
  - `variant_value` (VARCHAR, not null)
  - `additional_cost` (DECIMAL, default 0)
  - `sku` (VARCHAR, unique)
  - `barcode` (VARCHAR, unique)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

---

## 5. **Sales and Order Management**

### **Schema: sales**

#### **Tables:**

- **sales_orders**
  - `sales_order_id` (PK, UUID)
  - `order_number` (VARCHAR, unique, not null)
  - `customer_id` (FK to crm.customers.customer_id, not null)
  - `order_date` (DATE, not null)
  - `status` (ENUM: draft, confirmed, shipped, delivered, canceled)
  - `total_amount` (DECIMAL)
  - `currency` (VARCHAR, default 'USD')
  - `payment_terms` (VARCHAR)
  - `shipping_method` (VARCHAR)
  - `shipping_address_id` (FK to crm.customers.customer_id, if different)
  - `billing_address_id` (FK to crm.customers.customer_id, if different)
  - `created_by` (FK to auth.users.user_id)
  - `approved_by` (FK to auth.users.user_id)
  - `approved_at` (TIMESTAMP)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **sales_order_items**
  - `sales_order_item_id` (PK, UUID)
  - `sales_order_id` (FK to sales_orders.sales_order_id, not null)
  - `product_id` (FK to inventory.products.product_id, not null)
  - `variant_id` (FK to inventory.product_variants.variant_id)
  - `quantity` (INTEGER, not null)
  - `unit_price` (DECIMAL, not null)
  - `discount` (DECIMAL, default 0)
  - `tax` (DECIMAL, default 0)
  - `total_price` (DECIMAL, computed as (unit_price * quantity) - discount + tax)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **invoices**
  - `invoice_id` (PK, UUID)
  - `sales_order_id` (FK to sales_orders.sales_order_id, unique, not null)
  - `invoice_number` (VARCHAR, unique, not null)
  - `invoice_date` (DATE, not null)
  - `due_date` (DATE, not null)
  - `status` (ENUM: draft, sent, paid, overdue, canceled)
  - `total_amount` (DECIMAL)
  - `currency` (VARCHAR, default 'USD')
  - `payment_received` (DECIMAL, default 0)
  - `balance_due` (DECIMAL, computed as total_amount - payment_received)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **payments**
  - `payment_id` (PK, UUID)
  - `invoice_id` (FK to invoices.invoice_id, not null)
  - `payment_date` (TIMESTAMP, default now())
  - `amount` (DECIMAL, not null)
  - `payment_method` (ENUM: cash, credit_card, bank_transfer, other)
  - `reference_number` (VARCHAR)
  - `created_by` (FK to auth.users.user_id)
  - `created_at` (TIMESTAMP, default now())

- **quotes**
  - `quote_id` (PK, UUID)
  - `quote_number` (VARCHAR, unique, not null)
  - `customer_id` (FK to crm.customers.customer_id, not null)
  - `valid_until` (DATE, not null)
  - `status` (ENUM: draft, sent, accepted, declined)
  - `total_amount` (DECIMAL)
  - `currency` (VARCHAR, default 'USD')
  - `created_by` (FK to auth.users.user_id)
  - `approved_by` (FK to auth.users.user_id)
  - `approved_at` (TIMESTAMP)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **sales_order_shipments**
  - `shipment_id` (PK, UUID)
  - `sales_order_id` (FK to sales_orders.sales_order_id, not null)
  - `shipment_number` (VARCHAR, unique, not null)
  - `shipment_date` (TIMESTAMP, default now())
  - `carrier` (VARCHAR)
  - `tracking_number` (VARCHAR, unique)
  - `status` (ENUM: pending, shipped, in_transit, delivered, returned)
  - `estimated_arrival` (TIMESTAMP)
  - `actual_arrival` (TIMESTAMP)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **sales_discounts**
  - `discount_id` (PK, UUID)
  - `name` (VARCHAR, not null)
  - `description` (TEXT)
  - `discount_type` (ENUM: percentage, fixed_amount)
  - `value` (DECIMAL, not null)
  - `start_date` (DATE)
  - `end_date` (DATE)
  - `applicable_to` (ENUM: products, categories, orders)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **sales_tax_rates**
  - `tax_rate_id` (PK, UUID)
  - `tax_name` (VARCHAR, not null)
  - `tax_percentage` (DECIMAL, not null)
  - `applicable_region` (VARCHAR)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

---

## 6. **Purchasing Management**

### **Schema: purchasing**

#### **Tables:**

- **purchase_orders**
  - (Note: Similar to `procurement.purchase_orders` but can be included here if separate handling is needed)

- **purchase_order_items**
  - (Note: Similar to `procurement.purchase_order_items`)

- **vendors**
  - (Equivalent to `procurement.suppliers`)

- **purchase_requisitions**
  - `requisition_id` (PK, UUID)
  - `requisition_number` (VARCHAR, unique, not null)
  - `requested_by` (FK to auth.users.user_id, not null)
  - `department` (VARCHAR)
  - `description` (TEXT)
  - `status` (ENUM: pending, approved, rejected)
  - `total_amount` (DECIMAL)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **purchase_approvals**
  - (Equivalent to `procurement.procurement_approvals`)

- **contracts**
  - `contract_id` (PK, UUID)
  - `supplier_id` (FK to procurement.suppliers.supplier_id, not null)
  - `contract_number` (VARCHAR, unique, not null)
  - `start_date` (DATE, not null)
  - `end_date` (DATE, not null)
  - `terms` (TEXT)
  - `status` (ENUM: active, expired, terminated)
  - `created_by` (FK to auth.users.user_id)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **purchase_returns**
  - `purchase_return_id` (PK, UUID)
  - `purchase_order_id` (FK to purchase_orders.purchase_order_id)
  - `return_number` (VARCHAR, unique, not null)
  - `return_date` (DATE, not null)
  - `status` (ENUM: pending, approved, rejected, completed)
  - `reason` (TEXT)
  - `total_amount` (DECIMAL)
  - `created_by` (FK to auth.users.user_id)
  - `approved_by` (FK to auth.users.user_id)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

---

## 7. **Finance and Accounting**

### **Schema: finance**

#### **Tables:**

- **accounts**
  - `account_id` (PK, UUID)
  - `account_number` (VARCHAR, unique, not null)
  - `account_name` (VARCHAR, not null)
  - `account_type` (ENUM: asset, liability, equity, revenue, expense)
  - `parent_account_id` (FK to accounts.account_id)
  - `description` (TEXT)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **journal_entries**
  - `journal_entry_id` (PK, UUID)
  - `entry_number` (VARCHAR, unique, not null)
  - `entry_date` (DATE, not null)
  - `description` (TEXT)
  - `status` (ENUM: draft, posted, voided)
  - `created_by` (FK to auth.users.user_id)
  - `approved_by` (FK to auth.users.user_id)
  - `approved_at` (TIMESTAMP)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **journal_entry_lines**
  - `journal_entry_line_id` (PK, UUID)
  - `journal_entry_id` (FK to journal_entries.journal_entry_id, not null)
  - `account_id` (FK to accounts.account_id, not null)
  - `debit` (DECIMAL, default 0)
  - `credit` (DECIMAL, default 0)
  - `description` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **general_ledger**
  - `ledger_id` (PK, UUID)
  - `account_id` (FK to accounts.account_id, not null)
  - `date` (DATE, not null)
  - `description` (TEXT)
  - `debit` (DECIMAL, default 0)
  - `credit` (DECIMAL, default 0)
  - `balance` (DECIMAL)
  - `journal_entry_id` (FK to journal_entries.journal_entry_id)
  - `created_at` (TIMESTAMP, default now())

- **accounts_payable**
  - `payable_id` (PK, UUID)
  - `supplier_id` (FK to procurement.suppliers.supplier_id, not null)
  - `invoice_number` (VARCHAR, unique, not null)
  - `invoice_date` (DATE, not null)
  - `due_date` (DATE, not null)
  - `total_amount` (DECIMAL, not null)
  - `currency` (VARCHAR, default 'USD')
  - `status` (ENUM: pending, paid, overdue, canceled)
  - `payment_received` (DECIMAL, default 0)
  - `balance_due` (DECIMAL, computed as total_amount - payment_received)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **accounts_receivable**
  - `receivable_id` (PK, UUID)
  - `customer_id` (FK to crm.customers.customer_id, not null)
  - `invoice_id` (FK to sales.invoices.invoice_id, not null)
  - `amount` (DECIMAL, not null)
  - `due_date` (DATE, not null)
  - `status` (ENUM: pending, received, overdue, canceled)
  - `payment_received` (DECIMAL, default 0)
  - `balance_due` (DECIMAL, computed as amount - payment_received)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **budgets**
  - `budget_id` (PK, UUID)
  - `account_id` (FK to accounts.account_id, not null)
  - `fiscal_year` (INTEGER, not null)
  - `amount` (DECIMAL, not null)
  - `description` (TEXT)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **financial_statements**
  - `statement_id` (PK, UUID)
  - `fiscal_year` (INTEGER, not null)
  - `period` (VARCHAR, e.g., Q1, Q2, etc.)
  - `statement_type` (ENUM: balance_sheet, income_statement, cash_flow)
  - `generated_at` (TIMESTAMP, default now())
  - `file_path` (VARCHAR)
  - `created_at` (TIMESTAMP, default now())

- **taxes**
  - `tax_id` (PK, UUID)
  - `tax_name` (VARCHAR, not null)
  - `tax_percentage` (DECIMAL, not null)
  - `applicable_to` (ENUM: sales, purchases, both)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

---

## 8. **Human Resources (HR)**

### **Schema: hr**

#### **Tables:**

- **employees**
  - `employee_id` (PK, UUID)
  - `first_name` (VARCHAR, not null)
  - `last_name` (VARCHAR, not null)
  - `email` (VARCHAR, unique, not null)
  - `phone_number` (VARCHAR)
  - `hire_date` (DATE, not null)
  - `job_title` (VARCHAR)
  - `department_id` (FK to departments.department_id)
  - `manager_id` (FK to employees.employee_id)
  - `status` (ENUM: active, terminated, on_leave)
  - `address_line1` (VARCHAR)
  - `address_line2` (VARCHAR)
  - `city` (VARCHAR)
  - `state` (VARCHAR)
  - `postal_code` (VARCHAR)
  - `country` (VARCHAR)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **departments**
  - `department_id` (PK, UUID)
  - `department_name` (VARCHAR, unique, not null)
  - `description` (TEXT)
  - `parent_department_id` (FK to departments.department_id)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **positions**
  - `position_id` (PK, UUID)
  - `position_title` (VARCHAR, not null)
  - `description` (TEXT)
  - `department_id` (FK to departments.department_id)
  - `min_salary` (DECIMAL)
  - `max_salary` (DECIMAL)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **salaries**
  - `salary_id` (PK, UUID)
  - `employee_id` (FK to employees.employee_id, not null)
  - `position_id` (FK to positions.position_id)
  - `base_salary` (DECIMAL, not null)
  - `bonus` (DECIMAL, default 0)
  - `currency` (VARCHAR, default 'USD')
  - `effective_date` (DATE, not null)
  - `end_date` (DATE)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **time_off_requests**
  - `request_id` (PK, UUID)
  - `employee_id` (FK to employees.employee_id, not null)
  - `leave_type` (ENUM: vacation, sick, personal, other)
  - `start_date` (DATE, not null)
  - `end_date` (DATE, not null)
  - `status` (ENUM: pending, approved, rejected)
  - `requested_at` (TIMESTAMP, default now())
  - `approved_by` (FK to employees.employee_id)
  - `approved_at` (TIMESTAMP)
  - `comments` (TEXT)

- **payroll**
  - `payroll_id` (PK, UUID)
  - `employee_id` (FK to employees.employee_id, not null)
  - `pay_period_start` (DATE, not null)
  - `pay_period_end` (DATE, not null)
  - `gross_pay` (DECIMAL, not null)
  - `tax_deductions` (DECIMAL, default 0)
  - `other_deductions` (DECIMAL, default 0)
  - `net_pay` (DECIMAL, computed as gross_pay - tax_deductions - other_deductions)
  - `payment_date` (DATE, not null)
  - `status` (ENUM: processed, pending, failed)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **benefits**
  - `benefit_id` (PK, UUID)
  - `employee_id` (FK to employees.employee_id, not null)
  - `benefit_type` (ENUM: health_insurance, retirement, stock_options, other)
  - `provider` (VARCHAR)
  - `coverage_details` (TEXT)
  - `start_date` (DATE)
  - `end_date` (DATE)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **employee_documents**
  - `document_id` (PK, UUID)
  - `employee_id` (FK to employees.employee_id, not null)
  - `document_type` (ENUM: resume, contract, ID_proof, other)
  - `file_path` (VARCHAR, not null)
  - `uploaded_at` (TIMESTAMP, default now())
  - `uploaded_by` (FK to auth.users.user_id)
  - `comments` (TEXT)

- **training_records**
  - `training_id` (PK, UUID)
  - `employee_id` (FK to employees.employee_id, not null)
  - `training_name` (VARCHAR, not null)
  - `description` (TEXT)
  - `completion_date` (DATE)
  - `status` (ENUM: completed, in_progress, not_started)
  - `certification` (BOOLEAN, default false)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **performance_reviews**
  - `review_id` (PK, UUID)
  - `employee_id` (FK to employees.employee_id, not null)
  - `review_period_start` (DATE, not null)
  - `review_period_end` (DATE, not null)
  - `reviewer_id` (FK to employees.employee_id)
  - `rating` (INTEGER, check between 1 and 5)
  - `comments` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

---

## 9. **Manufacturing and Production**

### **Schema: manufacturing**

#### **Tables:**

- **bills_of_material**
  - `bom_id` (PK, UUID)
  - `product_id` (FK to inventory.products.product_id, not null)
  - `component_id` (FK to inventory.products.product_id, not null)
  - `quantity_required` (DECIMAL, not null)
  - `unit` (VARCHAR, default 'pcs')
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **production_orders**
  - `production_order_id` (PK, UUID)
  - `order_number` (VARCHAR, unique, not null)
  - `product_id` (FK to inventory.products.product_id, not null)
  - `quantity` (INTEGER, not null)
  - `status` (ENUM: planned, in_progress, completed, halted, canceled)
  - `start_date` (DATE)
  - `end_date` (DATE)
  - `created_by` (FK to auth.users.user_id)
  - `assigned_to` (FK to employees.employee_id)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **work_centers**
  - `work_center_id` (PK, UUID)
  - `name` (VARCHAR, unique, not null)
  - `location` (VARCHAR)
  - `capacity` (INTEGER)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **production_tasks**
  - `task_id` (PK, UUID)
  - `production_order_id` (FK to production_orders.production_order_id, not null)
  - `work_center_id` (FK to work_centers.work_center_id, not null)
  - `task_name` (VARCHAR, not null)
  - `description` (TEXT)
  - `assigned_to` (FK to employees.employee_id)
  - `status` (ENUM: pending, in_progress, completed, halted, canceled)
  - `start_time` (TIMESTAMP)
  - `end_time` (TIMESTAMP)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **machine_equipment**
  - `machine_id` (PK, UUID)
  - `work_center_id` (FK to work_centers.work_center_id, not null)
  - `name` (VARCHAR, not null)
  - `serial_number` (VARCHAR, unique)
  - `purchase_date` (DATE)
  - `status` (ENUM: operational, maintenance, decommissioned)
  - `last_maintenance_date` (DATE)
  - `next_maintenance_due` (DATE)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **quality_checks**
  - `quality_check_id` (PK, UUID)
  - `production_order_id` (FK to production_orders.production_order_id, not null)
  - `task_id` (FK to production_tasks.task_id)
  - `inspector_id` (FK to employees.employee_id)
  - `check_date` (TIMESTAMP, default now())
  - `result` (ENUM: pass, fail)
  - `comments` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **production_materials**
  - `production_material_id` (PK, UUID)
  - `production_order_id` (FK to production_orders.production_order_id, not null)
  - `product_id` (FK to inventory.products.product_id, not null)
  - `quantity` (DECIMAL, not null)
  - `unit` (VARCHAR, default 'pcs')
  - `status` (ENUM: allocated, used, returned)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **production_costs**
  - `production_cost_id` (PK, UUID)
  - `production_order_id` (FK to production_orders.production_order_id, not null)
  - `cost_type` (ENUM: labor, materials, overhead, other)
  - `amount` (DECIMAL, not null)
  - `currency` (VARCHAR, default 'USD')
  - `description` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **production_issues**
  - `issue_id` (PK, UUID)
  - `production_order_id` (FK to production_orders.production_order_id)
  - `task_id` (FK to production_tasks.task_id)
  - `reported_by` (FK to employees.employee_id)
  - `issue_type` (VARCHAR)
  - `description` (TEXT)
  - `status` (ENUM: open, in_progress, resolved, closed)
  - `reported_at` (TIMESTAMP, default now())
  - `resolved_at` (TIMESTAMP)
  - `comments` (TEXT)

---

## 10. **Project and Task Management**

### **Schema: projects**

#### **Tables:**

- **projects**
  - `project_id` (PK, UUID)
  - `project_name` (VARCHAR, not null)
  - `description` (TEXT)
  - `start_date` (DATE)
  - `end_date` (DATE)
  - `status` (ENUM: planned, active, completed, on_hold, canceled)
  - `manager_id` (FK to hr.employees.employee_id)
  - `budget` (DECIMAL)
  - `currency` (VARCHAR, default 'USD')
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **tasks**
  - `task_id` (PK, UUID)
  - `project_id` (FK to projects.project_id, not null)
  - `task_name` (VARCHAR, not null)
  - `description` (TEXT)
  - `assigned_to` (FK to hr.employees.employee_id)
  - `priority` (ENUM: low, medium, high, critical)
  - `status` (ENUM: not_started, in_progress, completed, blocked)
  - `start_date` (DATE)
  - `due_date` (DATE)
  - `completion_date` (DATE)
  - `parent_task_id` (FK to tasks.task_id)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **milestones**
  - `milestone_id` (PK, UUID)
  - `project_id` (FK to projects.project_id, not null)
  - `milestone_name` (VARCHAR, not null)
  - `description` (TEXT)
  - `due_date` (DATE)
  - `status` (ENUM: planned, achieved, missed)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **project_resources**
  - `resource_id` (PK, UUID)
  - `project_id` (FK to projects.project_id, not null)
  - `employee_id` (FK to hr.employees.employee_id)
  - `resource_type` (ENUM: human, equipment, material, other)
  - `allocation_percentage` (INTEGER, check between 0 and 100)
  - `start_date` (DATE)
  - `end_date` (DATE)
  - `status` (ENUM: allocated, released)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **project_tasks_dependencies**
  - `dependency_id` (PK, UUID)
  - `task_id` (FK to tasks.task_id, not null)
  - `depends_on_task_id` (FK to tasks.task_id, not null)
  - `created_at` (TIMESTAMP, default now())

- **project_budgets**
  - `budget_id` (PK, UUID)
  - `project_id` (FK to projects.project_id, not null)
  - `budget_category` (VARCHAR, not null)
  - `allocated_amount` (DECIMAL, not null)
  - `spent_amount` (DECIMAL, default 0)
  - `currency` (VARCHAR, default 'USD')
  - `status` (ENUM: active, exhausted, replenished)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **project_timesheets**
  - `timesheet_id` (PK, UUID)
  - `project_id` (FK to projects.project_id, not null)
  - `employee_id` (FK to hr.employees.employee_id, not null)
  - `date` (DATE, not null)
  - `hours_worked` (DECIMAL, not null)
  - `task_id` (FK to tasks.task_id)
  - `comments` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **project_documents**
  - `document_id` (PK, UUID)
  - `project_id` (FK to projects.project_id, not null)
  - `document_type` (ENUM: proposal, design, contract, other)
  - `file_path` (VARCHAR, not null)
  - `uploaded_at` (TIMESTAMP, default now())
  - `uploaded_by` (FK to auth.users.user_id)
  - `comments` (TEXT)

- **project_issues**
  - `issue_id` (PK, UUID)
  - `project_id` (FK to projects.project_id, not null)
  - `reported_by` (FK to hr.employees.employee_id)
  - `issue_type` (VARCHAR)
  - `description` (TEXT)
  - `status` (ENUM: open, in_progress, resolved, closed)
  - `priority` (ENUM: low, medium, high, critical)
  - `reported_at` (TIMESTAMP, default now())
  - `resolved_at` (TIMESTAMP)
  - `comments` (TEXT)

- **project_risks**
  - `risk_id` (PK, UUID)
  - `project_id` (FK to projects.project_id, not null)
  - `risk_description` (TEXT, not null)
  - `impact` (ENUM: low, medium, high, critical)
  - `likelihood` (ENUM: low, medium, high, critical)
  - `status` (ENUM: identified, mitigated, realized, closed)
  - `mitigation_plan` (TEXT)
  - `owner_id` (FK to hr.employees.employee_id)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

---

## 11. **Reporting and Analytics**

### **Schema: reporting**

#### **Tables:**

- **reports**
  - `report_id` (PK, UUID)
  - `report_name` (VARCHAR, not null)
  - `description` (TEXT)
  - `report_type` (ENUM: sales, finance, inventory, hr, custom)
  - `created_by` (FK to auth.users.user_id)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **report_filters**
  - `filter_id` (PK, UUID)
  - `report_id` (FK to reports.report_id, not null)
  - `filter_field` (VARCHAR, not null)
  - `filter_type` (ENUM: date_range, dropdown, text, numeric)
  - `default_value` (VARCHAR)
  - `created_at` (TIMESTAMP, default now())

- **report_parameters**
  - `parameter_id` (PK, UUID)
  - `report_id` (FK to reports.report_id, not null)
  - `parameter_name` (VARCHAR, not null)
  - `parameter_type` (ENUM: string, integer, date, boolean)
  - `default_value` (VARCHAR)
  - `required` (BOOLEAN, default false)
  - `created_at` (TIMESTAMP, default now())

- **report_results**
  - `result_id` (PK, UUID)
  - `report_id` (FK to reports.report_id, not null)
  - `generated_by` (FK to auth.users.user_id)
  - `generated_at` (TIMESTAMP, default now())
  - `file_path` (VARCHAR)
  - `status` (ENUM: completed, failed, pending)
  - `error_message` (TEXT)

- **dashboard_widgets**
  - `widget_id` (PK, UUID)
  - `dashboard_id` (FK to dashboards.dashboard_id, not null)
  - `widget_type` (ENUM: chart, table, KPI, text)
  - `data_source` (VARCHAR)
  - `settings` (JSONB)
  - `position` (INTEGER)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **dashboards**
  - `dashboard_id` (PK, UUID)
  - `dashboard_name` (VARCHAR, not null)
  - `description` (TEXT)
  - `owner_id` (FK to auth.users.user_id)
  - `visibility` (ENUM: private, public, shared)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **analytics_events**
  - `event_id` (PK, UUID)
  - `event_name` (VARCHAR, not null)
  - `description` (TEXT)
  - `created_at` (TIMESTAMP, default now())

- **analytics_event_logs**
  - `event_log_id` (PK, UUID)
  - `event_id` (FK to analytics_events.event_id, not null)
  - `occurred_at` (TIMESTAMP, default now())
  - `user_id` (FK to auth.users.user_id)
  - `metadata` (JSONB)
  - `created_at` (TIMESTAMP, default now())

- **data_sources**
  - `data_source_id` (PK, UUID)
  - `source_name` (VARCHAR, not null)
  - `source_type` (ENUM: database, API, file, other)
  - `connection_details` (JSONB)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **scheduled_reports**
  - `scheduled_report_id` (PK, UUID)
  - `report_id` (FK to reports.report_id, not null)
  - `schedule_type` (ENUM: daily, weekly, monthly, quarterly, yearly)
  - `next_run` (TIMESTAMP)
  - `status` (ENUM: active, paused, canceled)
  - `recipients` (ARRAY of VARCHAR)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

---

## 12. **Asset Management**

### **Schema: assets**

#### **Tables:**

- **assets**
  - `asset_id` (PK, UUID)
  - `asset_tag` (VARCHAR, unique, not null)
  - `asset_name` (VARCHAR, not null)
  - `description` (TEXT)
  - `category_id` (FK to asset_categories.category_id)
  - `purchase_date` (DATE)
  - `purchase_cost` (DECIMAL)
  - `current_value` (DECIMAL)
  - `depreciation_method` (ENUM: straight_line, declining_balance, units_of_activity)
  - `useful_life_years` (INTEGER)
  - `status` (ENUM: active, disposed, under_maintenance)
  - `location` (VARCHAR)
  - `assigned_to` (FK to hr.employees.employee_id)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **asset_categories**
  - `category_id` (PK, UUID)
  - `category_name` (VARCHAR, unique, not null)
  - `description` (TEXT)
  - `parent_category_id` (FK to asset_categories.category_id)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **asset_locations**
  - `location_id` (PK, UUID)
  - `asset_id` (FK to assets.asset_id, not null)
  - `location_name` (VARCHAR, not null)
  - `address_line1` (VARCHAR)
  - `address_line2` (VARCHAR)
  - `city` (VARCHAR)
  - `state` (VARCHAR)
  - `postal_code` (VARCHAR)
  - `country` (VARCHAR)
  - `moved_at` (TIMESTAMP, default now())

- **asset_maintenance**
  - `maintenance_id` (PK, UUID)
  - `asset_id` (FK to assets.asset_id, not null)
  - `maintenance_type` (ENUM: preventive, corrective, inspection, other)
  - `scheduled_date` (DATE)
  - `completed_date` (DATE)
  - `status` (ENUM: scheduled, in_progress, completed, canceled)
  - `performed_by` (FK to hr.employees.employee_id)
  - `cost` (DECIMAL)
  - `notes` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **asset_depreciation**
  - `depreciation_id` (PK, UUID)
  - `asset_id` (FK to assets.asset_id, not null)
  - `depreciation_date` (DATE, not null)
  - `depreciation_amount` (DECIMAL, not null)
  - `accumulated_depreciation` (DECIMAL, not null)
  - `book_value` (DECIMAL, not null)
  - `created_at` (TIMESTAMP, default now())

- **asset_inspections**
  - `inspection_id` (PK, UUID)
  - `asset_id` (FK to assets.asset_id, not null)
  - `inspector_id` (FK to hr.employees.employee_id)
  - `inspection_date` (DATE, not null)
  - `result` (ENUM: pass, fail)
  - `comments` (TEXT)
  - `created_at` (TIMESTAMP, default now())

- **asset_disposals**
  - `disposal_id` (PK, UUID)
  - `asset_id` (FK to assets.asset_id, not null)
  - `disposal_date` (DATE, not null)
  - `disposal_method` (ENUM: sale, donation, recycling, other)
  - `sale_price` (DECIMAL)
  - `buyer_details` (TEXT)
  - `status` (ENUM: pending, completed, canceled)
  - `comments` (TEXT)
  - `created_at` (TIMESTAMP, default now())

- **asset_assignments**
  - `assignment_id` (PK, UUID)
  - `asset_id` (FK to assets.asset_id, not null)
  - `employee_id` (FK to hr.employees.employee_id)
  - `assigned_at` (TIMESTAMP, default now())
  - `returned_at` (TIMESTAMP)
  - `status` (ENUM: assigned, returned)
  - `comments` (TEXT)

---

## 13. **Maintenance Management**

### **Schema: maintenance**

#### **Tables:**

- **maintenance_requests**
  - `request_id` (PK, UUID)
  - `asset_id` (FK to assets.assets.asset_id)
  - `reported_by` (FK to hr.employees.employee_id)
  - `request_type` (ENUM: repair, preventive, inspection, other)
  - `priority` (ENUM: low, medium, high, urgent)
  - `description` (TEXT, not null)
  - `status` (ENUM: open, in_progress, completed, canceled)
  - `requested_at` (TIMESTAMP, default now())
  - `assigned_to` (FK to hr.employees.employee_id)
  - `completed_at` (TIMESTAMP)
  - `cost` (DECIMAL)
  - `comments` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **maintenance_schedules**
  - `schedule_id` (PK, UUID)
  - `asset_id` (FK to assets.assets.asset_id, not null)
  - `maintenance_type` (ENUM: preventive, corrective, inspection, other)
  - `frequency` (VARCHAR, e.g., monthly, quarterly, annually)
  - `next_maintenance_date` (DATE)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **maintenance_procedures**
  - `procedure_id` (PK, UUID)
  - `maintenance_type` (ENUM: preventive, corrective, inspection, other)
  - `description` (TEXT, not null)
  - `steps` (TEXT)
  - `required_tools` (TEXT)
  - `estimated_time` (INTEGER, in minutes)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **maintenance_logs**
  - `log_id` (PK, UUID)
  - `maintenance_request_id` (FK to maintenance_requests.request_id)
  - `action` (ENUM: created, assigned, started, completed, canceled)
  - `performed_by` (FK to hr.employees.employee_id)
  - `timestamp` (TIMESTAMP, default now())
  - `comments` (TEXT)

- **maintenance_inventory**
  - `inventory_id` (PK, UUID)
  - `maintenance_request_id` (FK to maintenance_requests.request_id)
  - `product_id` (FK to inventory.products.product_id)
  - `quantity_used` (INTEGER)
  - `status` (ENUM: used, returned, damaged)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **maintenance_vendors**
  - `vendor_id` (PK, UUID)
  - `vendor_name` (VARCHAR, not null)
  - `contact_person` (VARCHAR)
  - `email` (VARCHAR)
  - `phone_number` (VARCHAR)
  - `service_type` (VARCHAR)
  - `rating` (INTEGER, check between 1 and 5)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **maintenance_costs**
  - `cost_id` (PK, UUID)
  - `maintenance_request_id` (FK to maintenance_requests.request_id, not null)
  - `cost_type` (ENUM: labor, materials, services, other)
  - `amount` (DECIMAL, not null)
  - `currency` (VARCHAR, default 'USD')
  - `description` (TEXT)
  - `created_at` (TIMESTAMP, default now())

- **maintenance_inspections**
  - `inspection_id` (PK, UUID)
  - `maintenance_request_id` (FK to maintenance_requests.request_id)
  - `inspector_id` (FK to hr.employees.employee_id)
  - `inspection_date` (TIMESTAMP, default now())
  - `result` (ENUM: pass, fail)
  - `comments` (TEXT)
  - `created_at` (TIMESTAMP, default now())

---

## 14. **E-commerce Integration**

### **Schema: ecommerce**

#### **Tables:**

- **stores**
  - `store_id` (PK, UUID)
  - `store_name` (VARCHAR, not null)
  - `platform` (ENUM: Shopify, WooCommerce, Magento, custom)
  - `api_key` (VARCHAR, unique)
  - `api_secret` (VARCHAR)
  - `webhook_url` (VARCHAR)
  - `status` (ENUM: active, inactive, disconnected)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **products**
  - `ecom_product_id` (PK, UUID)
  - `store_id` (FK to stores.store_id, not null)
  - `product_id` (FK to inventory.products.product_id, not null)
  - `external_product_id` (VARCHAR, unique)
  - `name` (VARCHAR, not null)
  - `description` (TEXT)
  - `price` (DECIMAL, not null)
  - `currency` (VARCHAR, default 'USD')
  - `stock_quantity` (INTEGER)
  - `status` (ENUM: active, inactive, discontinued)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **orders**
  - `ecom_order_id` (PK, UUID)
  - `store_id` (FK to stores.store_id, not null)
  - `sales_order_id` (FK to sales.sales_orders.sales_order_id, unique)
  - `external_order_id` (VARCHAR, unique)
  - `customer_id` (FK to crm.customers.customer_id)
  - `order_status` (ENUM: pending, confirmed, shipped, delivered, canceled, refunded)
  - `payment_status` (ENUM: pending, paid, failed, refunded)
  - `order_total` (DECIMAL, not null)
  - `currency` (VARCHAR, default 'USD')
  - `order_date` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **order_items**
  - `ecom_order_item_id` (PK, UUID)
  - `ecom_order_id` (FK to orders.ecom_order_id, not null)
  - `sales_order_item_id` (FK to sales.sales_order_items.sales_order_item_id)
  - `external_product_id` (VARCHAR)
  - `quantity` (INTEGER, not null)
  - `unit_price` (DECIMAL, not null)
  - `total_price` (DECIMAL, computed as quantity * unit_price)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **payments**
  - `ecom_payment_id` (PK, UUID)
  - `ecom_order_id` (FK to orders.ecom_order_id, not null)
  - `payment_method` (ENUM: credit_card, paypal, bank_transfer, other)
  - `payment_status` (ENUM: pending, completed, failed, refunded)
  - `payment_date` (TIMESTAMP, default now())
  - `amount` (DECIMAL, not null)
  - `currency` (VARCHAR, default 'USD')
  - `transaction_id` (VARCHAR, unique)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **shipping**
  - `shipping_id` (PK, UUID)
  - `ecom_order_id` (FK to orders.ecom_order_id, not null)
  - `carrier` (VARCHAR)
  - `tracking_number` (VARCHAR, unique)
  - `shipping_method` (VARCHAR)
  - `shipping_status` (ENUM: pending, shipped, in_transit, delivered, returned)
  - `shipped_at` (TIMESTAMP)
  - `delivered_at` (TIMESTAMP)
  - `estimated_delivery` (TIMESTAMP)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **coupons**
  - `coupon_id` (PK, UUID)
  - `store_id` (FK to stores.store_id, not null)
  - `code` (VARCHAR, unique, not null)
  - `description` (TEXT)
  - `discount_type` (ENUM: percentage, fixed_amount)
  - `discount_value` (DECIMAL, not null)
  - `min_order_value` (DECIMAL, default 0)
  - `start_date` (DATE)
  - `end_date` (DATE)
  - `usage_limit` (INTEGER)
  - `status` (ENUM: active, inactive, expired)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **webhooks**
  - `webhook_id` (PK, UUID)
  - `store_id` (FK to stores.store_id, not null)
  - `event_type` (VARCHAR, not null)
  - `callback_url` (VARCHAR, not null)
  - `status` (ENUM: active, inactive)
  - `last_triggered` (TIMESTAMP)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **ecom_audit_logs**
  - `audit_log_id` (PK, UUID)
  - `store_id` (FK to stores.store_id)
  - `action` (VARCHAR, not null)
  - `description` (TEXT)
  - `performed_by` (FK to auth.users.user_id)
  - `performed_at` (TIMESTAMP, default now())
  - `ip_address` (INET)
  - `created_at` (TIMESTAMP, default now())

- **product_sync**
  - `sync_id` (PK, UUID)
  - `store_id` (FK to stores.store_id, not null)
  - `product_id` (FK to inventory.products.product_id, not null)
  - `external_product_id` (VARCHAR)
  - `sync_status` (ENUM: pending, synced, failed)
  - `last_synced_at` (TIMESTAMP)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **order_sync**
  - `sync_id` (PK, UUID)
  - `store_id` (FK to stores.store_id, not null)
  - `ecom_order_id` (FK to orders.ecom_order_id, not null)
  - `sync_status` (ENUM: pending, synced, failed)
  - `last_synced_at` (TIMESTAMP)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

---

## 15. **Logistics and Shipping**

### **Schema: logistics**

#### **Tables:**

- **shipping_methods**
  - `shipping_method_id` (PK, UUID)
  - `name` (VARCHAR, not null)
  - `carrier` (VARCHAR)
  - `delivery_time` (VARCHAR, e.g., "3-5 days")
  - `cost` (DECIMAL)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **shipping_rates**
  - `rate_id` (PK, UUID)
  - `shipping_method_id` (FK to shipping_methods.shipping_method_id, not null)
  - `region` (VARCHAR, not null)
  - `weight_min` (DECIMAL, not null)
  - `weight_max` (DECIMAL, not null)
  - `rate` (DECIMAL, not null)
  - `currency` (VARCHAR, default 'USD')
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **shipment_orders**
  - `shipment_order_id` (PK, UUID)
  - `sales_order_id` (FK to sales.sales_orders.sales_order_id, unique)
  - `shipping_method_id` (FK to shipping_methods.shipping_method_id, not null)
  - `carrier` (VARCHAR)
  - `tracking_number` (VARCHAR, unique)
  - `shipping_status` (ENUM: pending, shipped, in_transit, delivered, returned)
  - `shipment_date` (TIMESTAMP)
  - `estimated_delivery_date` (TIMESTAMP)
  - `actual_delivery_date` (TIMESTAMP)
  - `cost` (DECIMAL, default 0)
  - `currency` (VARCHAR, default 'USD')
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **shipment_items**
  - `shipment_item_id` (PK, UUID)
  - `shipment_order_id` (FK to shipment_orders.shipment_order_id, not null)
  - `sales_order_item_id` (FK to sales.sales_order_items.sales_order_item_id, not null)
  - `quantity` (INTEGER, not null)
  - `status` (ENUM: pending, shipped, returned)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **logistics_partners**
  - `partner_id` (PK, UUID)
  - `partner_name` (VARCHAR, not null)
  - `contact_person` (VARCHAR)
  - `email` (VARCHAR)
  - `phone_number` (VARCHAR)
  - `service_type` (VARCHAR)
  - `rating` (INTEGER, check between 1 and 5)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **shipment_documents**
  - `document_id` (PK, UUID)
  - `shipment_order_id` (FK to shipment_orders.shipment_order_id, not null)
  - `document_type` (ENUM: invoice, packing_list, bill_of_lading, other)
  - `file_path` (VARCHAR, not null)
  - `uploaded_at` (TIMESTAMP, default now())
  - `uploaded_by` (FK to auth.users.user_id)
  - `comments` (TEXT)

- **shipment_audits**
  - `audit_id` (PK, UUID)
  - `shipment_order_id` (FK to shipment_orders.shipment_order_id, not null)
  - `action` (VARCHAR, not null)
  - `performed_by` (FK to auth.users.user_id)
  - `performed_at` (TIMESTAMP, default now())
  - `comments` (TEXT)

- **shipment_tracking**
  - `tracking_id` (PK, UUID)
  - `shipment_order_id` (FK to shipment_orders.shipment_order_id, not null)
  - `status` (VARCHAR, not null)
  - `location` (VARCHAR)
  - `timestamp` (TIMESTAMP, default now())
  - `comments` (TEXT)
  - `created_at` (TIMESTAMP, default now())

- **delivery_confirmations**
  - `confirmation_id` (PK, UUID)
  - `shipment_order_id` (FK to shipment_orders.shipment_order_id, not null)
  - `delivered_by` (FK to hr.employees.employee_id)
  - `delivery_date` (TIMESTAMP, not null)
  - `signature` (VARCHAR)
  - `comments` (TEXT)
  - `created_at` (TIMESTAMP, default now())

- **returns_management**
  - `return_id` (PK, UUID)
  - `shipment_order_id` (FK to shipment_orders.shipment_order_id)
  - `sales_order_id` (FK to sales.sales_orders.sales_order_id)
  - `return_reason` (TEXT)
  - `status` (ENUM: requested, approved, rejected, completed)
  - `requested_at` (TIMESTAMP, default now())
  - `processed_at` (TIMESTAMP)
  - `comments` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **shipping_labels**
  - `label_id` (PK, UUID)
  - `shipment_order_id` (FK to shipment_orders.shipment_order_id, not null)
  - `label_type` (ENUM: PDF, PNG, other)
  - `file_path` (VARCHAR, not null)
  - `generated_at` (TIMESTAMP, default now())
  - `created_at` (TIMESTAMP, default now())

- **shipment_insurance**
  - `insurance_id` (PK, UUID)
  - `shipment_order_id` (FK to shipment_orders.shipment_order_id, not null)
  - `provider` (VARCHAR)
  - `policy_number` (VARCHAR, unique)
  - `coverage_amount` (DECIMAL)
  - `premium` (DECIMAL)
  - `start_date` (DATE)
  - `end_date` (DATE)
  - `status` (ENUM: active, expired, canceled)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **shipping_notifications**
  - `notification_id` (PK, UUID)
  - `shipment_order_id` (FK to shipment_orders.shipment_order_id, not null)
  - `notification_type` (ENUM: email, SMS, push)
  - `recipient` (VARCHAR, not null)
  - `message` (TEXT, not null)
  - `sent_at` (TIMESTAMP)
  - `status` (ENUM: pending, sent, failed)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

---

## 16. **Quality Control**

### **Schema: quality**

#### **Tables:**

- **quality_standards**
  - `standard_id` (PK, UUID)
  - `standard_name` (VARCHAR, not null)
  - `description` (TEXT)
  - `criteria` (TEXT, not null)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **quality_inspections**
  - `inspection_id` (PK, UUID)
  - `product_id` (FK to inventory.products.product_id)
  - `inspection_date` (TIMESTAMP, default now())
  - `inspector_id` (FK to hr.employees.employee_id)
  - `standard_id` (FK to quality_standards.standard_id)
  - `result` (ENUM: pass, fail)
  - `comments` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **quality_defects**
  - `defect_id` (PK, UUID)
  - `inspection_id` (FK to quality_inspections.inspection_id, not null)
  - `defect_type` (VARCHAR, not null)
  - `description` (TEXT)
  - `severity` (ENUM: minor, major, critical)
  - `status` (ENUM: identified, in_progress, resolved)
  - `assigned_to` (FK to hr.employees.employee_id)
  - `reported_at` (TIMESTAMP, default now())
  - `resolved_at` (TIMESTAMP)
  - `comments` (TEXT)

- **quality_control_plans**
  - `qc_plan_id` (PK, UUID)
  - `plan_name` (VARCHAR, not null)
  - `description` (TEXT)
  - `applicable_products` (ARRAY of UUID references to inventory.products.product_id)
  - `inspection_frequency` (VARCHAR, e.g., daily, weekly)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **quality_metrics**
  - `metric_id` (PK, UUID)
  - `metric_name` (VARCHAR, not null)
  - `description` (TEXT)
  - `calculation_formula` (TEXT, not null)
  - `target_value` (DECIMAL)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **quality_reports**
  - `report_id` (PK, UUID)
  - `report_name` (VARCHAR, not null)
  - `report_date` (DATE, not null)
  - `generated_by` (FK to auth.users.user_id)
  - `content` (TEXT)
  - `file_path` (VARCHAR)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **quality_audits**
  - `audit_id` (PK, UUID)
  - `qc_plan_id` (FK to quality_control_plans.qc_plan_id, not null)
  - `auditor_id` (FK to hr.employees.employee_id)
  - `audit_date` (TIMESTAMP, default now())
  - `findings` (TEXT)
  - `recommendations` (TEXT)
  - `status` (ENUM: planned, completed, pending_review)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **quality_training**
  - `training_id` (PK, UUID)
  - `employee_id` (FK to hr.employees.employee_id, not null)
  - `training_name` (VARCHAR, not null)
  - `description` (TEXT)
  - `completion_date` (DATE)
  - `status` (ENUM: completed, in_progress, not_started)
  - `certification` (BOOLEAN, default false)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **quality_notifications**
  - `notification_id` (PK, UUID)
  - `defect_id` (FK to quality_defects.defect_id)
  - `notification_type` (ENUM: email, SMS, push)
  - `recipient` (VARCHAR, not null)
  - `message` (TEXT, not null)
  - `sent_at` (TIMESTAMP)
  - `status` (ENUM: pending, sent, failed)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **quality_compliance**
  - `compliance_id` (PK, UUID)
  - `standard_id` (FK to quality_standards.standard_id, not null)
  - `regulation` (VARCHAR)
  - `description` (TEXT)
  - `compliance_date` (DATE)
  - `status` (ENUM: compliant, non_compliant, pending)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **quality_feedback**
  - `feedback_id` (PK, UUID)
  - `defect_id` (FK to quality_defects.defect_id)
  - `employee_id` (FK to hr.employees.employee_id)
  - `feedback_text` (TEXT)
  - `submitted_at` (TIMESTAMP, default now())
  - `status` (ENUM: reviewed, pending)
  - `comments` (TEXT)

- **quality_control_checklists**
  - `checklist_id` (PK, UUID)
  - `qc_plan_id` (FK to quality_control_plans.qc_plan_id, not null)
  - `item_description` (VARCHAR, not null)
  - `is_mandatory` (BOOLEAN, default true)
  - `sequence` (INTEGER)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **quality_control_templates**
  - `template_id` (PK, UUID)
  - `template_name` (VARCHAR, not null)
  - `description` (TEXT)
  - `checklist_items` (JSONB)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **quality_control_versions**
  - `version_id` (PK, UUID)
  - `qc_plan_id` (FK to quality_control_plans.qc_plan_id, not null)
  - `version_number` (INTEGER, not null)
  - `changes` (TEXT)
  - `updated_by` (FK to auth.users.user_id)
  - `updated_at` (TIMESTAMP, default now())

- **quality_notifications_settings**
  - `settings_id` (PK, UUID)
  - `notification_type` (ENUM: defect_report, inspection_result, audit_findings)
  - `enabled` (BOOLEAN, default true)
  - `recipients` (ARRAY of VARCHAR)
  - `delivery_method` (ENUM: email, SMS, push)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **quality_control_permissions**
  - `permission_id` (PK, UUID)
  - `role_id` (FK to auth.roles.role_id, not null)
  - `permission_name` (VARCHAR, not null)
  - `description` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **quality_control_audit_logs**
  - `audit_log_id` (PK, UUID)
  - `action` (VARCHAR, not null)
  - `performed_by` (FK to auth.users.user_id)
  - `timestamp` (TIMESTAMP, default now())
  - `description` (TEXT)
  - `created_at` (TIMESTAMP, default now())

---

## 17. **Compliance and Security**

### **Schema: compliance**

#### **Tables:**

- **compliance_regulations**
  - `regulation_id` (PK, UUID)
  - `regulation_name` (VARCHAR, not null)
  - `description` (TEXT)
  - `applicable_departments` (ARRAY of UUID references to departments.department_id)
  - `effective_date` (DATE)
  - `expiry_date` (DATE)
  - `status` (ENUM: active, inactive, expired)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **compliance_audits**
  - `audit_id` (PK, UUID)
  - `regulation_id` (FK to compliance_regulations.regulation_id, not null)
  - `auditor_id` (FK to hr.employees.employee_id)
  - `audit_date` (TIMESTAMP, default now())
  - `findings` (TEXT)
  - `recommendations` (TEXT)
  - `status` (ENUM: planned, completed, pending_review)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **compliance_issues**
  - `issue_id` (PK, UUID)
  - `audit_id` (FK to compliance_audits.audit_id, not null)
  - `description` (TEXT, not null)
  - `severity` (ENUM: low, medium, high, critical)
  - `status` (ENUM: identified, in_progress, resolved, closed)
  - `assigned_to` (FK to hr.employees.employee_id)
  - `reported_at` (TIMESTAMP, default now())
  - `resolved_at` (TIMESTAMP)
  - `comments` (TEXT)

- **compliance_training**
  - `training_id` (PK, UUID)
  - `regulation_id` (FK to compliance_regulations.regulation_id, not null)
  - `employee_id` (FK to hr.employees.employee_id, not null)
  - `training_name` (VARCHAR, not null)
  - `description` (TEXT)
  - `completion_date` (DATE)
  - `status` (ENUM: completed, in_progress, not_started)
  - `certification` (BOOLEAN, default false)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **data_privacy_policies**
  - `policy_id` (PK, UUID)
  - `policy_name` (VARCHAR, not null)
  - `description` (TEXT)
  - `effective_date` (DATE)
  - `expiry_date` (DATE)
  - `status` (ENUM: active, inactive, expired)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **security_policies**
  - `policy_id` (PK, UUID)
  - `policy_name` (VARCHAR, not null)
  - `description` (TEXT)
  - `effective_date` (DATE)
  - `expiry_date` (DATE)
  - `status` (ENUM: active, inactive, expired)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **access_controls**
  - `access_control_id` (PK, UUID)
  - `user_id` (FK to auth.users.user_id, not null)
  - `resource` (VARCHAR, not null)
  - `permission_level` (ENUM: read, write, execute, admin)
  - `granted_at` (TIMESTAMP, default now())
  - `expires_at` (TIMESTAMP)
  - `status` (ENUM: active, revoked, expired)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **incident_reports**
  - `incident_id` (PK, UUID)
  - `reported_by` (FK to auth.users.user_id)
  - `incident_type` (ENUM: data_breach, unauthorized_access, policy_violation, other)
  - `description` (TEXT, not null)
  - `severity` (ENUM: low, medium, high, critical)
  - `status` (ENUM: reported, under_investigation, resolved, closed)
  - `reported_at` (TIMESTAMP, default now())
  - `resolved_at` (TIMESTAMP)
  - `comments` (TEXT)

- **compliance_notifications**
  - `notification_id` (PK, UUID)
  - `compliance_issue_id` (FK to compliance_issues.issue_id)
  - `notification_type` (ENUM: email, SMS, push)
  - `recipient` (VARCHAR, not null)
  - `message` (TEXT, not null)
  - `sent_at` (TIMESTAMP)
  - `status` (ENUM: pending, sent, failed)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **compliance_audit_logs**
  - `audit_log_id` (PK, UUID)
  - `action` (VARCHAR, not null)
  - `performed_by` (FK to auth.users.user_id)
  - `timestamp` (TIMESTAMP, default now())
  - `description` (TEXT)
  - `created_at` (TIMESTAMP, default now())

- **compliance_roles_permissions**
  - `role_permission_id` (PK, UUID)
  - `role_id` (FK to auth.roles.role_id, not null)
  - `permission` (VARCHAR, not null)
  - `granted_at` (TIMESTAMP, default now())
  - `revoked_at` (TIMESTAMP)
  - `status` (ENUM: granted, revoked)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **compliance_data_access_logs**
  - `access_log_id` (PK, UUID)
  - `user_id` (FK to auth.users.user_id, not null)
  - `accessed_resource` (VARCHAR, not null)
  - `access_type` (ENUM: read, write, delete, update)
  - `access_time` (TIMESTAMP, default now())
  - `success` (BOOLEAN)
  - `ip_address` (INET)
  - `created_at` (TIMESTAMP, default now())

- **compliance_certifications**
  - `certification_id` (PK, UUID)
  - `employee_id` (FK to hr.employees.employee_id, not null)
  - `certification_name` (VARCHAR, not null)
  - `issuing_body` (VARCHAR)
  - `issue_date` (DATE)
  - `expiry_date` (DATE)
  - `status` (ENUM: valid, expired, revoked)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **compliance_dashboard**
  - `dashboard_id` (PK, UUID)
  - `user_id` (FK to auth.users.user_id)
  - `widget_config` (JSONB)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **compliance_alerts**
  - `alert_id` (PK, UUID)
  - `regulation_id` (FK to compliance_regulations.regulation_id)
  - `alert_type` (ENUM: deadline, compliance_violation, audit_scheduled)
  - `message` (TEXT)
  - `alert_date` (TIMESTAMP, default now())
  - `status` (ENUM: active, dismissed)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **compliance_training_sessions**
  - `training_session_id` (PK, UUID)
  - `regulation_id` (FK to compliance_regulations.regulation_id)
  - `session_name` (VARCHAR, not null)
  - `description` (TEXT)
  - `scheduled_date` (TIMESTAMP)
  - `duration_minutes` (INTEGER)
  - `trainer_id` (FK to hr.employees.employee_id)
  - `status` (ENUM: scheduled, completed, canceled)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **compliance_change_logs**
  - `change_log_id` (PK, UUID)
  - `regulation_id` (FK to compliance_regulations.regulation_id)
  - `changed_by` (FK to auth.users.user_id)
  - `change_description` (TEXT)
  - `change_date` (TIMESTAMP, default now())
  - `created_at` (TIMESTAMP, default now())

---

## 18. **Settings and Configuration**

### **Schema: settings**

#### **Tables:**

- **application_settings**
  - `setting_id` (PK, UUID)
  - `setting_key` (VARCHAR, unique, not null)
  - `setting_value` (VARCHAR)
  - `description` (TEXT)
  - `data_type` (ENUM: string, integer, boolean, json, other)
  - `is_editable` (BOOLEAN, default true)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **module_settings**
  - `module_setting_id` (PK, UUID)
  - `module_name` (VARCHAR, not null)
  - `setting_key` (VARCHAR, not null)
  - `setting_value` (VARCHAR)
  - `description` (TEXT)
  - `data_type` (ENUM: string, integer, boolean, json, other)
  - `is_editable` (BOOLEAN, default true)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **user_preferences**
  - `preference_id` (PK, UUID)
  - `user_id` (FK to auth.users.user_id, not null)
  - `preference_key` (VARCHAR, not null)
  - `preference_value` (VARCHAR)
  - `data_type` (ENUM: string, integer, boolean, json, other)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **api_configurations**
  - `api_config_id` (PK, UUID)
  - `api_name` (VARCHAR, not null)
  - `base_url` (VARCHAR, not null)
  - `api_key` (VARCHAR)
  - `api_secret` (VARCHAR)
  - `headers` (JSONB)
  - `timeout` (INTEGER, default 30)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **theme_settings**
  - `theme_id` (PK, UUID)
  - `user_id` (FK to auth.users.user_id)
  - `theme_name` (VARCHAR, not null)
  - `primary_color` (VARCHAR)
  - `secondary_color` (VARCHAR)
  - `font_style` (VARCHAR)
  - `layout_preferences` (JSONB)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **notification_settings**
  - `notification_setting_id` (PK, UUID)
  - `user_id` (FK to auth.users.user_id, not null)
  - `notification_type` (ENUM: email, SMS, push)
  - `enabled` (BOOLEAN, default true)
  - `preferences` (JSONB)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **integration_settings**
  - `integration_setting_id` (PK, UUID)
  - `module_name` (VARCHAR, not null)
  - `integration_type` (ENUM: ERP, CRM, eCommerce, other)
  - `configuration` (JSONB)
  - `status` (ENUM: active, inactive)
  - `last_synced_at` (TIMESTAMP)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **backup_settings**
  - `backup_setting_id` (PK, UUID)
  - `backup_frequency` (ENUM: daily, weekly, monthly)
  - `backup_time` (TIME, not null)
  - `backup_location` (VARCHAR, not null)
  - `retention_period_days` (INTEGER, not null)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **locale_settings**
  - `locale_setting_id` (PK, UUID)
  - `user_id` (FK to auth.users.user_id)
  - `language` (VARCHAR, default 'en')
  - `timezone` (VARCHAR, default 'UTC')
  - `date_format` (VARCHAR, default 'YYYY-MM-DD')
  - `currency` (VARCHAR, default 'USD')
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **feature_flags**
  - `feature_flag_id` (PK, UUID)
  - `feature_name` (VARCHAR, unique, not null)
  - `is_enabled` (BOOLEAN, default false)
  - `rollout_percentage` (INTEGER, default 0, check between 0 and 100)
  - `description` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **system_logs**
  - `log_id` (PK, UUID)
  - `log_level` (ENUM: info, warning, error, critical)
  - `message` (TEXT, not null)
  - `source` (VARCHAR)
  - `logged_at` (TIMESTAMP, default now())
  - `user_id` (FK to auth.users.user_id)
  - `ip_address` (INET)
  - `created_at` (TIMESTAMP, default now())

- **system_metrics**
  - `metric_id` (PK, UUID)
  - `metric_name` (VARCHAR, not null)
  - `metric_value` (DECIMAL, not null)
  - `metric_unit` (VARCHAR)
  - `recorded_at` (TIMESTAMP, default now())
  - `created_at` (TIMESTAMP, default now())

- **system_preferences**
  - `preference_id` (PK, UUID)
  - `preference_key` (VARCHAR, unique, not null)
  - `preference_value` (VARCHAR)
  - `data_type` (ENUM: string, integer, boolean, json, other)
  - `is_editable` (BOOLEAN, default true)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **system_notifications**
  - `notification_id` (PK, UUID)
  - `notification_type` (VARCHAR, not null)
  - `message` (TEXT, not null)
  - `severity` (ENUM: info, warning, error, critical)
  - `target_audience` (VARCHAR)
  - `status` (ENUM: active, dismissed)
  - `sent_at` (TIMESTAMP)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **api_keys**
  - `api_key_id` (PK, UUID)
  - `user_id` (FK to auth.users.user_id, not null)
  - `key` (VARCHAR, unique, not null)
  - `description` (TEXT)
  - `permissions` (ARRAY of UUID references to auth.permissions.permission_id)
  - `expires_at` (TIMESTAMP)
  - `status` (ENUM: active, revoked, expired)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **system_configurations**
  - `config_id` (PK, UUID)
  - `config_key` (VARCHAR, unique, not null)
  - `config_value` (VARCHAR, not null)
  - `description` (TEXT)
  - `last_modified_by` (FK to auth.users.user_id)
  - `last_modified_at` (TIMESTAMP, default now())
  - `created_at` (TIMESTAMP, default now())

- **scheduled_tasks**
  - `task_id` (PK, UUID)
  - `task_name` (VARCHAR, not null)
  - `task_description` (TEXT)
  - `schedule` (VARCHAR, e.g., cron expression)
  - `last_run` (TIMESTAMP)
  - `next_run` (TIMESTAMP)
  - `status` (ENUM: scheduled, running, completed, failed)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

---

## 19. **Notifications and Alerts**

### **Schema: notifications**

#### **Tables:**

- **notifications**
  - `notification_id` (PK, UUID)
  - `user_id` (FK to auth.users.user_id, not null)
  - `title` (VARCHAR, not null)
  - `message` (TEXT, not null)
  - `notification_type` (ENUM: info, warning, alert, reminder)
  - `status` (ENUM: unread, read, archived)
  - `sent_at` (TIMESTAMP, default now())
  - `read_at` (TIMESTAMP)
  - `expires_at` (TIMESTAMP)
  - `metadata` (JSONB)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **notification_templates**
  - `template_id` (PK, UUID)
  - `template_name` (VARCHAR, unique, not null)
  - `template_type` (ENUM: email, SMS, push, in_app)
  - `subject` (VARCHAR)
  - `body` (TEXT, not null)
  - `placeholders` (ARRAY of VARCHAR)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **notification_subscriptions**
  - `subscription_id` (PK, UUID)
  - `user_id` (FK to auth.users.user_id, not null)
  - `event_type` (VARCHAR, not null)
  - `delivery_method` (ENUM: email, SMS, push, in_app)
  - `is_active` (BOOLEAN, default true)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **notification_logs**
  - `log_id` (PK, UUID)
  - `notification_id` (FK to notifications.notification_id, not null)
  - `delivery_method` (ENUM: email, SMS, push, in_app)
  - `status` (ENUM: sent, failed, queued)
  - `delivered_at` (TIMESTAMP)
  - `failed_reason` (TEXT)
  - `created_at` (TIMESTAMP, default now())

- **alerts**
  - `alert_id` (PK, UUID)
  - `alert_name` (VARCHAR, not null)
  - `description` (TEXT)
  - `alert_type` (ENUM: system, user, security, custom)
  - `severity` (ENUM: low, medium, high, critical)
  - `trigger_condition` (JSONB)
  - `action` (JSONB)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **alert_triggers**
  - `trigger_id` (PK, UUID)
  - `alert_id` (FK to alerts.alert_id, not null)
  - `condition` (VARCHAR, not null)
  - `threshold` (DECIMAL)
  - `comparison_operator` (ENUM: >, <, =, >=, <=, !=)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **alert_actions**
  - `action_id` (PK, UUID)
  - `alert_id` (FK to alerts.alert_id, not null)
  - `action_type` (ENUM: send_email, send_SMS, trigger_webhook, notify_user)
  - `action_details` (JSONB)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **alert_logs**
  - `alert_log_id` (PK, UUID)
  - `alert_id` (FK to alerts.alert_id, not null)
  - `triggered_at` (TIMESTAMP, default now())
  - `status` (ENUM: triggered, resolved, dismissed)
  - `resolved_at` (TIMESTAMP)
  - `comments` (TEXT)
  - `created_at` (TIMESTAMP, default now())

- **reminders**
  - `reminder_id` (PK, UUID)
  - `user_id` (FK to auth.users.user_id, not null)
  - `title` (VARCHAR, not null)
  - `message` (TEXT, not null)
  - `reminder_time` (TIMESTAMP, not null)
  - `status` (ENUM: pending, sent, dismissed)
  - `metadata` (JSONB)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **notification_preferences**
  - `preference_id` (PK, UUID)
  - `user_id` (FK to auth.users.user_id, not null)
  - `notification_type` (ENUM: email, SMS, push, in_app)
  - `enabled` (BOOLEAN, default true)
  - `frequency` (ENUM: immediate, daily, weekly)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **notification_rules**
  - `rule_id` (PK, UUID)
  - `user_id` (FK to auth.users.user_id, not null)
  - `rule_name` (VARCHAR, not null)
  - `conditions` (JSONB)
  - `actions` (JSONB)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **push_notifications**
  - `push_id` (PK, UUID)
  - `user_id` (FK to auth.users.user_id, not null)
  - `title` (VARCHAR, not null)
  - `message` (TEXT, not null)
  - `device_token` (VARCHAR, not null)
  - `status` (ENUM: sent, failed, pending)
  - `sent_at` (TIMESTAMP)
  - `failed_reason` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **email_notifications**
  - `email_id` (PK, UUID)
  - `user_id` (FK to auth.users.user_id, not null)
  - `subject` (VARCHAR, not null)
  - `body` (TEXT, not null)
  - `recipient_email` (VARCHAR, not null)
  - `status` (ENUM: sent, failed, queued)
  - `sent_at` (TIMESTAMP)
  - `failed_reason` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **sms_notifications**
  - `sms_id` (PK, UUID)
  - `user_id` (FK to auth.users.user_id, not null)
  - `message` (TEXT, not null)
  - `recipient_phone` (VARCHAR, not null)
  - `status` (ENUM: sent, failed, queued)
  - `sent_at` (TIMESTAMP)
  - `failed_reason` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **in_app_notifications**
  - `in_app_id` (PK, UUID)
  - `user_id` (FK to auth.users.user_id, not null)
  - `title` (VARCHAR, not null)
  - `message` (TEXT, not null)
  - `is_read` (BOOLEAN, default false)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **notification_templates_history**
  - `template_history_id` (PK, UUID)
  - `template_id` (FK to notification_templates.template_id, not null)
  - `version` (INTEGER, not null)
  - `subject` (VARCHAR)
  - `body` (TEXT)
  - `updated_by` (FK to auth.users.user_id)
  - `updated_at` (TIMESTAMP, default now())
  - `created_at` (TIMESTAMP, default now())

---

## 20. **Integration and APIs**

### **Schema: integrations**

#### **Tables:**

- **api_endpoints**
  - `api_endpoint_id` (PK, UUID)
  - `name` (VARCHAR, not null)
  - `description` (TEXT)
  - `url` (VARCHAR, not null)
  - `http_method` (ENUM: GET, POST, PUT, DELETE, PATCH)
  - `authentication_type` (ENUM: none, api_key, oauth, other)
  - `api_key` (VARCHAR)
  - `oauth_token` (VARCHAR)
  - `status` (ENUM: active, inactive, deprecated)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **api_calls**
  - `api_call_id` (PK, UUID)
  - `api_endpoint_id` (FK to api_endpoints.api_endpoint_id, not null)
  - `request_payload` (JSONB)
  - `response_payload` (JSONB)
  - `status_code` (INTEGER)
  - `call_status` (ENUM: success, failure, pending)
  - `called_at` (TIMESTAMP, default now())
  - `response_time_ms` (INTEGER)
  - `error_message` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **api_keys_management**
  - `api_key_id` (PK, UUID)
  - `user_id` (FK to auth.users.user_id, not null)
  - `key` (VARCHAR, unique, not null)
  - `permissions` (ARRAY of UUID references to auth.permissions.permission_id)
  - `expires_at` (TIMESTAMP)
  - `status` (ENUM: active, revoked, expired)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **webhooks**
  - `webhook_id` (PK, UUID)
  - `integration_id` (FK to integrations.integration_id, not null)
  - `event` (VARCHAR, not null)
  - `callback_url` (VARCHAR, not null)
  - `secret` (VARCHAR)
  - `status` (ENUM: active, inactive)
  - `last_triggered` (TIMESTAMP)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **integration_logs**
  - `integration_log_id` (PK, UUID)
  - `integration_id` (FK to integrations.integration_id, not null)
  - `action` (VARCHAR, not null)
  - `status` (ENUM: success, failure, pending)
  - `message` (TEXT)
  - `logged_at` (TIMESTAMP, default now())
  - `created_at` (TIMESTAMP, default now())

- **integration_credentials**
  - `credential_id` (PK, UUID)
  - `integration_id` (FK to integrations.integration_id, not null)
  - `credential_type` (ENUM: username_password, token, certificate, other)
  - `credential_data` (JSONB)
  - `status` (ENUM: active, inactive, expired)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **data_mappings**
  - `mapping_id` (PK, UUID)
  - `integration_id` (FK to integrations.integration_id, not null)
  - `source_field` (VARCHAR, not null)
  - `destination_field` (VARCHAR, not null)
  - `transformation` (TEXT)
  - `active` (BOOLEAN, default true)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **batch_jobs**
  - `job_id` (PK, UUID)
  - `integration_id` (FK to integrations.integration_id, not null)
  - `job_type` (ENUM: import, export, sync)
  - `status` (ENUM: pending, running, completed, failed)
  - `scheduled_at` (TIMESTAMP)
  - `started_at` (TIMESTAMP)
  - `completed_at` (TIMESTAMP)
  - `error_message` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **real_time_connections**
  - `connection_id` (PK, UUID)
  - `integration_id` (FK to integrations.integration_id, not null)
  - `connection_type` (ENUM: websocket, long_polling, other)
  - `endpoint` (VARCHAR)
  - `status` (ENUM: connected, disconnected, error)
  - `connected_at` (TIMESTAMP)
  - `disconnected_at` (TIMESTAMP)
  - `error_message` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **integration_permissions**
  - `permission_id` (PK, UUID)
  - `integration_id` (FK to integrations.integration_id, not null)
  - `permission_name` (VARCHAR, not null)
  - `description` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **api_rate_limits**
  - `rate_limit_id` (PK, UUID)
  - `integration_id` (FK to integrations.integration_id, not null)
  - `limit` (INTEGER, not null)
  - `period` (VARCHAR, e.g., 'minute', 'hour', 'day')
  - `current_usage` (INTEGER, default 0)
  - `reset_at` (TIMESTAMP)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **api_throttling**
  - `throttling_id` (PK, UUID)
  - `integration_id` (FK to integrations.integration_id, not null)
  - `threshold` (INTEGER, not null)
  - `action` (ENUM: delay, reject, notify)
  - `action_details` (JSONB)
  - `enabled` (BOOLEAN, default true)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **api_dependencies**
  - `dependency_id` (PK, UUID)
  - `integration_id` (FK to integrations.integration_id, not null)
  - `dependent_integration_id` (FK to integrations.integration_id)
  - `dependency_type` (ENUM: data, service, other)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **integration_metadata**
  - `metadata_id` (PK, UUID)
  - `integration_id` (FK to integrations.integration_id, not null)
  - `key` (VARCHAR, not null)
  - `value` (VARCHAR)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **api_usage_statistics**
  - `usage_id` (PK, UUID)
  - `integration_id` (FK to integrations.integration_id, not null)
  - `endpoint_id` (FK to api_endpoints.api_endpoint_id)
  - `call_count` (INTEGER, default 0)
  - `successful_calls` (INTEGER, default 0)
  - `failed_calls` (INTEGER, default 0)
  - `average_response_time_ms` (DECIMAL, default 0)
  - `last_called_at` (TIMESTAMP)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **api_error_logs**
  - `error_log_id` (PK, UUID)
  - `integration_id` (FK to integrations.integration_id, not null)
  - `api_endpoint_id` (FK to api_endpoints.api_endpoint_id)
  - `error_message` (TEXT, not null)
  - `error_code` (INTEGER)
  - `occurred_at` (TIMESTAMP, default now())
  - `resolved` (BOOLEAN, default false)
  - `resolved_at` (TIMESTAMP)
  - `comments` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **api_documentation**
  - `documentation_id` (PK, UUID)
  - `api_endpoint_id` (FK to api_endpoints.api_endpoint_id, not null)
  - `documentation_text` (TEXT, not null)
  - `version` (VARCHAR, default '1.0')
  - `last_updated_by` (FK to auth.users.user_id)
  - `last_updated_at` (TIMESTAMP, default now())
  - `created_at` (TIMESTAMP, default now())

- **api_webhooks_history**
  - `history_id` (PK, UUID)
  - `webhook_id` (FK to webhooks.webhook_id, not null)
  - `payload` (JSONB)
  - `status` (ENUM: delivered, failed, pending)
  - `attempts` (INTEGER, default 0)
  - `last_attempt_at` (TIMESTAMP)
  - `response` (TEXT)
  - `created_at` (TIMESTAMP, default now())

- **api_event_subscriptions**
  - `subscription_id` (PK, UUID)
  - `integration_id` (FK to integrations.integration_id, not null)
  - `event_name` (VARCHAR, not null)
  - `callback_url` (VARCHAR, not null)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **api_access_logs**
  - `access_log_id` (PK, UUID)
  - `api_key_id` (FK to api_keys_management.api_key_id, not null)
  - `api_endpoint_id` (FK to api_endpoints.api_endpoint_id, not null)
  - `request_method` (ENUM: GET, POST, PUT, DELETE, PATCH)
  - `request_payload` (JSONB)
  - `response_payload` (JSONB)
  - `response_status_code` (INTEGER)
  - `response_time_ms` (INTEGER)
  - `ip_address` (INET)
  - `accessed_at` (TIMESTAMP, default now())
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **api_dependency_logs**
  - `dependency_log_id` (PK, UUID)
  - `integration_id` (FK to integrations.integration_id, not null)
  - `dependent_integration_id` (FK to integrations.integration_id)
  - `status` (ENUM: operational, degraded, down)
  - `reported_at` (TIMESTAMP, default now())
  - `comments` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **api_maintenance_windows**
  - `maintenance_window_id` (PK, UUID)
  - `integration_id` (FK to integrations.integration_id, not null)
  - `start_time` (TIMESTAMP, not null)
  - `end_time` (TIMESTAMP, not null)
  - `description` (TEXT)
  - `status` (ENUM: scheduled, in_progress, completed, canceled)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **api_feature_toggles**
  - `feature_toggle_id` (PK, UUID)
  - `integration_id` (FK to integrations.integration_id, not null)
  - `feature_name` (VARCHAR, not null)
  - `is_enabled` (BOOLEAN, default false)
  - `rollout_percentage` (INTEGER, default 0, check between 0 and 100)
  - `description` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **api_keys_audit_logs**
  - `audit_log_id` (PK, UUID)
  - `api_key_id` (FK to api_keys_management.api_key_id, not null)
  - `action` (ENUM: created, updated, revoked, expired)
  - `performed_by` (FK to auth.users.user_id)
  - `performed_at` (TIMESTAMP, default now())
  - `comments` (TEXT)
  - `created_at` (TIMESTAMP, default now())

- **api_versioning**
  - `version_id` (PK, UUID)
  - `api_endpoint_id` (FK to api_endpoints.api_endpoint_id, not null)
  - `version_number` (VARCHAR, not null)
  - `release_date` (DATE)
  - `deprecated` (BOOLEAN, default false)
  - `deprecated_date` (TIMESTAMP)
  - `created_by` (FK to auth.users.user_id)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **api_documentation_versions**
  - `doc_version_id` (PK, UUID)
  - `documentation_id` (FK to api_documentation.documentation_id, not null)
  - `version_number` (VARCHAR, not null)
  - `content` (TEXT, not null)
  - `updated_by` (FK to auth.users.user_id)
  - `updated_at` (TIMESTAMP, default now())
  - `created_at` (TIMESTAMP, default now())

- **api_change_requests**
  - `change_request_id` (PK, UUID)
  - `integration_id` (FK to integrations.integration_id, not null)
  - `requested_by` (FK to auth.users.user_id, not null)
  - `change_type` (ENUM: addition, modification, deletion)
  - `description` (TEXT, not null)
  - `status` (ENUM: pending, approved, rejected, implemented)
  - `requested_at` (TIMESTAMP, default now())
  - `approved_by` (FK to auth.users.user_id)
  - `approved_at` (TIMESTAMP)
  - `implemented_at` (TIMESTAMP)
  - `comments` (TEXT)

- **api_documentation_access**
  - `access_id` (PK, UUID)
  - `documentation_id` (FK to api_documentation.documentation_id, not null)
  - `user_id` (FK to auth.users.user_id, not null)
  - `access_type` (ENUM: view, edit, delete)
  - `granted_at` (TIMESTAMP, default now())
  - `revoked_at` (TIMESTAMP)
  - `status` (ENUM: granted, revoked)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **api_deprecation_logs**
  - `deprecation_log_id` (PK, UUID)
  - `api_endpoint_id` (FK to api_endpoints.api_endpoint_id, not null)
  - `version_id` (FK to api_versioning.version_id, not null)
  - `deprecation_date` (TIMESTAMP, not null)
  - `reason` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **api_dependency_mappings**
  - `dependency_mapping_id` (PK, UUID)
  - `api_endpoint_id` (FK to api_endpoints.api_endpoint_id, not null)
  - `dependent_api_id` (FK to api_endpoints.api_endpoint_id, not null)
  - `dependency_type` (ENUM: data, service, other)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **api_response_caching**
  - `cache_id` (PK, UUID)
  - `api_endpoint_id` (FK to api_endpoints.api_endpoint_id, not null)
  - `cache_duration_seconds` (INTEGER, not null)
  - `cache_enabled` (BOOLEAN, default true)
  - `cache_rules` (JSONB)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **api_usage_limits**
  - `usage_limit_id` (PK, UUID)
  - `api_endpoint_id` (FK to api_endpoints.api_endpoint_id, not null)
  - `limit` (INTEGER, not null)
  - `time_window` (VARCHAR, e.g., 'minute', 'hour', 'day')
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **api_error_handling**
  - `error_handling_id` (PK, UUID)
  - `api_endpoint_id` (FK to api_endpoints.api_endpoint_id, not null)
  - `error_code` (INTEGER, not null)
  - `error_message` (VARCHAR, not null)
  - `retry_strategy` (ENUM: none, immediate, exponential_backoff)
  - `fallback_action` (VARCHAR)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **api_documentation_feedback**
  - `feedback_id` (PK, UUID)
  - `documentation_id` (FK to api_documentation.documentation_id, not null)
  - `user_id` (FK to auth.users.user_id)
  - `feedback_text` (TEXT)
  - `rating` (INTEGER, check between 1 and 5)
  - `submitted_at` (TIMESTAMP, default now())
  - `status` (ENUM: reviewed, pending)
  - `comments` (TEXT)

- **api_sync_jobs**
  - `sync_job_id` (PK, UUID)
  - `integration_id` (FK to integrations.integration_id, not null)
  - `job_type` (ENUM: full_sync, incremental_sync)
  - `status` (ENUM: pending, running, completed, failed)
  - `started_at` (TIMESTAMP)
  - `completed_at` (TIMESTAMP)
  - `error_message` (TEXT)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **api_throttling_rules**
  - `throttling_rule_id` (PK, UUID)
  - `integration_id` (FK to integrations.integration_id, not null)
  - `rule_name` (VARCHAR, not null)
  - `condition` (JSONB)
  - `action` (JSONB)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **api_dependency_alerts**
  - `dependency_alert_id` (PK, UUID)
  - `integration_id` (FK to integrations.integration_id, not null)
  - `dependent_integration_id` (FK to integrations.integration_id, not null)
  - `alert_type` (ENUM: dependency_down, performance_degradation)
  - `threshold` (DECIMAL)
  - `comparison_operator` (ENUM: >, <, =, >=, <=, !=)
  - `action` (JSONB)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **api_health_checks**
  - `health_check_id` (PK, UUID)
  - `integration_id` (FK to integrations.integration_id, not null)
  - `endpoint_id` (FK to api_endpoints.api_endpoint_id)
  - `check_type` (ENUM: ping, response_time, uptime)
  - `expected_response` (VARCHAR)
  - `threshold` (DECIMAL)
  - `frequency` (INTEGER, in minutes)
  - `last_checked_at` (TIMESTAMP)
  - `status` (ENUM: healthy, degraded, unhealthy)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

- **api_security_policies**
  - `security_policy_id` (PK, UUID)
  - `integration_id` (FK to integrations.integration_id, not null)
  - `policy_name` (VARCHAR, not null)
  - `policy_description` (TEXT)
  - `enforcement_level` (ENUM: strict, moderate, lenient)
  - `rules` (JSONB)
  - `status` (ENUM: active, inactive)
  - `created_at` (TIMESTAMP, default now())
  - `updated_at` (TIMESTAMP)

---

## **Additional Considerations**

1. **Indexes and Constraints:**
   - Implement appropriate indexes on frequently queried columns to optimize performance.
   - Enforce foreign key constraints to maintain referential integrity.
   - Use unique constraints where necessary to prevent duplicate entries.
   - Implement check constraints to ensure data validity (e.g., ENUM values, numerical ranges).

2. **Data Types:**
   - Utilize appropriate data types (e.g., `UUID` for primary keys, `JSONB` for flexible data storage).
   - Consider using `ENUM` types for fields with a limited set of possible values.

3. **Normalization:**
   - Ensure the database is normalized to reduce redundancy and improve data integrity.
   - Use junction tables (many-to-many relationships) where applicable.

4. **Scalability:**
   - Design schemas to accommodate future growth and additional modules.
   - Consider partitioning large tables if necessary.

5. **Security:**
   - Implement role-based access control (RBAC) to restrict data access based on user roles.
   - Encrypt sensitive data at rest and in transit.
   - Regularly audit access logs to detect unauthorized access.

6. **Performance:**
   - Optimize queries and utilize caching strategies where applicable.
   - Regularly monitor and tune database performance.

7. **Integration with React Native:**
   - Ensure APIs are designed to efficiently interact with the React Native frontend.
   - Implement pagination, filtering, and sorting mechanisms for data-heavy endpoints.
   - Use secure authentication methods (e.g., JWT) for API access.

8. **Backup and Recovery:**
   - Implement regular backup schedules and ensure data can be restored in case of failures.
   - Store backups in secure, redundant locations.

9. **Documentation:**
   - Maintain comprehensive documentation of the database schemas, relationships, and API endpoints.
   - Use tools like Swagger or Postman for API documentation.

10. **Testing:**
    - Implement thorough testing for all database operations to ensure data integrity and application reliability.
    - Use automated testing frameworks to validate database functionality.

---

This comprehensive PostgreSQL database schema covers all essential aspects of an ERP system, ensuring that the business can manage its operations efficiently. Each schema and table is meticulously designed to encapsulate the necessary data, maintain integrity, and provide scalability for future growth. Integrating this database with a React Native application will facilitate a robust and responsive user experience, enabling seamless interaction with the ERP system's functionalities.
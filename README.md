# e-commerce-db

This repository contains the SQL schema for a foundational E-commerce database designed using PostgreSQL. It provides a robust structure to manage customers, products, categories, orders, and order items.

## Features

* **Modular Design**: Separated concerns with dedicated tables for different entities (Customers, Products, Orders).
* **Clear Relationships**: Defines primary and foreign keys to ensure data integrity and establish clear relationships between tables.
* **Data Validation**: Includes `NOT NULL` constraints and `CHECK` constraints to enforce data quality (e.g., non-negative prices, positive quantities).
* **Performance Optimization**: Utilizes `SERIAL` for auto-incrementing primary keys and includes indexes on frequently queried foreign key columns to improve query performance.
* **PostgreSQL Specific**: Leverages PostgreSQL-specific features like `SERIAL`, `TEXT` data type, and `TIMESTAMP DEFAULT CURRENT_TIMESTAMP`.

##  Database Schema

The database schema is designed to represent core E-commerce entities and their interactions.

### Entities & Relationships

The schema consists of the following tables:

* **`public.categories`**: Stores product categories.
* **`public.customers`**: Manages customer information.
* **`public.products`**: Contains details about individual products.
* **`public.orders`**: Records customer orders.
* **`public.order_items`**: Details the individual products within each order (junction table for a Many-to-Many relationship between Orders and Products).

## 🚀 Getting Started

To set up this database schema on your local PostgreSQL instance:

1.  **Install PostgreSQL**: If you don't have PostgreSQL installed, download and install it from [PostgreSQL Official Website](https://www.postgresql.org/download/).
2.  **Create a Database**: Open your PostgreSQL client (e.g., `psql`, pgAdmin, DBeaver) and create a new database.
    ```sql
    CREATE DATABASE e_commerce_db;
    ```
3.  **Connect to the Database**: Connect to the newly created database.
    ```sql
    \c e_commerce_db;
    ```
4.  **Execute the Schema Script**: Copy the entire SQL schema provided in this repository (e.g., `schema.sql` if you save it to a file) and execute it in your PostgreSQL client.
    ```sql
    -- If you saved the schema to a file named 'schema.sql'
    \i /path/to/your/schema.sql
    ```
    Alternatively, you can just paste the `CREATE TABLE` statements directly into your client.

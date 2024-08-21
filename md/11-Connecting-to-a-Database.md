# Lesson 11: Connecting to a Database

## Objectives
By the end of this lesson, you will:
- Understand the difference between SQL and NoSQL databases.
- Set up and connect to a MongoDB database using Mongoose.

## Introduction to Databases

Databases are essential for storing, retrieving, and managing data in applications. There are two primary types of databases: SQL (relational) and NoSQL (non-relational).

### SQL Databases

- **Structured Query Language (SQL):** SQL databases use a structured query language for defining and manipulating the data.
- **Relational Model:** Data is stored in tables with predefined schemas, and relationships can be established between tables.
- **Examples:** MySQL, PostgreSQL, SQLite.

### NoSQL Databases

- **Non-Relational:** NoSQL databases are designed to handle unstructured or semi-structured data without a fixed schema.
- **Flexible Data Models:** They can store data in various formats, such as key-value pairs, documents, or graphs.
- **Examples:** MongoDB, Cassandra, Couchbase.

**Choosing the Right Database:**
- Use SQL databases for applications requiring complex queries and transactions.
- Use NoSQL databases for applications needing flexibility, scalability, and high performance with large volumes of unstructured data.

## 1. Setting Up MongoDB

### Step 1: Install MongoDB

If you haven't installed MongoDB yet, follow these steps based on your operating system:

#### For Windows:

1. Download the MongoDB installer from the official website: [MongoDB Download Center](https://www.mongodb.com/try/download/community).
2. Follow the installation instructions.
3. After installation, ensure the MongoDB server is running. You can start it by running the following command in the Command Prompt:
   ```bash
   mongod
   ```

#### For macOS:

1. If you have Homebrew installed, run:
   ```bash
   brew tap mongodb/brew
   brew install mongodb-community
   ```
2. Start the MongoDB server:
   ```bash
   brew services start mongodb/brew/mongodb-community
   ```

#### For Linux:

1. Follow the installation instructions for your specific distribution from the official MongoDB documentation: [Install MongoDB](https://docs.mongodb.com/manual/installation/).

### Step 2: Install Mongoose

Mongoose is an Object Data Modeling (ODM) library for MongoDB and Node.js. It provides a schema-based solution for modeling your application data.

1. **Create a New Directory for Your Project:**
   ```bash
   mkdir mongo-app
   cd mongo-app
   ```

2. **Initialize npm:**
   ```bash
   npm init -y
   ```

3. **Install Mongoose:**
   ```bash
   npm install mongoose
   ```

## 2. Connecting to MongoDB Using Mongoose

### Step 1: Create a New File

Create a file named `app.js` in your project directory:

```bash
touch app.js
```

### Step 2: Write the Connection Code

Open `app.js` in your code editor and add the following code to connect to your MongoDB database:

```javascript
const mongoose = require('mongoose');

// Replace 'your_database_name' with the name of your database
const dbURI = 'mongodb://localhost:27017/your_database_name';

// Connect to MongoDB
mongoose.connect(dbURI, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => {
        console.log('Connected to MongoDB successfully!');
    })
    .catch((err) => {
        console.error('MongoDB connection error:', err);
    });
```

### Step 3: Define a Mongoose Schema and Model

A schema defines the structure of the documents in a collection, and a model provides an interface to interact with that collection.

```javascript
// Define a schema for a User
const userSchema = new mongoose.Schema({
    name: { type: String, required: true },
    age: { type: Number, required: true },
    email: { type: String, required: true },
});

// Create a model based on the schema
const User = mongoose.model('User', userSchema);
```

### Step 4: Create a New User Document

You can now create a new user document and save it to the database:

```javascript
const newUser = new User({
    name: 'Alice',
    age: 30,
    email: 'alice@example.com',
});

// Save the user to the database
newUser.save()
    .then(() => {
        console.log('User created successfully!');
        mongoose.connection.close(); // Close the connection
    })
    .catch((err) => {
        console.error('Error creating user:', err);
    });
```

### Step 5: Complete Code Example

Here’s the complete code for `app.js` that connects to MongoDB and creates a new user:

```javascript
const mongoose = require('mongoose');

// Replace 'your_database_name' with the name of your database
const dbURI = 'mongodb://localhost:27017/your_database_name';

// Connect to MongoDB
mongoose.connect(dbURI, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => {
        console.log('Connected to MongoDB successfully!');

        // Define a schema for a User
        const userSchema = new mongoose.Schema({
            name: { type: String, required: true },
            age: { type: Number, required: true },
            email: { type: String, required: true },
        });

        // Create a model based on the schema
        const User = mongoose.model('User', userSchema);

        // Create a new user document
        const newUser = new User({
            name: 'Alice',
            age: 30,
            email: 'alice@example.com',
        });

        // Save the user to the database
        return newUser.save();
    })
    .then(() => {
        console.log('User created successfully!');
        mongoose.connection.close(); // Close the connection
    })
    .catch((err) => {
        console.error('MongoDB connection error:', err);
    });
```

## Conclusion

In this lesson, you learned about the differences between SQL and NoSQL databases, and you set up and connected to a MongoDB database using Mongoose. You also defined a schema and created a new user document. Understanding how to connect to a database is essential for building data-driven applications. In the next lesson, we will explore CRUD operations (Create, Read, Update, Delete) using Mongoose.

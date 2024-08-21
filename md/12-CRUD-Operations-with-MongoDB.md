# Lesson 12: CRUD Operations with MongoDB

## Objectives
By the end of this lesson, you will:
- Implement Create, Read, Update, and Delete (CRUD) operations using Mongoose with MongoDB.
- Learn how to structure and validate data models.

## Introduction to CRUD Operations

CRUD stands for Create, Read, Update, and Delete. These operations are the four basic functions of persistent storage and are essential for interacting with databases. In this lesson, we will implement these operations using Mongoose with MongoDB.

## 1. Setting Up Your Express Application

If you haven't already, create a new directory for this lesson and set up a basic Express application with MongoDB:

1. **Create a New Directory:**
   ```bash
   mkdir crud-app
   cd crud-app
   ```

2. **Initialize npm:**
   ```bash
   npm init -y
   ```

3. **Install Express and Mongoose:**
   ```bash
   npm install express mongoose
   ```

4. **Create the `app.js` File:**
   ```bash
   touch app.js
   ```

### Step 1: Set Up Express and Mongoose

Open `app.js` in your code editor and add the following code to set up the server and connect to MongoDB:

```javascript
const express = require('express');
const mongoose = require('mongoose');

const app = express();
const PORT = 3000;

// Middleware to parse JSON request bodies
app.use(express.json());

// Connect to MongoDB
const dbURI = 'mongodb://localhost:27017/crud_example';
mongoose.connect(dbURI, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => console.log('Connected to MongoDB successfully!'))
    .catch((err) => console.error('MongoDB connection error:', err));
```

## 2. Structuring and Validating Data Models

### Step 2: Define a Mongoose Schema and Model

We will create a simple data model for a `User` with validation rules.

```javascript
// Define a schema for a User
const userSchema = new mongoose.Schema({
    name: { type: String, required: true },
    age: { type: Number, required: true, min: 0 },
    email: { type: String, required: true, unique: true },
});

// Create a model based on the schema
const User = mongoose.model('User', userSchema);
```

## 3. Implementing CRUD Operations

### A. Create Operation

The Create operation adds new documents to the database.

```javascript
// Create a new user
app.post('/api/users', (req, res) => {
    const newUser = new User(req.body); // Create a new user instance

    newUser.save()
        .then((user) => {
            res.status(201).json({ message: 'User created successfully!', user });
        })
        .catch((err) => {
            res.status(400).json({ error: err.message });
        });
});
```

### B. Read Operation

The Read operation retrieves documents from the database.

```javascript
// Get all users
app.get('/api/users', (req, res) => {
    User.find()
        .then((users) => {
            res.json(users);
        })
        .catch((err) => {
            res.status(500).json({ error: err.message });
        });
});

// Get a user by ID
app.get('/api/users/:id', (req, res) => {
    const userId = req.params.id;

    User.findById(userId)
        .then((user) => {
            if (!user) {
                return res.status(404).json({ message: 'User not found' });
            }
            res.json(user);
        })
        .catch((err) => {
            res.status(500).json({ error: err.message });
        });
});
```

### C. Update Operation

The Update operation modifies existing documents in the database.

```javascript
// Update a user by ID
app.put('/api/users/:id', (req, res) => {
    const userId = req.params.id;

    User.findByIdAndUpdate(userId, req.body, { new: true, runValidators: true })
        .then((user) => {
            if (!user) {
                return res.status(404).json({ message: 'User not found' });
            }
            res.json({ message: 'User updated successfully!', user });
        })
        .catch((err) => {
            res.status(400).json({ error: err.message });
        });
});
```

### D. Delete Operation

The Delete operation removes documents from the database.

```javascript
// Delete a user by ID
app.delete('/api/users/:id', (req, res) => {
    const userId = req.params.id;

    User.findByIdAndDelete(userId)
        .then((user) => {
            if (!user) {
                return res.status(404).json({ message: 'User not found' });
            }
            res.json({ message: 'User deleted successfully!' });
        })
        .catch((err) => {
            res.status(500).json({ error: err.message });
        });
});
```

## 4. Complete Code Example

Here’s the complete code for `app.js` that implements CRUD operations with MongoDB:

```javascript
const express = require('express');
const mongoose = require('mongoose');

const app = express();
const PORT = 3000;

// Middleware to parse JSON request bodies
app.use(express.json());

// Connect to MongoDB
const dbURI = 'mongodb://localhost:27017/crud_example';
mongoose.connect(dbURI, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => console.log('Connected to MongoDB successfully!'))
    .catch((err) => console.error('MongoDB connection error:', err));

// Define a schema for a User
const userSchema = new mongoose.Schema({
    name: { type: String, required: true },
    age: { type: Number, required: true, min: 0 },
    email: { type: String, required: true, unique: true },
});

// Create a model based on the schema
const User = mongoose.model('User', userSchema);

// Create a new user
app.post('/api/users', (req, res) => {
    const newUser = new User(req.body);

    newUser.save()
        .then((user) => {
            res.status(201).json({ message: 'User created successfully!', user });
        })
        .catch((err) => {
            res.status(400).json({ error: err.message });
        });
});

// Get all users
app.get('/api/users', (req, res) => {
    User.find()
        .then((users) => {
            res.json(users);
        })
        .catch((err) => {
            res.status(500).json({ error: err.message });
        });
});

// Get a user by ID
app.get('/api/users/:id', (req, res) => {
    const userId = req.params.id;

    User.findById(userId)
        .then((user) => {
            if (!user) {
                return res.status(404).json({ message: 'User not found' });
            }
            res.json(user);
        })
        .catch((err) => {
            res.status(500).json({ error: err.message });
        });
});

// Update a user by ID
app.put('/api/users/:id', (req, res) => {
    const userId = req.params.id;

    User.findByIdAndUpdate(userId, req.body, { new: true, runValidators: true })
        .then((user) => {
            if (!user) {
                return res.status(404).json({ message: 'User not found' });
            }
            res.json({ message: 'User updated successfully!', user });
        })
        .catch((err) => {
            res.status(400).json({ error: err.message });
        });
});

// Delete a user by ID
app.delete('/api/users/:id', (req, res) => {
    const userId = req.params.id;

    User.findByIdAndDelete(userId)
        .then((user) => {
            if (!user) {
                return res.status(404).json({ message: 'User not found' });
            }
            res.json({ message: 'User deleted successfully!' });
        })
        .catch((err) => {
            res.status(500).json({ error: err.message });
        });
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}/`);
});
```

## Conclusion

In this lesson, you learned how to implement CRUD operations (Create, Read, Update, Delete) using Mongoose with MongoDB. You also learned how to structure and validate data models using Mongoose schemas. Understanding these operations is essential for building data-driven applications. In the next lesson, we will explore how to handle user authentication in your application.

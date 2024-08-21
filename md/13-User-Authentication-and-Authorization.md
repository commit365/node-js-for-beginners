# Lesson 13: User Authentication and Authorization

## Objectives
By the end of this lesson, you will:
- Understand the concepts of user authentication and session management.
- Implement JWT (JSON Web Tokens) for secure user authentication.

## Introduction to User Authentication and Authorization

### User Authentication

**Authentication** is the process of verifying the identity of a user. It ensures that users are who they claim to be. Common methods of authentication include:

- **Username and Password:** The most common method where users provide credentials to access their accounts.
- **OAuth:** A protocol that allows users to authenticate using third-party services (e.g., Google, Facebook).

### User Authorization

**Authorization** determines what an authenticated user is allowed to do. It controls access to resources based on user roles or permissions. For example, an admin user may have access to certain routes or data that regular users do not.

### Session Management

Session management is the process of maintaining user sessions after authentication. It typically involves:

- **Session Cookies:** Storing session identifiers in cookies to track user sessions.
- **Token-Based Authentication:** Using tokens (like JWT) to manage user sessions without storing session data on the server.

## 1. Setting Up Your Express Application

If you haven't already, create a new directory for this lesson and set up a basic Express application with MongoDB:

1. **Create a New Directory:**
   ```bash
   mkdir auth-app
   cd auth-app
   ```

2. **Initialize npm:**
   ```bash
   npm init -y
   ```

3. **Install Required Packages:**
   ```bash
   npm install express mongoose bcryptjs jsonwebtoken dotenv
   ```

   - **bcryptjs:** For hashing passwords.
   - **jsonwebtoken:** For creating and verifying JWTs.
   - **dotenv:** For managing environment variables.

4. **Create the `app.js` File:**
   ```bash
   touch app.js
   ```

### Step 1: Set Up Express and Mongoose

Open `app.js` in your code editor and add the following code to set up the server and connect to MongoDB:

```javascript
const express = require('express');
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
require('dotenv').config();

const app = express();
const PORT = 3000;

// Middleware to parse JSON request bodies
app.use(express.json());

// Connect to MongoDB
const dbURI = 'mongodb://localhost:27017/auth_example';
mongoose.connect(dbURI, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => console.log('Connected to MongoDB successfully!'))
    .catch((err) => console.error('MongoDB connection error:', err));
```

## 2. Defining User Schema and Model

### Step 2: Create a User Model

Define a Mongoose schema for the user, including fields for the username and password.

```javascript
// Define a schema for a User
const userSchema = new mongoose.Schema({
    username: { type: String, required: true, unique: true },
    password: { type: String, required: true },
});

// Create a model based on the schema
const User = mongoose.model('User', userSchema);
```

## 3. Implementing User Registration

### Step 3: Create a Registration Route

Add a route to register a new user. This route will hash the password before saving it to the database.

```javascript
app.post('/api/register', async (req, res) => {
    const { username, password } = req.body;

    // Check if the user already exists
    const existingUser = await User.findOne({ username });
    if (existingUser) {
        return res.status(400).json({ message: 'User already exists' });
    }

    // Hash the password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Create a new user
    const newUser = new User({ username, password: hashedPassword });
    await newUser.save();

    res.status(201).json({ message: 'User registered successfully!' });
});
```

## 4. Implementing User Login

### Step 4: Create a Login Route

Add a route to log in a user. This route will verify the password and generate a JWT if the credentials are valid.

```javascript
app.post('/api/login', async (req, res) => {
    const { username, password } = req.body;

    // Find the user by username
    const user = await User.findOne({ username });
    if (!user) {
        return res.status(400).json({ message: 'Invalid credentials' });
    }

    // Verify the password
    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
        return res.status(400).json({ message: 'Invalid credentials' });
    }

    // Generate a JWT
    const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, { expiresIn: '1h' });

    res.json({ message: 'Login successful!', token });
});
```

## 5. Protecting Routes with JWT

### Step 5: Create Middleware to Protect Routes

Add middleware to verify the JWT and protect certain routes.

```javascript
const authenticateJWT = (req, res, next) => {
    const token = req.headers['authorization']?.split(' ')[1]; // Get token from the Authorization header

    if (!token) {
        return res.sendStatus(403); // Forbidden
    }

    jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
        if (err) {
            return res.sendStatus(403); // Forbidden
        }
        req.user = user; // Attach user information to the request
        next(); // Proceed to the next middleware or route handler
    });
};
```

### Step 6: Create a Protected Route

Add a protected route that requires authentication.

```javascript
app.get('/api/protected', authenticateJWT, (req, res) => {
    res.json({ message: 'This is a protected route!', user: req.user });
});
```

## 6. Complete Code Example

Here’s the complete code for `app.js` that implements user authentication and authorization:

```javascript
const express = require('express');
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
require('dotenv').config();

const app = express();
const PORT = 3000;

// Middleware to parse JSON request bodies
app.use(express.json());

// Connect to MongoDB
const dbURI = 'mongodb://localhost:27017/auth_example';
mongoose.connect(dbURI, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => console.log('Connected to MongoDB successfully!'))
    .catch((err) => console.error('MongoDB connection error:', err));

// Define a schema for a User
const userSchema = new mongoose.Schema({
    username: { type: String, required: true, unique: true },
    password: { type: String, required: true },
});

// Create a model based on the schema
const User = mongoose.model('User', userSchema);

// User registration route
app.post('/api/register', async (req, res) => {
    const { username, password } = req.body;

    const existingUser = await User.findOne({ username });
    if (existingUser) {
        return res.status(400).json({ message: 'User already exists' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    const newUser = new User({ username, password: hashedPassword });
    await newUser.save();

    res.status(201).json({ message: 'User registered successfully!' });
});

// User login route
app.post('/api/login', async (req, res) => {
    const { username, password } = req.body;

    const user = await User.findOne({ username });
    if (!user) {
        return res.status(400).json({ message: 'Invalid credentials' });
    }

    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
        return res.status(400).json({ message: 'Invalid credentials' });
    }

    const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, { expiresIn: '1h' });
    res.json({ message: 'Login successful!', token });
});

// Middleware to protect routes
const authenticateJWT = (req, res, next) => {
    const token = req.headers['authorization']?.split(' ')[1];

    if (!token) {
        return res.sendStatus(403); // Forbidden
    }

    jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
        if (err) {
            return res.sendStatus(403); // Forbidden
        }
        req.user = user;
        next();
    });
};

// Protected route
app.get('/api/protected', authenticateJWT, (req, res) => {
    res.json({ message: 'This is a protected route!', user: req.user });
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}/`);
});
```

## Conclusion

In this lesson, you learned about user authentication and authorization, including how to implement JWT for secure user authentication. You also created routes for user registration and login, and protected routes using middleware. Understanding these concepts is essential for building secure applications. In the next lesson, we will explore how to handle file uploads and serve static files.

# Lesson 8: Handling HTTP Requests and Responses

## Objectives
By the end of this lesson, you will:
- Learn about different HTTP methods (GET, POST, PUT, DELETE).
- Understand how to handle request parameters and query strings in Express.js.

## Introduction to HTTP Methods

HTTP (Hypertext Transfer Protocol) is the foundation of data communication on the web. Different HTTP methods are used to perform various actions on resources. The most commonly used methods are:

- **GET:** Retrieve data from the server.
- **POST:** Send data to the server to create a new resource.
- **PUT:** Update an existing resource on the server.
- **DELETE:** Remove a resource from the server.

## 1. Setting Up Your Express Application

### Step 1: Create a New Express Application

If you haven't already, create a new directory for this lesson and set up a basic Express application:

1. **Create a New Directory:**
   ```bash
   mkdir http-methods-app
   cd http-methods-app
   ```

2. **Initialize npm:**
   ```bash
   npm init -y
   ```

3. **Install Express:**
   ```bash
   npm install express
   ```

4. **Create the `app.js` File:**
   ```bash
   touch app.js
   ```

### Step 2: Write the Basic Express Server Code

Open `app.js` in your code editor and add the following code to set up the server:

```javascript
const express = require('express');
const app = express();
const PORT = 3000;

// Middleware to parse JSON request bodies
app.use(express.json());

// Start the server
app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}/`);
});
```

## 2. Handling Different HTTP Methods

### Handling GET Requests

GET requests are used to retrieve data. You can handle GET requests in Express using the `app.get()` method.

**Example:**
```javascript
app.get('/api/greet', (req, res) => {
    res.send('Hello, World!');
});
```

### Handling POST Requests

POST requests are used to send data to the server. You can handle POST requests using the `app.post()` method.

**Example:**
```javascript
app.post('/api/users', (req, res) => {
    const newUser = req.body; // Access the request body
    // Here you would typically save the user to a database
    res.status(201).send(`User created: ${JSON.stringify(newUser)}`);
});
```

### Handling PUT Requests

PUT requests are used to update existing resources. You can handle PUT requests using the `app.put()` method.

**Example:**
```javascript
app.put('/api/users/:id', (req, res) => {
    const userId = req.params.id; // Access the request parameter
    const updatedUser = req.body; // Access the request body
    // Here you would typically update the user in the database
    res.send(`User with ID ${userId} updated: ${JSON.stringify(updatedUser)}`);
});
```

### Handling DELETE Requests

DELETE requests are used to remove resources. You can handle DELETE requests using the `app.delete()` method.

**Example:**
```javascript
app.delete('/api/users/:id', (req, res) => {
    const userId = req.params.id; // Access the request parameter
    // Here you would typically delete the user from the database
    res.send(`User with ID ${userId} deleted.`);
});
```

## 3. Handling Request Parameters and Query Strings

### Request Parameters

Request parameters are parts of the URL that can be used to identify specific resources. In Express, you can access parameters using `req.params`.

**Example:**
```javascript
app.get('/api/users/:id', (req, res) => {
    const userId = req.params.id; // Access the user ID from the URL
    res.send(`User ID: ${userId}`);
});
```

### Query Strings

Query strings are additional parameters added to the URL after the `?` symbol. You can access query strings using `req.query`.

**Example:**
```javascript
app.get('/api/search', (req, res) => {
    const searchTerm = req.query.q; // Access the query parameter 'q'
    res.send(`Searching for: ${searchTerm}`);
});
```

## 4. Putting It All Together

Here’s the complete code for `app.js` that includes handling different HTTP methods and request parameters/query strings:

```javascript
const express = require('express');
const app = express();
const PORT = 3000;

// Middleware to parse JSON request bodies
app.use(express.json());

// GET request
app.get('/api/greet', (req, res) => {
    res.send('Hello, World!');
});

// POST request
app.post('/api/users', (req, res) => {
    const newUser = req.body;
    res.status(201).send(`User created: ${JSON.stringify(newUser)}`);
});

// PUT request
app.put('/api/users/:id', (req, res) => {
    const userId = req.params.id;
    const updatedUser = req.body;
    res.send(`User with ID ${userId} updated: ${JSON.stringify(updatedUser)}`);
});

// DELETE request
app.delete('/api/users/:id', (req, res) => {
    const userId = req.params.id;
    res.send(`User with ID ${userId} deleted.`);
});

// GET request with query string
app.get('/api/search', (req, res) => {
    const searchTerm = req.query.q;
    res.send(`Searching for: ${searchTerm}`);
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}/`);
});
```

## Conclusion

In this lesson, you learned how to handle different HTTP methods (GET, POST, PUT, DELETE) in an Express application. You also explored how to handle request parameters and query strings. Understanding these concepts is crucial for building RESTful APIs and web applications. In the next lesson, we will dive into middleware and how to use it in Express.js.

# Lesson 10: Working with JSON and Data Formats

## Objectives
By the end of this lesson, you will:
- Understand JSON as a data format for APIs.
- Learn how to parse and send JSON data in Express.

## What is JSON?

**JSON** (JavaScript Object Notation) is a lightweight data interchange format that is easy for humans to read and write, and easy for machines to parse and generate. It is commonly used for transmitting data in web applications, especially in APIs.

### Key Features of JSON

- **Text-Based:** JSON is a text format that is completely language-independent.
- **Data Structures:** JSON supports various data structures, including objects (key-value pairs) and arrays (ordered lists).
- **Easy to Use:** JSON is easy to read and write, making it a popular choice for data interchange.

### JSON Example

Here’s a simple example of JSON data representing a user:

```json
{
    "name": "Alice",
    "age": 30,
    "email": "alice@example.com",
    "isActive": true,
    "skills": ["JavaScript", "Node.js", "Express"]
}
```

## 1. Working with JSON in Express

### Setting Up Your Express Application

If you haven’t already, create a new directory for this lesson and set up a basic Express application:

1. **Create a New Directory:**
   ```bash
   mkdir json-app
   cd json-app
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

## 2. Sending JSON Data

You can send JSON data in the response using the `res.json()` method. This method automatically sets the `Content-Type` header to `application/json`.

### Example: Sending JSON Response

Add a route to send a JSON response:

```javascript
app.get('/api/user', (req, res) => {
    const user = {
        name: 'Alice',
        age: 30,
        email: 'alice@example.com',
        isActive: true,
        skills: ['JavaScript', 'Node.js', 'Express']
    };
    res.json(user); // Send the user object as JSON
});
```

### Step 3: Test the JSON Response

1. **Run Your Application:**
   In your terminal, run:
   ```bash
   node app.js
   ```

2. **Access the JSON Endpoint:**
   Open your web browser or use a tool like Postman to navigate to `http://localhost:3000/api/user`. You should see the user data displayed in JSON format.

## 3. Parsing JSON Data

When you send JSON data in a request (e.g., from a client), you need to parse it on the server side. Express provides middleware to automatically parse JSON request bodies.

### Example: Parsing JSON Request Data

Add a route to handle POST requests that accept JSON data:

```javascript
app.post('/api/user', (req, res) => {
    const newUser = req.body; // Access the parsed JSON data from the request body
    console.log('Received user data:', newUser);
    res.status(201).json({ message: 'User created successfully!', user: newUser });
});
```

### Step 4: Test the JSON Parsing

1. **Use Postman or cURL to Send a POST Request:**
   - Set the request type to POST.
   - Set the URL to `http://localhost:3000/api/user`.
   - In the body, select "raw" and choose "JSON" from the dropdown. Then, enter the following JSON data:
   ```json
   {
       "name": "Bob",
       "age": 25,
       "email": "bob@example.com",
       "isActive": true,
       "skills": ["Python", "Django"]
   }
   ```

2. **Send the Request:**
   You should receive a response confirming that the user was created successfully, along with the user data you sent.

## 4. Complete Code Example

Here’s the complete code for `app.js` that includes sending and parsing JSON data:

```javascript
const express = require('express');
const app = express();
const PORT = 3000;

// Middleware to parse JSON request bodies
app.use(express.json());

// Endpoint to send JSON response
app.get('/api/user', (req, res) => {
    const user = {
        name: 'Alice',
        age: 30,
        email: 'alice@example.com',
        isActive: true,
        skills: ['JavaScript', 'Node.js', 'Express']
    };
    res.json(user);
});

// Endpoint to parse JSON request data
app.post('/api/user', (req, res) => {
    const newUser = req.body;
    console.log('Received user data:', newUser);
    res.status(201).json({ message: 'User created successfully!', user: newUser });
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}/`);
});
```

## Conclusion

In this lesson, you learned about JSON as a data format for APIs and how to parse and send JSON data in Express. Understanding how to work with JSON is essential for building modern web applications and APIs. In the next lesson, we will explore how to serve static files and use template engines in Express.

# Lesson 14: Error Handling and Debugging

## Objectives
By the end of this lesson, you will:
- Learn best practices for error handling in Node.js applications.
- Use debugging tools and techniques to troubleshoot issues.

## Introduction to Error Handling

Error handling is a critical aspect of building robust applications. It allows you to gracefully manage errors and provide meaningful feedback to users or developers. In Node.js, there are several strategies for handling errors effectively.

## 1. Best Practices for Error Handling

### A. Use Try-Catch Blocks

For synchronous code, you can use `try-catch` blocks to handle errors. This allows you to catch exceptions and respond appropriately.

**Example:**
```javascript
try {
    // Code that may throw an error
    const result = riskyOperation();
} catch (error) {
    console.error('An error occurred:', error.message);
}
```

### B. Handle Asynchronous Errors

For asynchronous code (like promises), use `.catch()` to handle errors.

**Example:**
```javascript
async function fetchData() {
    try {
        const data = await someAsyncOperation();
        console.log(data);
    } catch (error) {
        console.error('Error fetching data:', error.message);
    }
}
```

### C. Centralized Error Handling Middleware

In Express, you can create centralized error handling middleware to catch errors from all routes. This helps keep your code organized and makes it easier to manage error responses.

**Example:**
```javascript
// Error handling middleware
app.use((err, req, res, next) => {
    console.error(err.stack); // Log the error stack
    res.status(500).json({ error: 'Something went wrong!' }); // Send a generic error response
});
```

### D. Use HTTP Status Codes

When sending error responses, use appropriate HTTP status codes to indicate the type of error.

- **400 Bad Request:** The request was invalid.
- **401 Unauthorized:** Authentication failed.
- **403 Forbidden:** The user does not have permission.
- **404 Not Found:** The requested resource was not found.
- **500 Internal Server Error:** A generic server error occurred.

## 2. Implementing Error Handling in Your Application

### Step 1: Update Your Express Application

If you have an existing Express application, add error handling middleware. Here’s an example of how to implement error handling in your `app.js` file:

```javascript
const express = require('express');
const app = express();
const PORT = 3000;

// Middleware to parse JSON request bodies
app.use(express.json());

// Sample route that may throw an error
app.get('/api/data', (req, res) => {
    throw new Error('Something went wrong!'); // Simulate an error
});

// Centralized error handling middleware
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).json({ error: 'Something went wrong!' });
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}/`);
});
```

## 3. Debugging Tools and Techniques

Debugging is the process of identifying and fixing issues in your code. Here are some tools and techniques to help you debug your Node.js applications effectively.

### A. Console Logging

Using `console.log()` is a simple and effective way to debug your application. You can log variable values, function calls, and error messages to understand what’s happening in your code.

**Example:**
```javascript
console.log('Debugging value:', someVariable);
```

### B. Node.js Debugger

Node.js comes with a built-in debugger that allows you to set breakpoints and step through your code. To use the debugger, run your application with the `--inspect` flag:

```bash
node --inspect app.js
```

You can then open Chrome and navigate to `chrome://inspect` to connect to the debugger.

### C. Integrated Development Environment (IDE)

Many modern IDEs, such as Visual Studio Code, offer built-in debugging tools. You can set breakpoints, inspect variables, and step through your code directly from the IDE.

1. **Open your project in Visual Studio Code.**
2. **Go to the Run and Debug view (Ctrl + Shift + D).**
3. **Click on "create a launch.json file" and select Node.js.**
4. **Set breakpoints in your code by clicking next to the line numbers.**
5. **Start debugging by clicking the green play button.**

### D. Debugging with Nodemon

If you are using Nodemon for development, you can enable debugging by running:

```bash
nodemon --inspect app.js
```

This allows you to automatically restart your application while debugging.

## Conclusion

In this lesson, you learned best practices for error handling in Node.js applications, including using try-catch blocks, handling asynchronous errors, and creating centralized error handling middleware. You also explored debugging tools and techniques, such as console logging, the Node.js debugger, and IDE debugging features. Effective error handling and debugging are essential for building reliable applications. In the next lesson, we will explore how to serve static files and use template engines in Express.

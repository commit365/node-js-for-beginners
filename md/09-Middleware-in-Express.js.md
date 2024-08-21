# Lesson 9: Middleware in Express.js

## Objectives
By the end of this lesson, you will:
- Explore what middleware is and how it works in Express.
- Implement custom middleware for logging, authentication, and error handling.

## What is Middleware?

Middleware in Express.js refers to functions that execute during the request-response cycle. They have access to the request object (`req`), the response object (`res`), and the next middleware function in the application’s request-response cycle. Middleware can perform a variety of tasks, such as:

- Executing code
- Modifying the request and response objects
- Ending the request-response cycle
- Calling the next middleware function in the stack

## 1. How Middleware Works in Express

Middleware functions are executed in the order they are defined in the application. You can use middleware for various purposes, including logging requests, handling authentication, and managing errors.

### Basic Middleware Example

Here’s a simple example of how to create and use middleware in an Express application:

```javascript
const express = require('express');
const app = express();
const PORT = 3000;

// Basic middleware function
const myMiddleware = (req, res, next) => {
    console.log(`Request Method: ${req.method}, Request URL: ${req.url}`);
    next(); // Call the next middleware or route handler
};

// Use the middleware
app.use(myMiddleware);

// Define a route
app.get('/', (req, res) => {
    res.send('Hello, Middleware!');
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}/`);
});
```

In this example, `myMiddleware` logs the request method and URL for every incoming request. The `next()` function is called to pass control to the next middleware or route handler.

## 2. Implementing Custom Middleware

### A. Logging Middleware

Let’s create a logging middleware that logs details about each request.

```javascript
const loggingMiddleware = (req, res, next) => {
    const currentDateTime = new Date().toISOString();
    console.log(`[${currentDateTime}] ${req.method} ${req.url}`);
    next();
};

// Use the logging middleware
app.use(loggingMiddleware);
```

### B. Authentication Middleware

You can create middleware to check if a user is authenticated before allowing access to certain routes.

```javascript
const authenticationMiddleware = (req, res, next) => {
    const isAuthenticated = true; // Replace with actual authentication logic

    if (isAuthenticated) {
        next(); // User is authenticated, proceed to the next middleware or route
    } else {
        res.status(401).send('Unauthorized: Access is denied.');
    }
};

// Protect a route with authentication middleware
app.get('/protected', authenticationMiddleware, (req, res) => {
    res.send('This is a protected route.');
});
```

### C. Error Handling Middleware

Error handling middleware is defined with four parameters: `err`, `req`, `res`, and `next`. This middleware is called whenever an error occurs in the application.

```javascript
const errorHandlingMiddleware = (err, req, res, next) => {
    console.error(err.stack); // Log the error stack
    res.status(500).send('Something went wrong!'); // Send a generic error response
};

// Use the error handling middleware
app.use(errorHandlingMiddleware);
```

## 3. Putting It All Together

Here’s the complete code for `app.js` that includes logging, authentication, and error handling middleware:

```javascript
const express = require('express');
const app = express();
const PORT = 3000;

// Logging middleware
const loggingMiddleware = (req, res, next) => {
    const currentDateTime = new Date().toISOString();
    console.log(`[${currentDateTime}] ${req.method} ${req.url}`);
    next();
};

// Authentication middleware
const authenticationMiddleware = (req, res, next) => {
    const isAuthenticated = true; // Replace with actual authentication logic

    if (isAuthenticated) {
        next();
    } else {
        res.status(401).send('Unauthorized: Access is denied.');
    }
};

// Error handling middleware
const errorHandlingMiddleware = (err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Something went wrong!');
};

// Use middleware
app.use(loggingMiddleware);

// Define routes
app.get('/', (req, res) => {
    res.send('Hello, Middleware!');
});

app.get('/protected', authenticationMiddleware, (req, res) => {
    res.send('This is a protected route.');
});

// Simulate an error
app.get('/error', (req, res) => {
    throw new Error('This is a simulated error.');
});

// Use error handling middleware
app.use(errorHandlingMiddleware);

// Start the server
app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}/`);
});
```

## Conclusion

In this lesson, you explored what middleware is in Express.js and how it works within the request-response cycle. You implemented custom middleware for logging requests, handling authentication, and managing errors. Understanding middleware is essential for building robust and maintainable Express applications. In the next lesson, we will explore working with templates and serving static files.

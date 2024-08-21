# Lesson 7: Introduction to Express.js

## Objectives
By the end of this lesson, you will:
- Understand the basics of Express.js and its role in building web applications.
- Create a simple Express server and define routes.

## What is Express.js?

Express.js is a fast, minimalist web framework for Node.js that simplifies the process of building web applications and APIs. It provides a robust set of features for web and mobile applications, making it easier to handle routing, middleware, and HTTP requests.

### Key Features of Express.js

- **Routing:** Easily define routes for handling different HTTP requests (GET, POST, etc.).
- **Middleware:** Use middleware functions to process requests before they reach your route handlers.
- **Flexibility:** Integrate with various templating engines, databases, and other middleware packages.
- **Performance:** Built on top of Node.js, it is lightweight and efficient.

## 1. Setting Up Your Express Application

### Step 1: Install Express

If you haven’t done so already, create a new directory for your Express application and initialize it with npm:

1. **Create a New Directory:**
   ```bash
   mkdir express-app
   cd express-app
   ```

2. **Initialize npm:**
   ```bash
   npm init -y
   ```

3. **Install Express:**
   ```bash
   npm install express
   ```

### Step 2: Create the Express Server

1. **Create a New File:**
   Create a file named `app.js` in your project directory:
   ```bash
   touch app.js
   ```

2. **Write the Basic Express Server Code:**
   Open `app.js` in your code editor and add the following code:
   ```javascript
   // Import the express module
   const express = require('express');
   const app = express(); // Create an Express application
   const PORT = 3000; // Define the port to listen on

   // Define a simple route
   app.get('/', (req, res) => {
       res.send('Hello, Express!');
   });

   // Start the server
   app.listen(PORT, () => {
       console.log(`Server running at http://localhost:${PORT}/`);
   });
   ```

### Step 3: Run Your Express Application

1. **Start the Server:**
   In your terminal, run:
   ```bash
   node app.js
   ```

2. **Access Your Application:**
   Open your web browser and navigate to `http://localhost:3000/`. You should see the message "Hello, Express!" displayed in your browser.

## 2. Defining Routes in Express

### What are Routes?

Routes are used to define how your application responds to client requests for specific endpoints (URLs). In Express, you can define routes for different HTTP methods (GET, POST, PUT, DELETE).

### Defining Additional Routes

Let’s add more routes to our Express application:

1. **Modify `app.js` to Include More Routes:**
   Update your `app.js` file with additional routes:
   ```javascript
   // Import the express module
   const express = require('express');
   const app = express(); // Create an Express application
   const PORT = 3000; // Define the port to listen on

   // Define the home route
   app.get('/', (req, res) => {
       res.send('Hello, Express!');
   });

   // Define an about route
   app.get('/about', (req, res) => {
       res.send('This is the About page.');
   });

   // Define a contact route
   app.get('/contact', (req, res) => {
       res.send('This is the Contact page.');
   });

   // Start the server
   app.listen(PORT, () => {
       console.log(`Server running at http://localhost:${PORT}/`);
   });
   ```

2. **Run Your Application Again:**
   If your server is still running, you can refresh your browser. If not, start it again with:
   ```bash
   node app.js
   ```

3. **Access the New Routes:**
   - Navigate to `http://localhost:3000/about` to see the About page.
   - Navigate to `http://localhost:3000/contact` to see the Contact page.

## Conclusion

In this lesson, you learned the basics of Express.js and its role in building web applications. You created a simple Express server, defined routes, and handled different HTTP requests. In the next lesson, we will explore how to handle HTTP requests and responses in more detail, including working with request parameters and query strings.

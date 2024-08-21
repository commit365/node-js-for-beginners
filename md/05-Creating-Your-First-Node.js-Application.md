# Lesson 5: Creating Your First Node.js Application

## Objectives
By the end of this lesson, you will:
- Build a simple "Hello World" application using Node.js.
- Understand the structure of a Node.js application.

## Introduction

Now that you have a basic understanding of Node.js architecture, it’s time to create your first application! In this lesson, we will build a simple "Hello World" application and explore the structure of a Node.js application.

## 1. Building a Simple "Hello World" Application

### Step 1: Set Up Your Project

1. **Create a New Directory:**
   Open your terminal and create a new directory for your project:
   ```bash
   mkdir hello-world
   cd hello-world
   ```

2. **Initialize a New Node.js Project:**
   Use npm to create a `package.json` file, which will manage your project's dependencies and metadata:
   ```bash
   npm init -y
   ```
   The `-y` flag automatically answers "yes" to all prompts, creating a default `package.json` file.

### Step 2: Create the Application File

1. **Create a New JavaScript File:**
   Create a new file named `app.js` in the `hello-world` directory:
   ```bash
   touch app.js
   ```

2. **Write the "Hello World" Code:**
   Open `app.js` in your code editor (e.g., Visual Studio Code) and add the following code:
   ```javascript
   // Import the http module
   const http = require('http');

   // Create an HTTP server
   const server = http.createServer((req, res) => {
       res.statusCode = 200; // Set the response status code to 200 (OK)
       res.setHeader('Content-Type', 'text/plain'); // Set the content type to plain text
       res.end('Hello, World!\n'); // Send the response
   });

   // Define the port to listen on
   const PORT = 3000;

   // Start the server
   server.listen(PORT, () => {
       console.log(`Server running at http://localhost:${PORT}/`);
   });
   ```

### Step 3: Run Your Application

1. **Start the Server:**
   In your terminal, run the application using Node.js:
   ```bash
   node app.js
   ```

2. **Access Your Application:**
   Open your web browser and navigate to `http://localhost:3000/`. You should see the message "Hello, World!" displayed in your browser.

3. **Stop the Server:**
   To stop the server, return to your terminal and press `Ctrl + C`.

## 2. Understanding the Structure of a Node.js Application

### Key Components

1. **Entry Point:**
   - The entry point of a Node.js application is typically a JavaScript file (e.g., `app.js` or `server.js`) where the application starts executing.
   - In our example, `app.js` is the entry point that initializes the server.

2. **Modules:**
   - Node.js uses a modular architecture, allowing you to break your application into reusable components.
   - You can import built-in modules (like `http`) or create your own modules to organize your code.

3. **Package.json:**
   - The `package.json` file contains metadata about your project, including its name, version, description, and dependencies.
   - It is automatically created when you run `npm init`.

4. **Dependencies:**
   - As your application grows, you may need to install external libraries or frameworks. You can do this using npm, and they will be listed in your `package.json` file.

### Example Structure

Here’s what the structure of your `hello-world` application looks like:

```
hello-world/
├── app.js          # Your main application file
└── package.json    # Project metadata and dependencies
```

## Conclusion

Congratulations! You have successfully created your first Node.js application—a simple "Hello World" server. You also learned about the basic structure of a Node.js application, including the entry point, modules, and the `package.json` file. In the next lesson, we will explore how to work with npm and manage packages for your Node.js projects.

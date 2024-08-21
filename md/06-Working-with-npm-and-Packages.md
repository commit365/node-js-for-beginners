# Lesson 6: Working with npm and Packages

## Objectives
By the end of this lesson, you will:
- Learn how to use npm to manage dependencies.
- Explore popular Node.js packages such as Express and Nodemon.

## Introduction to npm

npm (Node Package Manager) is a powerful tool that comes with Node.js, allowing you to manage libraries and dependencies in your projects. It enables you to install, update, and remove packages easily.

## 1. Using npm to Manage Dependencies

### Initializing a Project

If you haven’t already, create a new project directory and initialize it with npm:

1. **Create a New Directory:**
   ```bash
   mkdir my-project
   cd my-project
   ```

2. **Initialize npm:**
   ```bash
   npm init -y
   ```
   This command creates a `package.json` file with default settings.

### Installing Packages

You can install packages from the npm registry using the following command:

```bash
npm install <package-name>
```

#### Example: Installing Express

Express is a popular web framework for Node.js that simplifies building web applications.

1. **Install Express:**
   ```bash
   npm install express
   ```

2. **Check Your `package.json`:**
   After installation, you will see Express listed under the `dependencies` section in your `package.json` file.

### Removing Packages

To remove a package, use the following command:

```bash
npm uninstall <package-name>
```

#### Example: Removing Express

If you want to remove Express from your project:

```bash
npm uninstall express
```

### Updating Packages

To update all your packages to their latest versions, run:

```bash
npm update
```

You can also update a specific package by specifying its name:

```bash
npm update <package-name>
```

## 2. Exploring Popular Node.js Packages

### Express

**Express** is a minimal and flexible Node.js web application framework that provides a robust set of features for building web and mobile applications.

#### Basic Example of Using Express

1. **Install Express:**
   ```bash
   npm install express
   ```

2. **Create a Simple Express Server:**
   Create a new file named `server.js` in your project directory and add the following code:
   ```javascript
   const express = require('express');
   const app = express();
   const PORT = 3000;

   app.get('/', (req, res) => {
       res.send('Hello, Express!');
   });

   app.listen(PORT, () => {
       console.log(`Server running at http://localhost:${PORT}/`);
   });
   ```

3. **Run the Server:**
   In your terminal, run:
   ```bash
   node server.js
   ```
   Open your browser and go to `http://localhost:3000/` to see the message "Hello, Express!".

### Nodemon

**Nodemon** is a utility that monitors for changes in your source code and automatically restarts your server when changes are detected. This is especially useful during development.

#### Installing Nodemon

1. **Install Nodemon Globally (optional):**
   You can install Nodemon globally so it can be used in any project:
   ```bash
   npm install -g nodemon
   ```

2. **Install Nodemon as a Development Dependency:**
   Alternatively, you can install it as a development dependency for your project:
   ```bash
   npm install --save-dev nodemon
   ```

#### Using Nodemon

1. **Run Your Application with Nodemon:**
   Instead of running your application with `node`, use:
   ```bash
   nodemon server.js
   ```
   Now, whenever you make changes to `server.js`, Nodemon will automatically restart the server for you.

## Conclusion

In this lesson, you learned how to use npm to manage dependencies in your Node.js projects. You explored popular packages like Express for building web applications and Nodemon for automatically restarting your server during development. In the next lesson, we will dive deeper into Express and learn how to handle HTTP requests and responses.

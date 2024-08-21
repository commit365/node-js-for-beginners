# Lesson 16: Testing Your Application

## Objectives
By the end of this lesson, you will:
- Understand the importance of testing and the basics of testing frameworks like Mocha and Chai.
- Write unit tests and integration tests for your application.

## Introduction to Testing

Testing is a crucial part of software development that helps ensure your application behaves as expected. It allows you to catch bugs early, improve code quality, and provide confidence when making changes to your codebase. There are two main types of tests:

- **Unit Tests:** Test individual components or functions in isolation to verify their correctness.
- **Integration Tests:** Test how different components work together, ensuring that they interact correctly.

## 1. Setting Up Your Testing Environment

### Step 1: Install Mocha and Chai

Mocha is a popular JavaScript testing framework, and Chai is an assertion library that works well with Mocha. To get started, you need to install these packages.

1. **Navigate to Your Project Directory:**
   If you haven’t already, navigate to your project directory (e.g., `books-api`).

2. **Install Mocha and Chai:**
   ```bash
   npm install --save-dev mocha chai
   ```

### Step 2: Configure Your Project for Testing

1. **Update `package.json`:**
   Add a test script to your `package.json` file to run Mocha easily. Open `package.json` and add the following line under `"scripts"`:
   ```json
   "scripts": {
       "test": "mocha"
   }
   ```

## 2. Writing Unit Tests

### Step 1: Create a Test Directory

Create a directory named `test` in your project to hold your test files:

```bash
mkdir test
```

### Step 2: Write a Unit Test

Let’s write a unit test for a simple function. For demonstration purposes, we will create a utility function to add two numbers.

1. **Create a Utility Function:**
   Create a file named `utils.js` in your project directory and add the following code:
   ```javascript
   // utils.js
   function add(a, b) {
       return a + b;
   }

   module.exports = { add };
   ```

2. **Create a Test File:**
   Create a file named `utils.test.js` in the `test` directory and add the following code:
   ```javascript
   // test/utils.test.js
   const { expect } = require('chai');
   const { add } = require('../utils');

   describe('Utility Functions', () => {
       describe('add()', () => {
           it('should return the sum of two numbers', () => {
               const result = add(2, 3);
               expect(result).to.equal(5);
           });

           it('should return a negative number when adding negative numbers', () => {
               const result = add(-2, -3);
               expect(result).to.equal(-5);
           });
       });
   });
   ```

### Step 3: Run Your Unit Tests

In your terminal, run the following command to execute your tests:

```bash
npm test
```

You should see output indicating that the tests have passed.

## 3. Writing Integration Tests

### Step 1: Create Integration Tests for Your API

Now, let’s write integration tests for the API endpoints we created in the previous lessons.

1. **Install Supertest:**
   Supertest is a library that allows you to test HTTP endpoints. Install it using the following command:
   ```bash
   npm install --save-dev supertest
   ```

2. **Create an Integration Test File:**
   Create a file named `api.test.js` in the `test` directory and add the following code:
   ```javascript
   // test/api.test.js
   const request = require('supertest');
   const { expect } = require('chai');
   const app = require('../app'); // Import your Express app

   describe('Books API', () => {
       it('should create a new book', async () => {
           const response = await request(app)
               .post('/api/books')
               .send({ title: '1984', author: 'George Orwell', publishedYear: 1949 });

           expect(response.status).to.equal(201);
           expect(response.body.message).to.equal('Book created successfully!');
           expect(response.body.book).to.have.property('_id');
       });

       it('should retrieve all books', async () => {
           const response = await request(app).get('/api/books');

           expect(response.status).to.equal(200);
           expect(response.body).to.be.an('array');
       });

       it('should retrieve a book by ID', async () => {
           const bookResponse = await request(app)
               .post('/api/books')
               .send({ title: 'Brave New World', author: 'Aldous Huxley', publishedYear: 1932 });

           const bookId = bookResponse.body.book._id;

           const response = await request(app).get(`/api/books/${bookId}`);
           expect(response.status).to.equal(200);
           expect(response.body.title).to.equal('Brave New World');
       });

       it('should update a book by ID', async () => {
           const bookResponse = await request(app)
               .post('/api/books')
               .send({ title: 'Fahrenheit 451', author: 'Ray Bradbury', publishedYear: 1953 });

           const bookId = bookResponse.body.book._id;

           const response = await request(app)
               .put(`/api/books/${bookId}`)
               .send({ title: 'Fahrenheit 451 (Updated)' });

           expect(response.status).to.equal(200);
           expect(response.body.message).to.equal('Book updated successfully!');
           expect(response.body.book.title).to.equal('Fahrenheit 451 (Updated)');
       });

       it('should delete a book by ID', async () => {
           const bookResponse = await request(app)
               .post('/api/books')
               .send({ title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', publishedYear: 1925 });

           const bookId = bookResponse.body.book._id;

           const response = await request(app).delete(`/api/books/${bookId}`);
           expect(response.status).to.equal(200);
           expect(response.body.message).to.equal('Book deleted successfully!');
       });
   });
   ```

### Step 2: Run Your Integration Tests

In your terminal, run the following command to execute your integration tests:

```bash
npm test
```

You should see output indicating that the tests have passed.

## Conclusion

In this lesson, you learned about the importance of testing in software development and how to use testing frameworks like Mocha and Chai. You wrote unit tests for utility functions and integration tests for your RESTful API endpoints. Testing is essential for maintaining code quality and ensuring that your application behaves as expected. In the next lesson, we will explore how to handle file uploads and serve static files in Express.

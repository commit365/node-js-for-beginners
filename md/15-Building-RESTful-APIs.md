# Lesson 15: Building RESTful APIs

## Objectives
By the end of this lesson, you will:
- Understand REST principles and design a RESTful API.
- Implement API endpoints for a sample application.

## Introduction to REST

**REST** (Representational State Transfer) is an architectural style for designing networked applications. It relies on a stateless, client-server communication model and uses standard HTTP methods for operations. RESTful APIs are widely used in web development to enable communication between clients and servers.

### Key Principles of REST

1. **Statelessness:** Each request from the client to the server must contain all the information needed to understand and process the request. The server does not store client context between requests.

2. **Resource-Based:** REST is centered around resources, which can be represented in various formats (e.g., JSON, XML). Each resource is identified by a unique URL.

3. **HTTP Methods:** RESTful APIs use standard HTTP methods to perform operations on resources:
   - **GET:** Retrieve a resource.
   - **POST:** Create a new resource.
   - **PUT:** Update an existing resource.
   - **DELETE:** Remove a resource.

4. **Stateless Communication:** Each request is independent, and the server does not retain session information.

## 1. Designing a RESTful API

### Step 1: Define Resources

For this lesson, let’s create a simple RESTful API for managing a collection of books. The resources we will work with are:

- **Books:** Each book will have attributes like `id`, `title`, `author`, and `publishedYear`.

### Step 2: Define API Endpoints

Here are the API endpoints we will implement:

- **GET /api/books:** Retrieve a list of all books.
- **GET /api/books/:id:** Retrieve a specific book by ID.
- **POST /api/books:** Create a new book.
- **PUT /api/books/:id:** Update an existing book by ID.
- **DELETE /api/books/:id:** Delete a book by ID.

## 2. Implementing API Endpoints

### Step 1: Set Up Your Express Application

If you haven't already, create a new directory for this lesson and set up a basic Express application with MongoDB:

1. **Create a New Directory:**
   ```bash
   mkdir books-api
   cd books-api
   ```

2. **Initialize npm:**
   ```bash
   npm init -y
   ```

3. **Install Required Packages:**
   ```bash
   npm install express mongoose
   ```

4. **Create the `app.js` File:**
   ```bash
   touch app.js
   ```

### Step 2: Set Up Express and Mongoose

Open `app.js` in your code editor and add the following code to set up the server and connect to MongoDB:

```javascript
const express = require('express');
const mongoose = require('mongoose');

const app = express();
const PORT = 3000;

// Middleware to parse JSON request bodies
app.use(express.json());

// Connect to MongoDB
const dbURI = 'mongodb://localhost:27017/books_example';
mongoose.connect(dbURI, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => console.log('Connected to MongoDB successfully!'))
    .catch((err) => console.error('MongoDB connection error:', err));
```

### Step 3: Define the Book Schema and Model

Add the following code to define a Mongoose schema and model for the books:

```javascript
// Define a schema for a Book
const bookSchema = new mongoose.Schema({
    title: { type: String, required: true },
    author: { type: String, required: true },
    publishedYear: { type: Number, required: true },
});

// Create a model based on the schema
const Book = mongoose.model('Book', bookSchema);
```

### Step 4: Implement API Endpoints

Now, let’s implement the API endpoints defined earlier.

#### A. Get All Books

```javascript
// GET /api/books
app.get('/api/books', async (req, res) => {
    try {
        const books = await Book.find();
        res.json(books);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});
```

#### B. Get a Book by ID

```javascript
// GET /api/books/:id
app.get('/api/books/:id', async (req, res) => {
    const bookId = req.params.id;
    try {
        const book = await Book.findById(bookId);
        if (!book) {
            return res.status(404).json({ message: 'Book not found' });
        }
        res.json(book);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});
```

#### C. Create a New Book

```javascript
// POST /api/books
app.post('/api/books', async (req, res) => {
    const { title, author, publishedYear } = req.body;
    const newBook = new Book({ title, author, publishedYear });

    try {
        const savedBook = await newBook.save();
        res.status(201).json({ message: 'Book created successfully!', book: savedBook });
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
});
```

#### D. Update a Book by ID

```javascript
// PUT /api/books/:id
app.put('/api/books/:id', async (req, res) => {
    const bookId = req.params.id;
    const updates = req.body;

    try {
        const updatedBook = await Book.findByIdAndUpdate(bookId, updates, { new: true, runValidators: true });
        if (!updatedBook) {
            return res.status(404).json({ message: 'Book not found' });
        }
        res.json({ message: 'Book updated successfully!', book: updatedBook });
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
});
```

#### E. Delete a Book by ID

```javascript
// DELETE /api/books/:id
app.delete('/api/books/:id', async (req, res) => {
    const bookId = req.params.id;

    try {
        const deletedBook = await Book.findByIdAndDelete(bookId);
        if (!deletedBook) {
            return res.status(404).json({ message: 'Book not found' });
        }
        res.json({ message: 'Book deleted successfully!' });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});
```

### Step 5: Complete Code Example

Here’s the complete code for `app.js` that implements the RESTful API for managing books:

```javascript
const express = require('express');
const mongoose = require('mongoose');

const app = express();
const PORT = 3000;

// Middleware to parse JSON request bodies
app.use(express.json());

// Connect to MongoDB
const dbURI = 'mongodb://localhost:27017/books_example';
mongoose.connect(dbURI, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => console.log('Connected to MongoDB successfully!'))
    .catch((err) => console.error('MongoDB connection error:', err));

// Define a schema for a Book
const bookSchema = new mongoose.Schema({
    title: { type: String, required: true },
    author: { type: String, required: true },
    publishedYear: { type: Number, required: true },
});

// Create a model based on the schema
const Book = mongoose.model('Book', bookSchema);

// GET /api/books
app.get('/api/books', async (req, res) => {
    try {
        const books = await Book.find();
        res.json(books);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// GET /api/books/:id
app.get('/api/books/:id', async (req, res) => {
    const bookId = req.params.id;
    try {
        const book = await Book.findById(bookId);
        if (!book) {
            return res.status(404).json({ message: 'Book not found' });
        }
        res.json(book);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// POST /api/books
app.post('/api/books', async (req, res) => {
    const { title, author, publishedYear } = req.body;
    const newBook = new Book({ title, author, publishedYear });

    try {
        const savedBook = await newBook.save();
        res.status(201).json({ message: 'Book created successfully!', book: savedBook });
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
});

// PUT /api/books/:id
app.put('/api/books/:id', async (req, res) => {
    const bookId = req.params.id;
    const updates = req.body;

    try {
        const updatedBook = await Book.findByIdAndUpdate(bookId, updates, { new: true, runValidators: true });
        if (!updatedBook) {
            return res.status(404).json({ message: 'Book not found' });
        }
        res.json({ message: 'Book updated successfully!', book: updatedBook });
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
});

// DELETE /api/books/:id
app.delete('/api/books/:id', async (req, res) => {
    const bookId = req.params.id;

    try {
        const deletedBook = await Book.findByIdAndDelete(bookId);
        if (!deletedBook) {
            return res.status(404).json({ message: 'Book not found' });
        }
        res.json({ message: 'Book deleted successfully!' });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}/`);
});
```

## Conclusion

In this lesson, you learned about REST principles and how to design a RESTful API. You implemented API endpoints for managing a collection of books, including operations for creating, reading, updating, and deleting books. Understanding how to build RESTful APIs is essential for developing modern web applications. In the next lesson, we will explore how to handle file uploads and serve static files in Express.

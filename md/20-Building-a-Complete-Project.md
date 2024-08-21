# Lesson 20: Building a Complete Project

## Objectives
By the end of this lesson, you will:
- Combine all learned concepts to build a full-stack application.
- Focus on best practices in code organization and documentation.

## Introduction to Full-Stack Applications

A **full-stack application** consists of both the front end (client-side) and back end (server-side) components. In this lesson, we will build a simple full-stack application that allows users to create, read, update, and delete (CRUD) notes. We will use Node.js and Express for the back end, MongoDB for the database, and a basic HTML/CSS/JavaScript front end.

## 1. Project Setup

### Step 1: Create the Project Directory

Create a new directory for your project:

```bash
mkdir notes-app
cd notes-app
```

### Step 2: Initialize npm

Initialize a new Node.js project:

```bash
npm init -y
```

### Step 3: Install Required Packages

Install Express, Mongoose, and other necessary packages:

```bash
npm install express mongoose dotenv cors
```

- **dotenv:** For managing environment variables.
- **cors:** To enable Cross-Origin Resource Sharing for your API.

### Step 4: Create the Project Structure

Create the following directory structure:

```
notes-app/
├── server/
│   ├── models/
│   │   └── note.js
│   ├── routes/
│   │   └── notes.js
│   ├── .env
│   └── app.js
└── client/
    ├── index.html
    └── script.js
```

## 2. Back-End Development

### Step 1: Create the Note Model

In `server/models/note.js`, define the Mongoose schema for a note:

```javascript
const mongoose = require('mongoose');

const noteSchema = new mongoose.Schema({
    title: { type: String, required: true },
    content: { type: String, required: true },
});

const Note = mongoose.model('Note', noteSchema);
module.exports = Note;
```

### Step 2: Create the Notes Routes

In `server/routes/notes.js`, implement the CRUD routes for notes:

```javascript
const express = require('express');
const Note = require('../models/note');
const router = express.Router();

// Create a new note
router.post('/', async (req, res) => {
    const { title, content } = req.body;
    const newNote = new Note({ title, content });

    try {
        const savedNote = await newNote.save();
        res.status(201).json(savedNote);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
});

// Get all notes
router.get('/', async (req, res) => {
    try {
        const notes = await Note.find();
        res.json(notes);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Update a note by ID
router.put('/:id', async (req, res) => {
    const { title, content } = req.body;
    try {
        const updatedNote = await Note.findByIdAndUpdate(req.params.id, { title, content }, { new: true });
        if (!updatedNote) return res.status(404).json({ message: 'Note not found' });
        res.json(updatedNote);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
});

// Delete a note by ID
router.delete('/:id', async (req, res) => {
    try {
        const deletedNote = await Note.findByIdAndDelete(req.params.id);
        if (!deletedNote) return res.status(404).json({ message: 'Note not found' });
        res.json({ message: 'Note deleted successfully!' });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;
```

### Step 3: Set Up the Express Server

In `server/app.js`, set up the Express server and connect to MongoDB:

```javascript
const express = require('express');
const mongoose = require('mongoose');
const dotenv = require('dotenv');
const cors = require('cors');
const notesRoutes = require('./routes/notes');

dotenv.config();
const app = express();
const PORT = process.env.PORT || 5000;

// Middleware
app.use(cors());
app.use(express.json());

// Connect to MongoDB
mongoose.connect(process.env.MONGODB_URI, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => console.log('Connected to MongoDB successfully!'))
    .catch((err) => console.error('MongoDB connection error:', err));

// Routes
app.use('/api/notes', notesRoutes);

// Start the server
app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}/`);
});
```

### Step 4: Create the .env File

In `server/.env`, add your MongoDB connection string:

```plaintext
MONGODB_URI=mongodb://localhost:27017/notes_example
```

## 3. Front-End Development

### Step 1: Create the HTML File

In `client/index.html`, create a simple user interface for the notes application:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notes App</title>
    <style>
        body { font-family: Arial, sans-serif; }
        #notes { margin-top: 20px; }
        .note { margin-bottom: 10px; padding: 10px; border: 1px solid #ccc; }
    </style>
</head>
<body>
    <h1>Notes App</h1>
    <form id="noteForm">
        <input type="text" id="title" placeholder="Title" required />
        <textarea id="content" placeholder="Content" required></textarea>
        <button type="submit">Add Note</button>
    </form>
    <div id="notes"></div>

    <script src="script.js"></script>
</body>
</html>
```

### Step 2: Create the JavaScript File

In `client/script.js`, implement the functionality to create and display notes:

```javascript
const noteForm = document.getElementById('noteForm');
const notesDiv = document.getElementById('notes');

// Fetch notes from the server
async function fetchNotes() {
    const response = await fetch('http://localhost:5000/api/notes');
    const notes = await response.json();
    displayNotes(notes);
}

// Display notes in the UI
function displayNotes(notes) {
    notesDiv.innerHTML = '';
    notes.forEach(note => {
        const noteDiv = document.createElement('div');
        noteDiv.className = 'note';
        noteDiv.innerHTML = `<h3>${note.title}</h3><p>${note.content}</p>`;
        notesDiv.appendChild(noteDiv);
    });
}

// Add a new note
noteForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    const title = document.getElementById('title').value;
    const content = document.getElementById('content').value;

    await fetch('http://localhost:5000/api/notes', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ title, content }),
    });

    noteForm.reset(); // Clear the form
    fetchNotes(); // Refresh the notes list
});

// Initial fetch of notes
fetchNotes();
```

## 4. Best Practices in Code Organization and Documentation

### A. Code Organization

- **Modular Structure:** Organize your code into separate modules (e.g., models, routes, controllers) to improve maintainability.
- **Consistent Naming Conventions:** Use clear and consistent naming conventions for files and variables to enhance readability.

### B. Documentation

- **Comments:** Use comments to explain complex logic or important sections of your code.
- **README File:** Create a `README.md` file in your project root to describe the project, how to set it up, and how to use it.

**Example README:**

```markdown
# Notes App

A simple full-stack application for managing notes.

## Features

- Create, read, update, and delete notes.
- Real-time updates with a simple user interface.

## Technologies Used

- Node.js
- Express
- MongoDB
- Socket.io (for real-time communication)

## Getting Started

1. Clone the repository.
2. Install dependencies:
   ```bash
   npm install
   ```
3. Create a `.env` file with your MongoDB connection string.
4. Start the server:
   ```bash
   node server/app.js
   ```
5. Open `client/index.html` in your browser.

## License

This project is licensed under the MIT License.
```

## Conclusion

In this lesson, you combined all the concepts learned throughout the course to build a complete full-stack application. You set up a Node.js and Express back end with a MongoDB database, created a front-end interface using HTML and JavaScript, and focused on best practices in code organization and documentation. Building a complete project helps solidify your understanding of full-stack development and prepares you for real-world applications. In the next lesson, we will explore advanced topics in Node.js development.

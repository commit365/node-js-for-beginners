# Lesson 18: Introduction to WebSockets

## Objectives
By the end of this lesson, you will:
- Understand real-time communication and the WebSocket protocol.
- Implement a simple chat application using Socket.io.

## Introduction to WebSockets

**WebSockets** is a protocol that enables real-time, bidirectional communication between a client (usually a web browser) and a server. Unlike traditional HTTP requests, which are request-response based, WebSockets allow for persistent connections, enabling data to be sent and received in real-time.

### Key Features of WebSockets

- **Full-Duplex Communication:** Both the client and server can send messages to each other simultaneously.
- **Low Latency:** WebSockets reduce the overhead of establishing connections, allowing for faster data exchange.
- **Persistent Connection:** Once established, the connection remains open until either the client or server closes it.

## 1. Setting Up Your Chat Application

### Step 1: Create a New Directory

Create a new directory for your chat application:

```bash
mkdir websocket-chat
cd websocket-chat
```

### Step 2: Initialize npm

Initialize a new Node.js project:

```bash
npm init -y
```

### Step 3: Install Required Packages

Install Express and Socket.io:

```bash
npm install express socket.io
```

### Step 4: Create the Server

Create a new file named `app.js` in your project directory and set up a basic Express server with Socket.io:

```javascript
const express = require('express');
const http = require('http');
const socketIo = require('socket.io');

const app = express();
const server = http.createServer(app);
const io = socketIo(server);

const PORT = 3000;

// Serve the HTML file for the chat application
app.get('/', (req, res) => {
    res.sendFile(__dirname + '/index.html');
});

// Listen for incoming WebSocket connections
io.on('connection', (socket) => {
    console.log('A user connected');

    // Listen for chat messages
    socket.on('chat message', (msg) => {
        console.log('Message received: ' + msg);
        // Broadcast the message to all connected clients
        io.emit('chat message', msg);
    });

    // Handle disconnection
    socket.on('disconnect', () => {
        console.log('User disconnected');
    });
});

// Start the server
server.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}/`);
});
```

## 2. Creating the Client-Side Code

### Step 1: Create the HTML File

Create a file named `index.html` in your project directory and add the following code for the chat interface:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WebSocket Chat</title>
    <style>
        ul { list-style-type: none; padding: 0; }
        li { padding: 8px; margin-bottom: 10px; background-color: #f1f1f1; }
    </style>
</head>
<body>
    <h1>WebSocket Chat</h1>
    <ul id="messages"></ul>
    <form id="form" action="">
        <input id="input" autocomplete="off" /><button>Send</button>
    </form>

    <script src="/socket.io/socket.io.js"></script>
    <script>
        const socket = io();

        const form = document.getElementById('form');
        const input = document.getElementById('input');
        const messages = document.getElementById('messages');

        // Handle form submission
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            if (input.value) {
                socket.emit('chat message', input.value); // Send message to server
                input.value = '';
            }
        });

        // Listen for chat messages from the server
        socket.on('chat message', function(msg) {
            const item = document.createElement('li');
            item.textContent = msg; // Display the message
            messages.appendChild(item);
            window.scrollTo(0, document.body.scrollHeight); // Scroll to the bottom
        });
    </script>
</body>
</html>
```

## 3. Running the Chat Application

### Step 1: Start the Server

In your terminal, run the following command to start your server:

```bash
node app.js
```

### Step 2: Open the Chat Application

Open your web browser and navigate to `http://localhost:3000`. You should see the chat interface.

### Step 3: Test the Chat Functionality

1. Open multiple tabs or windows of your browser and navigate to the same URL.
2. Type a message in one tab and hit "Send." You should see the message appear in all connected clients in real-time.

## Conclusion

In this lesson, you learned about real-time communication using WebSockets and implemented a simple chat application using Socket.io. You set up an Express server, created a basic HTML interface, and enabled real-time messaging between clients. WebSockets are powerful for applications requiring instant updates, such as chat applications, notifications, and collaborative tools. In the next lesson, we will explore how to handle file uploads and serve static files in Express.

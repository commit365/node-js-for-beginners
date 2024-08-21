# Lesson 25: Asynchronous Programming in Depth

## Objectives
By the end of this lesson, you will:
- Explore advanced asynchronous patterns, including event emitters and streams.
- Understand how to manage concurrency and parallelism in Node.js.

## Introduction to Asynchronous Programming

Node.js is built on an asynchronous, non-blocking architecture, which allows it to handle multiple operations concurrently. Understanding advanced asynchronous patterns is crucial for building efficient and scalable applications.

## 1. Advanced Asynchronous Patterns

### A. Event Emitters

**Event Emitters** are a core part of Node.js, allowing you to create and manage events in your applications. They are used extensively in Node.js modules, such as the built-in `EventEmitter` class.

#### Step 1: Creating an Event Emitter

1. **Set Up Your Project:**

   Create a new directory for your event emitter example:

   ```bash
   mkdir event-emitter-example
   cd event-emitter-example
   ```

2. **Initialize npm:**

   ```bash
   npm init -y
   ```

3. **Create a File Named `app.js`:**

   In `app.js`, add the following code to create an event emitter:

   ```javascript
   const EventEmitter = require('events');

   // Create a new instance of EventEmitter
   const myEmitter = new EventEmitter();

   // Define an event listener
   myEmitter.on('event', () => {
       console.log('An event occurred!');
   });

   // Emit the event
   myEmitter.emit('event');
   ```

4. **Run the Application:**

   In your terminal, run:

   ```bash
   node app.js
   ```

   You should see the output: `An event occurred!`

#### Step 2: Passing Data with Events

You can also pass data when emitting events:

```javascript
const EventEmitter = require('events');
const myEmitter = new EventEmitter();

// Define an event listener that accepts data
myEmitter.on('greet', (name) => {
    console.log(`Hello, ${name}!`);
});

// Emit the event with data
myEmitter.emit('greet', 'Alice');
```

### B. Streams

**Streams** are a powerful way to handle reading and writing data in Node.js. They allow you to process data in chunks rather than loading it all into memory at once, making them ideal for handling large files or data sources.

#### Step 1: Creating a Readable Stream

1. **Create a File Named `stream-example.js`:**

   In `stream-example.js`, add the following code to create a readable stream:

   ```javascript
   const fs = require('fs');

   // Create a readable stream
   const readableStream = fs.createReadStream('input.txt', { encoding: 'utf8' });

   // Handle data event
   readableStream.on('data', (chunk) => {
       console.log('Received chunk:', chunk);
   });

   // Handle end event
   readableStream.on('end', () => {
       console.log('No more data.');
   });

   // Handle error event
   readableStream.on('error', (err) => {
       console.error('Error:', err);
   });
   ```

2. **Create an Input File:**

   Create a file named `input.txt` in the same directory and add some text to it.

3. **Run the Stream Example:**

   In your terminal, run:

   ```bash
   node stream-example.js
   ```

   You should see the chunks of data printed in the console.

#### Step 2: Creating a Writable Stream

You can also create writable streams to write data to files:

```javascript
const fs = require('fs');

// Create a writable stream
const writableStream = fs.createWriteStream('output.txt');

// Write data to the stream
writableStream.write('Hello, World!\n');
writableStream.write('This is a test.\n');

// End the stream
writableStream.end(() => {
    console.log('Finished writing to output.txt');
});
```

## 2. Managing Concurrency and Parallelism

### A. Concurrency

**Concurrency** in Node.js allows multiple operations to be in progress at the same time. However, due to its single-threaded nature, Node.js does not execute multiple operations simultaneously; instead, it uses an event loop to manage asynchronous operations.

### B. Parallelism

**Parallelism** involves executing multiple operations at the same time, which can be achieved in Node.js using worker threads or child processes.

#### Step 1: Using Worker Threads

1. **Install the Worker Threads Module:**

   Worker threads are included in Node.js by default (from version 10.5.0). You don’t need to install anything extra.

2. **Create a File Named `worker-example.js`:**

   In `worker-example.js`, add the following code:

   ```javascript
   const { Worker, isMainThread, parentPort } = require('worker_threads');

   if (isMainThread) {
       // This code will run in the main thread
       const worker = new Worker(__filename); // Create a new worker

       worker.on('message', (message) => {
           console.log('Received from worker:', message);
       });

       worker.postMessage('Hello, Worker!'); // Send a message to the worker
   } else {
       // This code will run in the worker thread
       parentPort.on('message', (message) => {
           console.log('Received from main thread:', message);
           parentPort.postMessage('Hello, Main Thread!'); // Send a message back
       });
   }
   ```

3. **Run the Worker Example:**

   In your terminal, run:

   ```bash
   node worker-example.js
   ```

   You should see messages exchanged between the main thread and the worker thread.

### C. Using Child Processes

You can also use the `child_process` module to run scripts in parallel:

```javascript
const { exec } = require('child_process');

exec('node someScript.js', (error, stdout, stderr) => {
    if (error) {
        console.error(`Error: ${error.message}`);
        return;
    }
    if (stderr) {
        console.error(`stderr: ${stderr}`);
        return;
    }
    console.log(`stdout: ${stdout}`);
});
```

## Conclusion

In this lesson, you explored advanced asynchronous patterns in Node.js, including event emitters and streams. You also learned how to manage concurrency and parallelism using worker threads and child processes. Mastering these concepts will help you build efficient and scalable applications. In the next lesson, we will explore advanced topics in Node.js development.

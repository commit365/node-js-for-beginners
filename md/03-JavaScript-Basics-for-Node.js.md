# Lesson 3: JavaScript Basics for Node.js

## Objectives
By the end of this lesson, you will:
- Review essential JavaScript concepts: variables, functions, and control structures.
- Learn about asynchronous programming, promises, and async/await.

## Introduction to JavaScript

JavaScript is a versatile programming language that is essential for back-end development with Node.js. Understanding JavaScript basics is crucial for writing effective Node.js applications.

## 1. Essential JavaScript Concepts

### Variables

Variables are used to store data values. In JavaScript, you can declare variables using `var`, `let`, or `const`.

- **`var`:** Function-scoped or globally scoped. It is generally not recommended for use in modern JavaScript due to its scope issues.
- **`let`:** Block-scoped variable declaration. Use `let` when you expect the variable value to change.
- **`const`:** Block-scoped variable declaration for constants. Use `const` when the variable value should not change.

**Example:**
```javascript
let name = "Alice"; // Can be changed
const age = 25;     // Cannot be changed
```

### Functions

Functions are reusable blocks of code that perform a specific task. You can define a function using the `function` keyword or with arrow function syntax.

**Function Declaration:**
```javascript
function greet(name) {
    return `Hello, ${name}!`;
}
```

**Arrow Function:**
```javascript
const greet = (name) => `Hello, ${name}!`;
```

### Control Structures

Control structures allow you to dictate the flow of your program. The most common control structures are conditional statements and loops.

#### Conditional Statements

- **`if` Statement:**
```javascript
if (age >= 18) {
    console.log("You are an adult.");
} else {
    console.log("You are a minor.");
}
```

- **`switch` Statement:**
```javascript
switch (day) {
    case 1:
        console.log("Monday");
        break;
    case 2:
        console.log("Tuesday");
        break;
    default:
        console.log("Another day");
}
```

#### Loops

- **`for` Loop:**
```javascript
for (let i = 0; i < 5; i++) {
    console.log(i);
}
```

- **`while` Loop:**
```javascript
let i = 0;
while (i < 5) {
    console.log(i);
    i++;
}
```

## 2. Asynchronous Programming in JavaScript

Asynchronous programming allows your code to run without blocking the execution of other code. This is particularly important in Node.js, where I/O operations (like reading files or making network requests) can take time.

### Callbacks

A callback is a function passed as an argument to another function. It is executed after the completion of that function.

**Example:**
```javascript
function fetchData(callback) {
    setTimeout(() => {
        const data = "Data received!";
        callback(data);
    }, 1000);
}

fetchData((data) => {
    console.log(data); // Outputs: Data received!
});
```

### Promises

A promise is an object representing the eventual completion (or failure) of an asynchronous operation. It can be in one of three states: pending, fulfilled, or rejected.

**Creating a Promise:**
```javascript
const myPromise = new Promise((resolve, reject) => {
    const success = true; // Simulating success or failure
    if (success) {
        resolve("Operation successful!");
    } else {
        reject("Operation failed.");
    }
});

// Consuming a Promise
myPromise
    .then((result) => {
        console.log(result); // Outputs: Operation successful!
    })
    .catch((error) => {
        console.error(error);
    });
```

### Async/Await

`async` and `await` are syntactic sugar built on top of promises, making asynchronous code easier to read and write.

**Using Async/Await:**
```javascript
const fetchData = () => {
    return new Promise((resolve) => {
        setTimeout(() => {
            resolve("Data received!");
        }, 1000);
    });
};

const getData = async () => {
    const data = await fetchData();
    console.log(data); // Outputs: Data received!
};

getData();
```

## Conclusion

In this lesson, you reviewed essential JavaScript concepts, including variables, functions, and control structures. You also learned about asynchronous programming, promises, and the `async/await` syntax. Mastering these concepts is crucial for effective back-end development with Node.js. In the next lesson, we will explore the architecture of Node.js and how it operates.

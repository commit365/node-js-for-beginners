# Lesson 23: API Documentation and Versioning

## Objectives
By the end of this lesson, you will:
- Understand the importance of API documentation.
- Learn how to document APIs using tools like Swagger or Postman.

## Introduction to API Documentation

**API documentation** is a technical content deliverable that describes the functionality of an API. It is essential for developers who use your API, as it provides the necessary information to understand how to interact with it effectively.

### Importance of API Documentation

1. **Improves Usability:** Well-documented APIs are easier to understand and use, leading to a better developer experience.
2. **Reduces Support Requests:** Clear documentation can reduce the number of questions and issues raised by users.
3. **Facilitates Collaboration:** Documentation helps teams work together by providing a reference point for API functionality.
4. **Encourages Adoption:** Comprehensive and user-friendly documentation can attract more developers to use your API.

## 1. Documenting APIs with Swagger

**Swagger** (now known as OpenAPI Specification) is a powerful tool for designing and documenting APIs. It provides a user-friendly interface for developers to explore and interact with your API.

### A. Setting Up Swagger in Your Node.js Application

#### Step 1: Install Swagger UI and Swagger JSDoc

You can integrate Swagger into your Node.js application using the following packages:

```bash
npm install swagger-ui-express swagger-jsdoc
```

#### Step 2: Create Swagger Configuration

In your `app.js` file, set up Swagger:

```javascript
const express = require('express');
const swaggerUi = require('swagger-ui-express');
const swaggerJsDoc = require('swagger-jsdoc');

const app = express();
const PORT = 3000;

// Swagger definition
const swaggerOptions = {
    swaggerDefinition: {
        openapi: '3.0.0',
        info: {
            title: 'Notes API',
            version: '1.0.0',
            description: 'API for managing notes',
        },
        servers: [
            {
                url: 'http://localhost:3000',
            },
        ],
    },
    apis: ['./routes/*.js'], // Path to the API docs
};

// Initialize Swagger JSDoc
const swaggerDocs = swaggerJsDoc(swaggerOptions);
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocs));

// Start the server
app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}/`);
});
```

### B. Documenting API Endpoints

You can document your API endpoints using JSDoc comments in your route files. For example, in `routes/notes.js`:

```javascript
/**
 * @swagger
 * /api/notes:
 *   get:
 *     summary: Retrieve a list of notes
 *     responses:
 *       200:
 *         description: A list of notes
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 *                 properties:
 *                   id:
 *                     type: string
 *                   title:
 *                     type: string
 *                   content:
 *                     type: string
 */
router.get('/', async (req, res) => {
    // Your code here
});
```

### C. Accessing the Swagger UI

After setting up Swagger, you can access the documentation by navigating to `http://localhost:3000/api-docs` in your browser. You will see an interactive API documentation interface.

## 2. Documenting APIs with Postman

**Postman** is another popular tool for API development and documentation. It allows you to create, test, and document APIs in one place.

### A. Setting Up Postman

1. **Download and Install Postman:** Visit [Postman](https://www.postman.com/downloads/) and download the application for your operating system.

2. **Create a New Collection:** In Postman, create a new collection to group your API requests.

3. **Add API Requests:** For each endpoint in your API, create a new request in the collection. Specify the request method (GET, POST, etc.) and the URL.

### B. Documenting Requests

1. **Add Descriptions:** For each request, add a description explaining what the request does, the parameters it accepts, and the expected response.

2. **Use Examples:** Postman allows you to add example responses, which can help users understand the API's behavior.

3. **Generate Documentation:** Once you have documented your requests, you can generate documentation directly from Postman. Go to the collection, click on the three dots, and select "View Documentation."

### C. Sharing Documentation

You can share your Postman documentation with others by generating a public link or exporting the documentation in various formats (HTML, Markdown, etc.).

## 3. API Versioning

API versioning is essential for maintaining backward compatibility when making changes to your API. It allows you to introduce new features or changes without breaking existing clients.

### A. Versioning Strategies

1. **URI Versioning:** Include the version number in the URL.
   - Example: `/api/v1/notes`

2. **Query Parameter Versioning:** Specify the version in the query string.
   - Example: `/api/notes?version=1`

3. **Header Versioning:** Use custom headers to specify the API version.
   - Example: `Accept: application/vnd.yourapi.v1+json`

### B. Implementing Versioning in Your API

To implement versioning in your Express routes, you can create separate route files for each version:

```javascript
// routes/v1/notes.js
router.get('/', async (req, res) => {
    // Code for version 1
});

// routes/v2/notes.js
router.get('/', async (req, res) => {
    // Code for version 2 with new features
});
```

Then, in your `app.js`, you can set up the routes:

```javascript
app.use('/api/v1/notes', require('./routes/v1/notes'));
app.use('/api/v2/notes', require('./routes/v2/notes'));
```

## Conclusion

In this lesson, you learned about the importance of API documentation and how to document APIs using tools like Swagger and Postman. You also explored API versioning strategies to maintain backward compatibility. Proper documentation and versioning are essential for the long-term success of your API, ensuring that developers can easily understand and use it. In the next lesson, we will explore advanced topics in Node.js development.

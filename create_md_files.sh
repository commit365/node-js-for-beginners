#!/bin/bash

# Create a directory named 'md'
mkdir -p md

# Array of lesson titles
lessons=(
    "01-Introduction-to-Back-End-Development"
    "02-Setting-Up-Your-Development-Environment"
    "03-JavaScript-Basics-for-Node.js"
    "04-Understanding-Node.js-Architecture"
    "05-Creating-Your-First-Node.js-Application"
    "06-Working-with-npm-and-Packages"
    "07-Introduction-to-Express.js"
    "08-Handling-HTTP-Requests-and-Responses"
    "09-Middleware-in-Express.js"
    "10-Working-with-JSON-and-Data-Formats"
    "11-Connecting-to-a-Database"
    "12-CRUD-Operations-with-MongoDB"
    "13-User-Authentication-and-Authorization"
    "14-Error-Handling-and-Debugging"
    "15-Building-RESTful-APIs"
    "16-Testing-Your-Application"
    "17-Deploying-Your-Node.js-Application"
    "18-Introduction-to-WebSockets"
    "19-Performance-Optimization-Techniques"
    "20-Building-a-Complete-Project"
    "21-Exploring-Advanced-Topics"
    "22-Security-Best-Practices"
    "23-API-Documentation-and-Versioning"
    "24-Working-with-Third-Party-APIs"
    "25-Asynchronous-Programming-in-Depth"
    "26-Staying-Updated-and-Community-Involvement"
)

# Create markdown files for each lesson
for lesson in "${lessons[@]}"; do
    touch "md/${lesson}.md"
done

echo "Markdown files created in the 'md' directory."

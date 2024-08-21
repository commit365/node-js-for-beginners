# Lesson 17: Deploying Your Node.js Application

## Objectives
By the end of this lesson, you will:
- Explore deployment options (e.g., Heroku, DigitalOcean).
- Learn how to prepare your application for production.

## Introduction to Deployment

Deploying your Node.js application makes it accessible to users over the internet. There are several platforms available for deploying Node.js applications, each with its own advantages. In this lesson, we will explore popular options and the necessary steps to prepare your application for production.

## 1. Deployment Options

### A. Heroku

**Heroku** is a cloud platform that allows you to deploy applications easily. It provides a free tier, which is great for small projects and testing.

#### Steps to Deploy on Heroku

1. **Create a Heroku Account:**
   - Sign up for a free account at [Heroku](https://www.heroku.com).

2. **Install the Heroku CLI:**
   - Download and install the Heroku Command Line Interface (CLI) from the [Heroku CLI page](https://devcenter.heroku.com/articles/heroku-cli).

3. **Login to Heroku:**
   ```bash
   heroku login
   ```

4. **Prepare Your Application:**
   - Ensure your application has a `package.json` file with the necessary dependencies and scripts.
   - Specify the Node.js version in your `package.json`:
     ```json
     "engines": {
       "node": "20.x"
     }
     ```

5. **Create a New Heroku App:**
   ```bash
   heroku create your-app-name
   ```

6. **Deploy Your Application:**
   ```bash
   git add .
   git commit -m "Prepare for deployment"
   git push heroku main
   ```

7. **Open Your Application:**
   ```bash
   heroku open
   ```

### B. DigitalOcean

**DigitalOcean** provides cloud infrastructure and is known for its simplicity and affordability. You can deploy applications on a virtual private server (VPS) or use the App Platform for easier deployment.

#### Steps to Deploy on DigitalOcean

1. **Create a DigitalOcean Account:**
   - Sign up at [DigitalOcean](https://www.digitalocean.com).

2. **Set Up a Droplet:**
   - Create a new droplet (VPS) with your desired configuration.
   - Choose an image with Node.js pre-installed or install Node.js manually.

3. **Deploy Your Application:**
   - SSH into your droplet:
     ```bash
     ssh root@your_droplet_ip
     ```
   - Clone your application from GitHub:
     ```bash
     git clone https://github.com/yourusername/your-repo.git
     cd your-repo
     npm install
     ```
   - Start your application using a process manager like **PM2**:
     ```bash
     npm install -g pm2
     pm2 start app.js
     ```

4. **Configure Nginx (Optional):**
   - Set up Nginx as a reverse proxy to serve your application and handle HTTPS.

## 2. Preparing Your Application for Production

Before deploying your application, it’s important to make certain adjustments to ensure it runs smoothly in a production environment.

### A. Environment Variables

Use environment variables to manage sensitive information (like database credentials) and configuration settings. Create a `.env` file in your project root:

```plaintext
DATABASE_URL=mongodb://localhost:27017/your_database
JWT_SECRET=your_jwt_secret
```

### B. Update Your `package.json`

Ensure your `package.json` includes the necessary scripts and dependencies. For example:

```json
"scripts": {
    "start": "node app.js",
    "test": "mocha"
},
"dependencies": {
    "express": "^4.17.1",
    "mongoose": "^5.10.9",
    "dotenv": "^8.2.0"
}
```

### C. Error Handling and Logging

Implement proper error handling and logging. Ensure that sensitive information is not exposed in error messages. Use a logging library like **winston** or **morgan** to log requests and errors.

### D. Security Best Practices

- **Use HTTPS:** Always serve your application over HTTPS to encrypt data in transit.
- **Set Security Headers:** Use libraries like **helmet** to set security-related HTTP headers.
- **Sanitize User Input:** Always validate and sanitize user input to prevent injection attacks.

## Conclusion

In this lesson, you explored various deployment options for your Node.js application, including Heroku and DigitalOcean. You also learned how to prepare your application for production by managing environment variables, updating your `package.json`, implementing error handling, and following security best practices. Deploying your application makes it accessible to users, allowing them to benefit from your work. In the next lesson, we will explore how to handle file uploads and serve static files in Express.

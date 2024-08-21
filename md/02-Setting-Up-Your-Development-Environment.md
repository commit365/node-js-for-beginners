# Lesson 2: Setting Up Your Development Environment

## Objectives
By the end of this lesson, you will:
- Install Node.js and npm (Node Package Manager).
- Set up a code editor (e.g., Visual Studio Code) and familiarize yourself with its features.

## What You Will Need

Before we begin, ensure you have the following:
- A computer (Windows, macOS, or Linux).
- An internet connection.

## Step 1: Installing Node.js and npm

Node.js is a JavaScript runtime that allows you to run JavaScript on the server side. npm is the package manager for Node.js, which helps you manage libraries and dependencies.

### Installation Instructions

### For Windows and macOS:

1. **Download Node.js:**
   - Go to the official Node.js website: [nodejs.org](https://nodejs.org).
   - You will see two versions available for download:
     - **LTS (Long Term Support):** Recommended for most users.
     - **Current:** Includes the latest features but may not be as stable.
   - Click on the LTS version to download the installer.

2. **Run the Installer:**
   - Open the downloaded installer.
   - Follow the installation prompts, accepting the license agreement and choosing the default settings.
   - Ensure that the option to install npm is checked.

3. **Verify Installation:**
   - Open your terminal (Command Prompt on Windows, Terminal on macOS).
   - Type the following commands to check the installations:
     ```bash
     node -v
     npm -v
     ```
   - You should see the version numbers for Node.js and npm, indicating that they are installed correctly.

### For Linux:

1. **Using a Package Manager:**
   - Open your terminal.
   - For Ubuntu or Debian, run:
     ```bash
     sudo apt update
     sudo apt install nodejs npm
     ```
   - For other distributions, check the appropriate package manager commands.

2. **Verify Installation:**
   - After installation, verify by running:
     ```bash
     node -v
     npm -v
     ```

## Step 2: Setting Up a Code Editor

A code editor is essential for writing and managing your code efficiently. We recommend using **Visual Studio Code** (VS Code), a popular, free, and powerful code editor.

### Installation Instructions for Visual Studio Code

1. **Download Visual Studio Code:**
   - Go to the official website: [code.visualstudio.com](https://code.visualstudio.com).
   - Click on the download button for your operating system (Windows, macOS, or Linux).

2. **Run the Installer:**
   - Open the downloaded installer and follow the prompts to install VS Code.

3. **Open Visual Studio Code:**
   - Launch the application after installation.

### Familiarizing Yourself with Visual Studio Code

Once you have VS Code open, take a moment to explore its features:

1. **User Interface Overview:**
   - **Activity Bar:** Located on the left, it provides access to different views (Explorer, Search, Source Control, etc.).
   - **Editor Area:** The central area where you write your code.
   - **Status Bar:** Displays information about the project, such as branch name, file encoding, and more.

2. **Creating a New File:**
   - Click on the **Explorer** icon in the Activity Bar.
   - Click on the **New File** icon or right-click in the Explorer area and select **New File**.
   - Name your file (e.g., `app.js`).

3. **Installing Extensions:**
   - Click on the **Extensions** icon in the Activity Bar.
   - Search for and install useful extensions, such as:
     - **ESLint:** For JavaScript linting.
     - **Prettier:** For code formatting.
     - **Live Server:** For running a local development server.

4. **Using the Integrated Terminal:**
   - Open the terminal by selecting **Terminal** from the top menu and then **New Terminal**.
   - This allows you to run Node.js commands directly within VS Code.

## Conclusion

In this lesson, you successfully installed Node.js and npm, set up Visual Studio Code as your code editor, and familiarized yourself with its features. You are now ready to start coding in Node.js! In the next lesson, we will review JavaScript basics that are essential for back-end development.

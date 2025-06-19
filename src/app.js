require('dotenv').config();  // Load environment variables from .env file

const express = require('express'); // Import Express framework
const mongoose = require('mongoose'); // Import Mongoose for MongoDB
const todosRoutes = require('./routes/todos'); // Import todos route handlers

const app = express(); // Create Express app instance

app.use(express.json()); // Middleware to parse JSON request bodies
app.use('/todos', todosRoutes); // Mount todos routes at /todos path

// Retrieve MongoDB URI and server port from environment variables
const mongoUri = process.env.MONGO_URI;
const port = process.env.PORT || 3000;

// Connect to MongoDB and start the server
mongoose.connect(mongoUri, {
  useNewUrlParser: true,      // Use new URL parser
  useUnifiedTopology: true,   // Use new server discovery and monitoring engine
}).then(() => {
  console.log('MongoDB connected');
  // Start Express server after successful DB connection
  app.listen(port, () => {
    console.log(`Server running on port ${port}`);
  });
}).catch(err => console.error(err)); // Log connection errors
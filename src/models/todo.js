/**
 * Todo Model
 * Defines the schema for Todo items in MongoDB using Mongoose.
 */

const mongoose = require('mongoose');

// Define the schema for a Todo item
const todoSchema = new mongoose.Schema({
  title: { type: String, required: true },      // Title of the todo (required)
  completed: { type: Boolean, default: false }  // Completion status (default: false)
}, { timestamps: true }); // Automatically adds createdAt and updatedAt fields

// Export the Todo model based on the schema
module.exports = mongoose.model('Todo', todoSchema);
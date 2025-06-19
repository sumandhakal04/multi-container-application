/**
 * Todos Route Handlers
 * Provides CRUD endpoints for Todo items.
 * Uses Mongoose model for MongoDB interactions.
 */

const express = require('express');
const router = express.Router();
const Todo = require('../models/todo'); // Mongoose model for Todo

// GET /todos — Retrieve all todos (titles only, plain text)
router.get('/', async (req, res) => {
  const todos = await Todo.find().select('title');
  const output = todos.map(todo => todo.title).join('\n');
  res.type('text/plain').send(output);
});

// POST /todos — Create a new todo
router.post('/', async (req, res) => {
  const todo = new Todo({ title: req.body.title });
  const saved = await todo.save();
  res.status(201).json(saved);
});

// GET /todos/:id — Retrieve a single todo by ID
router.get('/:id', async (req, res) => {
  const todo = await Todo.findById(req.params.id);
  if (!todo) return res.status(404).json({ error: 'Not found' });
  res.json(todo);
});

// PUT /todos/:id — Update a todo by ID
router.put('/:id', async (req, res) => {
  const updated = await Todo.findByIdAndUpdate(
    req.params.id,
    { title: req.body.title, completed: req.body.completed },
    { new: true }
  );
  if (!updated) return res.status(404).json({ error: 'Not found' });
  res.json(updated);
});

// DELETE /todos/:id — Delete a todo by ID
router.delete('/:id', async (req, res) => {
  const deleted = await Todo.findByIdAndDelete(req.params.id);
  if (!deleted) return res.status(404).json({ error: 'Not found' });
  res.json({ message: 'Deleted successfully' });
});

module.exports = router;
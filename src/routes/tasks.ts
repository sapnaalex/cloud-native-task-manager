import { Router, Request, Response } from 'express';
import db from '../db/database.js';
import { Task } from '../types/index.js';

const router = Router();

// GET /api/tasks - Get all tasks
router.get('/', (_req: Request, res: Response) => {
  db.all('SELECT * FROM tasks ORDER BY createdAt DESC', [], (err, rows) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json({ tasks: rows });
  });
});

// GET /api/tasks/:id - Get task by ID
router.get('/:id', (req: Request, res: Response) => {
  const { id } = req.params;
  db.get('SELECT * FROM tasks WHERE id = ?', [id], (err, row) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    if (!row) {
      return res.status(404).json({ error: 'Task not found' });
    }
    res.json({ task: row });
  });
});

// POST /api/tasks - Create a new task
router.post('/', (req: Request, res: Response) => {
  const { title, description, status = 'PENDING', priority = 'MEDIUM' }: Task = req.body;

  if (!title || !description) {
    return res.status(400).json({ error: 'Title and description are required' });
  }

  const query = `INSERT INTO tasks (title, description, status, priority) VALUES (?, ?, ?, ?)`;
  db.run(query, [title, description, status, priority], function (err) {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.status(201).json({
      message: 'Task created successfully',
      taskId: this.lastID,
    });
  });
});

// PUT /api/tasks/:id - Update task
router.put('/:id', (req: Request, res: Response) => {
  const { id } = req.params;
  const { title, description, status, priority }: Task = req.body;

  const query = `
    UPDATE tasks 
    SET title = COALESCE(?, title),
        description = COALESCE(?, description),
        status = COALESCE(?, status),
        priority = COALESCE(?, priority)
    WHERE id = ?
  `;

  db.run(query, [title, description, status, priority, id], function (err) {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    if (this.changes === 0) {
      return res.status(404).json({ error: 'Task not found' });
    }
    res.json({ message: 'Task updated successfully' });
  });
});

// DELETE /api/tasks/:id - Delete task
router.delete('/:id', (req: Request, res: Response) => {
  const { id } = req.params;
  db.run('DELETE FROM tasks WHERE id = ?', [id], function (err) {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    if (this.changes === 0) {
      return res.status(404).json({ error: 'Task not found' });
    }
    res.json({ message: 'Task deleted successfully' });
  });
});

export default router;
import express from 'express';
import fortunes from './read-fortunes';

export const router = express.Router();


/* GET home page. */
router.get('/', async (req, res, next) => {
  try {
    res.render('index', { 
      title: 'Fortunes',
      fortune: await fortunes()
    });
  } catch (err) {
    next(err);
  }
});

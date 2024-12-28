const mongoose = require('mongoose');

const connectDB = async () => {
  try {
    await mongoose.connect('mongodb://0.0.0.0:27017/uploads');
    console.log('MongoDB Connected');
  } catch (err) {
    console.error('Database connection error:', err.message);
  }
};
module.exports = connectDB;
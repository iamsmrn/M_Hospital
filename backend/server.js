const express = require('express');
const cors = require('cors');
const path = require('path');
const connectDB = require('./config/database');
const reportsRouter = require('./routes/reports');

const app = express();
const PORT = 3000;

connectDB();

app.use(cors());
app.use(express.json());
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));
app.use('/api/reports', reportsRouter);

//app.use((err, req, res, next) => {
//  res.status(500).json({ message: err.message });
//});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});


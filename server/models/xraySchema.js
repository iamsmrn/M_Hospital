const mongoose = require('mongoose');

const xraySchema = new mongoose.Schema({
    patientId: {
        type: Number,
    },
    imageUrl: {
        type: String,
    },
    description: {
        type: String,
    },
    dateTaken: {
        type: Date,
        default: Date.now
    },
},{timestamps: true});

const Xray = mongoose.model('Xray', xraySchema);

module.exports = Xray;
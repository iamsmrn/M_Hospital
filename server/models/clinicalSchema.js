const mongoose = require('mongoose');

const clinicalSchema = new mongoose.Schema({
    patientId: {
        type: Number,
        ref: 'Patient',
        required: true
    },
    imageUrl: {
        type: String,
        required: true
    },
    dateTaken: {
        type: Date,
        default: Date.now
    },
}, {
    timestamps: true
});

const Clinical = mongoose.model('Clinical', clinicalSchema);

module.exports = Clinical;
const Xray = require('../models/xraySchema');
const Clinical = require('../models/clinicalSchema');
const Prescription = require('../models/prescriptionSchema');


// handle x-ray report get request
const getXrayReport = async (req, res) => {
    try{
        const reports = await Xray.find();
        res.status(200).json(reports);
    } catch (error) {
        res.status(400).json({message: error.message});
    }
}


// handle x-ray report post request
const handleXrayReport = async (req, res) => {
    console.log("request file:", req);
    const filePath = `http://localhost:3000/uploads/${req.file.filename}`;
    console.log('File Path:', filePath);
    console.log('Patient ID:', req.body.patientId);
    try{
        const xray = await Xray.create({
            description: req.body.description,
            patientId: req.body.patientId,
            imageUrl: filePath
        });
        console.log('Xray record created:', xray);
        res.status(201).json(xray);
    } catch (error) {
        console.error('Error creating Xray record:', error);
        res.status(400).json({ message: error.message });
    }
}

// handle clinical report get request
const getClinicalReport = async (req, res) => {
    try{
        const reports = await Clinical.find();
        res.status(200).json(reports);
    } catch (error) {
        res.status(400).json({message: error.message});
    }
}

// handle clinical report post request
const handleClinicalReport = async (req, res) => {
    const filePath = `http://localhost:3000/uploads/${req.file.filename}`
    try{
        await Clinical.create({
            patientId: req.body.patientId,
            report: filePath
        });
    } catch (error) {
        res.status(400).json({message: error.message});
    }
}

// handle prescription get request
const getPrescription = async (req, res) => {
    try{
        const reports = await Prescription.find();
        res.status(200).json(reports);
    } catch (error) {
        res.status(400).json({message: error.message});
    }
}

// handle prescription post request
const handlePrescription = async (req, res) => {
    const filePath = `http://localhost:3000/uploads/${req.file.filename}`
    try{
        await Prescription.create({
            patientId: req.body.patientId,
            imageUrl: filePath
        });
    } catch (error) {
        res.status(400).json({message: error.message});
    }
}



module.exports = {
    handleXrayReport,
    handleClinicalReport,
    handlePrescription,
    getXrayReport,
    getClinicalReport,
    getPrescription
};
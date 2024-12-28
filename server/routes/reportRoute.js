const express = require("express");
const reportController = require("../controllers/reportController");
const upload = require("../storage");
const {
  handleXrayReport,
  handleClinicalReport,
  handlePrescription,
  getXrayReport,
  getClinicalReport,
  getPrescription,
} = reportController;

const router = express.Router();

// routes for x-ray reports
router.get("/xray", getXrayReport);
router.post("/xray", upload.single("file"), handleXrayReport);

// routes for clinical reports
router.get("/clinical", getClinicalReport);
router.post("/clinical", upload.single("file"), handleClinicalReport);

// routes for prescription
router.get("/prescription", getPrescription);
router.post("/prescription", upload.single("file"), handlePrescription);

module.exports = router;

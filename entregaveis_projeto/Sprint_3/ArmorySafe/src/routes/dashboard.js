// src/routes/dashboard.js
const express = require("express");
const router = express.Router();
const dashboardController = require("../controllers/dashboardController");

// Rotas necessárias pelo frontend
router.get("/ultimasLeituras/:idPaiol", dashboardController.ultimasLeituras);
router.get("/umidadeAtual/:idPaiol", dashboardController.ultimaLeitura);
router.get("/umidadeMaxima/:idPaiol", dashboardController.umidadeMaxima);

module.exports = router;

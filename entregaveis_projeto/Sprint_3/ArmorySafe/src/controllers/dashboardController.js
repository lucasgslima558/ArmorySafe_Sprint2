// src/controllers/dashboardController.js
const dashboardModel = require("../models/dashboardModel");

function ultimasLeituras(req, res) {
  const idPaiol = req.params.idPaiol;
  dashboardModel.ultimasLeituras(idPaiol)
    .then(resultado => {
      res.json(resultado);
    })
    .catch(erro => {
      console.error("Erro ao buscar últimas leituras:", erro);
      res.status(500).json(erro);
    });
}

function ultimaLeitura(req, res) {
  const idPaiol = req.params.idPaiol;
  dashboardModel.ultimaLeitura(idPaiol)
    .then(resultado => {
      res.json(resultado);
    })
    .catch(erro => {
      console.error("Erro ao buscar última leitura:", erro);
      res.status(500).json(erro);
    });
}

function umidadeMaxima(req, res) {
  const idPaiol = req.params.idPaiol;
  dashboardModel.umidadeMaxima(idPaiol)
    .then(resultado => {
      if (resultado && resultado.length > 0) {
        const row = resultado[0];
        res.json([{
          idPaiol: row.idPaiol,
          nomePaiol: row.nomePaiol,
          umidadeMaxima: row.umidade_maxima,     
          umidade_minima: row.umidade_minima,     
          qtd_leituras: row.qtd_leituras
        }]);
      } else {
        res.json([]);
      }
    })
    .catch(erro => {
      console.error("Erro ao buscar umidade máxima:", erro);
      res.status(500).json(erro);
    });
}

module.exports = {
  ultimasLeituras,
  ultimaLeitura,
  umidadeMaxima
};

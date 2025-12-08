// src/controllers/dashboardController.js
const dashboardModel = require("../models/dashboardModel");

// GET /dashboard/ultimasLeituras/:idPaiol
function ultimasLeituras(req, res) {
  const idPaiol = req.params.idPaiol;
  dashboardModel.ultimasLeituras(idPaiol)
    .then(resultado => {
      // Retorna diretamente o array de linhas (frontend fará reverse se quiser ordem asc)
      res.json(resultado);
    })
    .catch(erro => {
      console.error("Erro ao buscar últimas leituras:", erro);
      res.status(500).json(erro);
    });
}

// GET /dashboard/umidadeAtual/:idPaiol
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

// GET /dashboard/umidadeMaxima/:idPaiol
function umidadeMaxima(req, res) {
  const idPaiol = req.params.idPaiol;
  dashboardModel.umidadeMaxima(idPaiol)
    .then(resultado => {
      // Normaliza o retorno para facilitar uso no frontend (camelCase + snake)
      if (resultado && resultado.length > 0) {
        const row = resultado[0];
        res.json([{
          idPaiol: row.idPaiol,
          nomePaiol: row.nomePaiol,
          umidadeMaxima: row.umidade_maxima,      // CamelCase usado no seu JS
          umidade_minima: row.umidade_minima,     // também disponibilizo snake_case
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

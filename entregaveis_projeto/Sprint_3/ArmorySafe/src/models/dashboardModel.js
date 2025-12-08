// src/models/dashboardModel.js
const database = require("../database/config");

function ultimaLeitura(idPaiol) {
    const sql = `
        SELECT 
            l.idLeitura,
            l.umidade,
            l.dtLeitura,
            DATE_FORMAT(l.dtLeitura, '%H:%i:%s') AS momento_grafico,
            s.fkPaiol
        FROM leitura l
        JOIN sensor s ON s.idSensor = l.fkSensor
        WHERE s.fkPaiol = ${idPaiol}
        ORDER BY l.dtLeitura DESC
        LIMIT 1;
    `;

    return database.executar(sql);
}

// 2. LISTA DAS ÚLTIMAS N LEITURAS
function ultimasLeituras(idPaiol, limite = 24) {
    const sql = `
        SELECT 
            l.idLeitura,
            l.umidade,
            l.dtLeitura,
            DATE_FORMAT(l.dtLeitura, '%H:%i:%s') AS momento_grafico
        FROM leitura l
        JOIN sensor s ON s.idSensor = l.fkSensor
        WHERE s.fkPaiol = ${idPaiol}
        ORDER BY l.dtLeitura DESC
        LIMIT ${limite};
    `;

    return database.executar(sql);
}

// 3. KPI → Umidade máxima e mínima HOJE
function umidadeMaxima(idPaiol) {
    const sql = `
        SELECT
            p.idPaiol,
            p.nome AS nomePaiol,
            MAX(l.umidade) AS umidade_maxima,
            MIN(l.umidade) AS umidade_minima,
            COUNT(l.idLeitura) AS qtd_leituras
        FROM paiol p
        JOIN sensor s ON s.fkPaiol = p.idPaiol
        JOIN leitura l ON l.fkSensor = s.idSensor
        WHERE DATE(l.dtLeitura) = CURDATE()
          AND p.idPaiol = ${idPaiol}
        GROUP BY p.idPaiol, p.nome;
    `;

    return database.executar(sql);
}

// Export das funções para o controller
module.exports = {
    ultimaLeitura,
    ultimasLeituras,
    umidadeMaxima
};

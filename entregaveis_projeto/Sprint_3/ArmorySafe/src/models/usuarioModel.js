var database = require("../database/config");

function autenticar(cim, senha) {
    var instrucaoSql = `
        SELECT cim, senha 
        FROM usuario 
        WHERE cim = '${cim}' AND senha = '${senha}';
    `;
    return database.executar(instrucaoSql);
}

function cadastrar(organizacao, nome, cim, email,  cargo, senha) {

    var instrucaoSql = `
        INSERT INTO usuario (fkOrganizacao_Militar, nome, cim, email, cargoUsuario, senha)
        VALUES ('${organizacao}', '${nome}', '${cim}', '${email}', '${cargo}', '${senha}');
    `;

    return database.executar(instrucaoSql);
}

module.exports = {
    autenticar,
    cadastrar
};

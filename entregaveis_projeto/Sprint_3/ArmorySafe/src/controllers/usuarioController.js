var usuarioModel = require("../models/usuarioModel");

function autenticar(req, res) {
    var cim = req.body.cim;
    var senha = req.body.senha;
    var email = req.body.email;

    if (cim == undefined) {
        res.status(400).send("Seu cim está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está indefinida!");
    } else if (email == undefined) {
        res.status(400).send("Seu email está undefined");
    } else

        usuarioModel.autenticar(cim, senha)
            .then(function (resultadoAutenticar) {

                if (resultadoAutenticar.length == 1) {
                    res.json({
                        id: resultadoAutenticar[0].idUsuario,
                        cim: resultadoAutenticar[0].cim,
                        nome: resultadoAutenticar[0].nome,
                        senha: resultadoAutenticar[0].senha,
                        cargoUsuario: resultadoAutenticar[0].cargoUsuario
                    });

                } else if (resultadoAutenticar.length == 0) {
                    res.status(403).send("Cim e/ou senha inválido(s)");
                } else {
                    res.status(403).send("Mais de um usuário com o mesmo login!");
                }
            })
            .catch(function (erro) {
                console.log("ERRO LOGIN:", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            });
}


function cadastrar(req, res) {

    var nome = req.body.nome;
    var cim = req.body.cim;
    var cargo = req.body.cargo;
    var organizacao = req.body.organizacao;
    var senha = req.body.senha;

    if (!nome) return res.status(400).send("Nome undefined");
    if (!cim) return res.status(400).send("CIM undefined");
    if (!cargo) return res.status(400).send("Cargo undefined");
    if (!organizacao) return res.status(400).send("Organização undefined");
    if (!senha) return res.status(400).send("Senha undefined");

    usuarioModel.cadastrar(organizacao, nome, cim, cargo, senha)
        .then(function (resultado) {
            res.json(resultado);
        })
        .catch(function (erro) {
            console.log("ERRO CADASTRO:", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}

module.exports = {
    autenticar,
    cadastrar
}

let idPaiol;
let chartInstance = null;
let proximaAtualizacao = null;


function iniciarPagina() {
    idPaiol = Number(sessionStorage.ID_PAIOL) || 1;


    carregarCards();
    carregarGraficoInicial();
}


function carregarCards() {
    fetch(`/dashboard/umidadeAtual/${idPaiol}`)
        .then(r => r.json())
        .then(dados => {
            document.getElementById("conteudo").innerHTML = `
<h1>Dashboard do Paiol ${idPaiol}</h1>
<p>Umidade atual: ${dados.umidade}%</p>
`;
        });
}


function carregarGraficoInicial() {
    fetch(`/dashboard/ultimasLeituras/${idPaiol}`)
        .then(r => r.json())
        .then(dados => {
            console.log("Gerando gráfico do paiol", idPaiol);
        });
}
    // Variáveis de valor por bala e valor total
    let vr_val556 = 10.54
    let vr_val765 = 12.8
    let vr_val105 = 1868.4
    let vr_valTotal = 0

    // Variáveis de valor por caixa
    let vr_valCaixa556 = vr_val556 * 50
    let vr_valCaixa765 = vr_val765 * 50
    let vr_valCaixa105 = vr_val105 * 8

    // Variáveis de quantidade de balas por calibre e quantia total
    let vr_quant556 = 0
    let vr_quant765 = 0
    let vr_quant105 = 0
    let vr_quantTotal = 0

    // Variáveis de quantidade de caixas por calibre e quantia total
    let vr_quantCaixas556 = 0
    let vr_quantCaixas765 = 0
    let vr_quantCaixas105 = 0

    // Variável de percentual de umidade
    let vr_umid = 0

    function registrarVal() {
        vr_umid = Number(ipt_umid.value)

        // Validações de input
        if (vr_umid <= 0 || vr_umid > 100) {
            alert('Insira uma umidade válida. (Entre 1 e 100)')
        }

        if (sel_val.value <= 0) {
            alert('Selecione uma opção de valores de munição válida.')
        }

        if (sel_val.value == 1) {
            div_msg.innerHTML = ` <h3>QUANTIDADE DE BALAS POR CAIXA CONSIDERADAS:</h3><p>Caixas de 5.56x45mm contem 50 balas <br>Caixas de 7.65x51mm contem 50 balas <br>Caixas de 105mm contem 8 balas</p>Selecione o tipo de munição a ser utilizada: <select id="sel_mun"><option value="0">Selecione...</option><option value="1">5.56x45mm</option><option value="2">7.65x51mm</option><option value="3">105mm</option></select><br>Insira a quantidade de balas dessa munição: <input type="number" id="ipt_quant"><br><button onclick="calcularBala()">Calcular</button> <button onclick="simular()">Simular situação</button>`
            div_registro.style.display = 'none'
        } else if (sel_val.value == 2) {
            div_msg.innerHTML = `  <h3>QUANTIDADE DE BALAS POR CAIXA CONSIDERADAS:</h3><p>Caixas de 5.56x45mm contem 50 balas <br>Caixas de 7.65x51mm contem 50 balas <br>Caixas de 105mm contem 8 balas</p>Selecione o tipo de munição a ser utilizada: <select id="sel_mun"><option value="0">Selecione...</option><option value="1">5.56x45mm</option><option value="2">7.65x51mm</option><option value="3">105mm</option></select><br>Insira a quantidade de caixas de munição: <input type="number" id="ipt_quant"><br><button onclick="calcularCaixa()">Calcular</button> <button onclick="simular()">Simular situação</button>`
            div_registro.style.display = 'none'
        }
    }

    function calcularBala() {
        let vr_quant = Number(ipt_quant.value)

        // Validação de valor
        if (vr_quant <= 0) {
            alert('Insira uma quantidade de munição válida. (Acima de 0)')
        }

        if (sel_mun.value <= 0) {
            alert('Selecione um tipo de munição válida.')
        }

        // Inserção de valores caso a opção escolhida seja "Balas"
        if (sel_mun.value == 1) {
            vr_quant556 = Number(ipt_quant.value)
            vr_quantCaixas556 = Math.floor(vr_quant556 / 50)
            let vr_gasto556 = vr_val556 * vr_quant556
            vr_valTotal += vr_gasto556

            div_val.innerHTML += `<br><h4>Balas de 5.56x45mm</h4>Valor por bala: ${vr_val556}<br>Quantidade de caixas: ${vr_quantCaixas556}<br>Valor total: ${vr_gasto556.toFixed(2)}`
        } if (sel_mun.value == 2) {
            vr_quant765 = Number(ipt_quant.value)
            vr_quantCaixas765 = Math.floor(vr_quant765 / 50)
            let vr_gasto765 = vr_val765 * vr_quant765
            vr_valTotal += vr_gasto765

            div_val.innerHTML += `<br><h4>Balas de 7.65x51mm</h4>Valor por bala: ${vr_val765}<br>Quantidade de caixas: ${vr_quantCaixas765}<br>Valor total: ${vr_gasto765.toFixed(2)}`
        } if (sel_mun.value == 3) {
            vr_quant105 = Number(ipt_quant.value)
            vr_quantCaixas105 = Math.floor(vr_quant105 / 8)
            let vr_gasto105 = vr_val105 * vr_quant105
            vr_valTotal += vr_gasto105

            div_val.innerHTML += `<br><h4>Balas de 105mm</h4>Valor por bala: ${vr_val105}<br>Quantidade de caixas: ${vr_quantCaixas105}<br>Valor total: ${vr_gasto105.toFixed(2)}`
        }

        vr_quantTotal = vr_quant556 + vr_quant765 + vr_quant105
    }

    function calcularCaixa() {
        let vr_quant = Number(ipt_quant.value)

        // Validação de valor
        if (vr_quant <= 0) {
            alert('Insira uma quantidade de caixas de munição válida. (Acima de 0)')
        }

        if (sel_mun.value <= 0) {
            alert('Selecione uma opção de tipo de munição válida.')
        }

        // Inserção de valores caso a opção escolhida seja "Caixas"
        if (sel_mun.value == 1) {
            vr_quant556 = Number(ipt_quant.value)
            let vr_gastoCaixa556 = vr_valCaixa556 * vr_quant556
            vr_valTotal += vr_gastoCaixa556

            div_val.innerHTML += `<br><h4>Caixas de 5.56x45mm</h4>Valor por caixa: ${vr_val556 * 50}<br>Quantidade de caixas: ${vr_quant556}<br>Valor total: ${vr_gastoCaixa556.toFixed(2)}`
        } if (sel_mun.value == 2) {
            vr_quant765 = Number(ipt_quant.value)
            let vr_gastoCaixa765 = vr_valCaixa765 * vr_quant765
            vr_valTotal += vr_gastoCaixa765

            div_val.innerHTML += `<br><h4>Caixas de 7.65x51mm</h4>Valor por caixa: ${vr_val765 * 50}<br>Quantidade de caixas : ${vr_quant765}<br>Valor total: ${vr_gastoCaixa765.toFixed(2)}`
        } if (sel_mun.value == 3) {
            vr_quant105 = Number(ipt_quant.value)
            let vr_gastoCaixa105 = vr_valCaixa105 * vr_quant105
            vr_valTotal += vr_gastoCaixa105

            div_val.innerHTML += `<br><h4>Caixas de 105mm</h4>Valor por caixa: ${vr_val105 * 8}<br>Quantidade de caixas: ${vr_quant105}<br>Valor total: ${vr_gastoCaixa105.toFixed(2)}`
        }

        vr_quantTotal = vr_quant556 + vr_quant765 + vr_quant105
    }

    function simular() {
        if (vr_umid < 15) {
            div_simul.innerHTML = `<h3> Umidade abaixo de 15% - Crítico </h3> Valor total acumulado: ${vr_valTotal.toFixed(2)}<br> Prejuizo total.`
        } else if (vr_umid >= 15 && vr_umid <= 34) {
            div_simul.innerHTML = `<h3> Umidade entre 15% e 34% - Estado de alerta</h3> Valor total acumulado: ${vr_valTotal.toFixed(2)}<br> Prejuizo: ${vr_valTotal * 0.70.toFixed(2)} até ${vr_valTotal * 0.60.toFixed(2)}.`
        } else if (vr_umid >= 35 && vr_umid <= 50) {
            div_simul.innerHTML = `<h3> Umidade entre 35% e 50% - Ideal</h3> Valor total acumulado: ${vr_valTotal.toFixed(2)}`
        } else if (vr_umid >= 51 && vr_umid <= 70) {
            div_simul.innerHTML = `<h3> Umidade entre 51% e 70% - Estado de alerta</h3> Valor total acumulado: ${vr_valTotal.toFixed(2)}<br> Prejuizo: ${vr_valTotal * 0.60.toFixed(2)} até ${vr_valTotal * 0.50.toFixed(2)}.`
        } else if (vr_umid > 70) {
            div_simul.innerHTML = `<h3> Umidade acima de 70% - Crítico </h3> Valor total acumulado: ${vr_valTotal.toFixed(2)}<br> Prejuizo total.`
        }
    }

    /*  ADICIONAR VALIDAÇÃO À FUNÇÃO SIMULAR()
        TORNAR O CÓDIGO MAIS CONCISO
        CHECAR REDUNDÂNCIAS, APAGAR LINHAS NÃO NECESSÁRIAS
        PROCURAR NOVAS IDEIAS DE IMPLEMENTAÇÃO
        POR FIM, TERMINAR A PARTE DE SIMULAÇÃO COM OS DADOS NECESSÁRIOS
        */

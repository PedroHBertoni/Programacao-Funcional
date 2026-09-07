/// import sgleam/check
import gleam/float
import gleam/int
import gleam/option.{type Option, None}
import gleam/string

/// 10) Direções Cardeais
pub type Direcao {
  Leste
  Oeste
  Norte
  Sul
}

/// Retorna a direção oposta a d1
pub fn direcao_oposta(d: Direcao) -> Direcao {
  case d {
    Leste -> Oeste
    Oeste -> Leste
    Norte -> Sul
    Sul -> Norte
  }
}

/// Retorna a direção seguinte a d1 em sentido horário em 90 graus
pub fn prox_horario(d: Direcao) -> Direcao {
  case d {
    Leste -> Sul
    Oeste -> Norte
    Norte -> Leste
    Sul -> Oeste
  }
}

/// Retorna a direção seguinte a d1 em sentido anti-horário em 90 graus
pub fn prox_antihorario(d: Direcao) -> Direcao {
  prox_horario(prox_horario(prox_horario(d)))
}

/// Calcula quantos graus devem ser girados em sentido horário, a partir
/// de d1 para chegar em d2.
pub fn graus_giro(d1: Direcao, d2: Direcao) -> Int {
  case d1 == d2 {
    True -> 0
    False -> graus_giro(prox_horario(d1), d2) + 90
  }
}

/// 11) Elevador
pub type Elevador {
  Subindo
  Parado
  Descendo
}

/// Mostra o estado do Elevador para deslocar de andar_atual até andar_futuro
pub fn solicitacao_elevador(andar_atual: Int, andar_futuro: Int) -> Elevador {
  case andar_atual == andar_futuro {
    True -> Parado
    False ->
      case andar_atual > andar_futuro {
        True -> Descendo
        False -> Subindo
      }
  }
}

/// Subindo -> Subindo  = Válido
/// Subindo -> Parado   = Válido
/// Subindo -> Descendo = Impossível
/// Parado -> Subindo   = Válido
/// Parado -> Parado    = Válido
/// Parado -> Descendo  = Válido
/// Descendo -> Subindo = Impossível
/// Descendo -> Parado  = Válido
/// Descendo -> Descendo= Válido
/// 
/// Verifica se uma mudança de estado do elevador é válida
pub fn alteracao_valida(atual: Elevador, futuro: Elevador) -> Bool {
  case atual, futuro {
    Subindo, Descendo -> False
    Descendo, Subindo -> False
    _, _ -> True
  }
}

/// 12) Resolução de Telas
pub type Resolucao {
  Resolucao(altura: Int, largura: Int)
}

/// Calcula quantos mega-pixels tem uma imagem na sua resolução
pub fn mega_pixels(tamanho: Resolucao) -> Int {
  tamanho.altura * tamanho.largura / 1_000_000
}

///pub type Aspecto
/// Indica a razão simplificada da resolução, ou, seu aspecto 
///pub fn verifica_aspecto(_tamanho: Resolucao) {}
/// Retorna se *imagem* cabe em *tela* em sua resolução]
pub fn tem_espaco(imagem: Resolucao, tela: Resolucao) -> Bool {
  imagem.largura <= tela.largura && imagem.altura <= tela.altura
}

/// 13) Figuras Circulo ou Retângulo
pub type Figura {
  Retangulo(altura: Float, largura: Float)
  Circulo(raio: Float)
}

/// Calcula a área de uma figura qualquer
pub fn area(fig: Figura) -> Float {
  case fig {
    Retangulo(_, _) -> fig.altura *. fig.largura
    Circulo(_) -> fig.raio *. 3.14
  }
}

/// Retorna se fig1 cabe em fig2, independente de quais tipos são
pub fn figura_espaco(fig1: Figura, fig2: Figura) -> Bool {
  case fig1, fig2 {
    Retangulo(_, _), Retangulo(_, _) ->
      fig1.altura <=. fig2.altura && fig1.largura <=. fig2.largura

    Retangulo(_, _), Circulo(_) -> {
      let assert Ok(diagonal) =
        float.power(
          fig1.altura *. fig1.altura +. fig1.largura *. fig1.largura,
          0.5,
        )

      diagonal <=. fig2.raio *. 2.0
    }

    Circulo(_), Retangulo(_, _) ->
      fig1.raio *. 2.0 <=. fig2.altura && fig1.raio *. 2.0 <=. fig2.largura
    Circulo(_), Circulo(_) -> fig1.raio <=. fig2.raio
  }
}

/// 14) Sala de Cinema
pub type Espectador {
  Crianca
  Jovem(carteirinha: Option(Int))
  Adulto
  Idoso
}

/// Retorna o numéro de uma carteirinha caso *espec* possua
pub fn mostra_carteirinha(espec: Espectador) -> Option(Int) {
  case espec {
    Jovem(_) ->
      case espec.carteirinha {
        None -> None
        _ -> espec.carteirinha
      }
    _ -> None
  }
}

/// Retorna se *espec* possui desconto, caso seja Criança, Idoso ou possua
/// carteirinha.
pub fn possui_desconto(espec: Espectador) -> Bool {
  case espec {
    Adulto -> False
    Jovem(_) ->
      case espec.carteirinha {
        None -> False
        _ -> True
      }
    _ -> True
  }
}

/// 15) Formatação de Datas
pub type Data {
  Data(dia: Int, ano: Int, mes: Int)
}

/// Extrai uma Data a partir de *texto* no formato “dd/mm/aaaa”
pub fn extrai_data(texto: String) -> Data {
  let assert Ok(dia) = int.parse(string.slice(texto, 0, 2))
  let assert Ok(mes) = int.parse(string.slice(texto, 3, 2))
  let assert Ok(ano) = int.parse(string.slice(texto, 6, 4))

  Data(dia, ano, mes)
}

/// Verifica se *data* é 31 de Dezembro
pub fn ultimo_dia(data: Data) -> Bool {
  case data {
    Data(31, _, 12) -> True
    _ -> False
  }
}

/// Verifica se *data1* vem antes de *data2* no calendário
pub fn vem_antes(data1: Data, data2: Data) -> Bool {
  case data1.ano < data2.ano {
    True -> True
    False ->
      case data1.ano == data2.ano {
        False -> False
        True ->
          case data1.mes < data2.mes {
            True -> True
            False ->
              case data1.mes == data2.mes {
                False -> False
                True -> data1.dia < data2.dia
              }
          }
      }
  }
}

/// 16) Situação Acadêmica
pub type Situacao {
  Aprovado
  Exame
  Reprovado
}

/// Retorna uma Situacao para um aluno baseado na média das suas notas,
/// Aprovados aqueles com média maior que 7, Exame maiores que 4 e menores
/// que 7 e Reprovados aqueles com menos de 4 pontos.
pub fn resultado(n1: Float, n2: Float, n3: Float, n4: Float) -> Situacao {
  let media = { n1 +. n2 +. n3 +. n4 } /. 4.0
  case media >=. 7.0 {
    True -> Aprovado
    False ->
      case media >=. 4.0 {
        True -> Exame
        False -> Reprovado
      }
  }
}

/// 17) Bandeira tarifária
pub type Bandeira {
  Verde
  Amarelo
  Vermelho1
  Vermelho2
}

/// Calcula o valor final de custos, com o acréscimo para kwat-hora feitos Verde
/// não tem aumento, amarelo tem aumento de 0,01874 reais, vermelho patamar 1 tem
/// aumento de 0,03971 reais e patamar 2 com aumento de 0,09492 reais.
pub fn custo_energia(consumo: Float, tarifa: Float, bandeira: Bandeira) -> Float {
  case bandeira {
    Verde -> tarifa
    Amarelo -> tarifa +. { 0.01874 *. consumo }
    Vermelho1 -> tarifa +. { 0.03971 *. consumo }
    Vermelho2 -> tarifa +. { 0.09492 *. consumo }
  }
}

/// 18) Jokenpo
pub type Jokenpo {
  Pedra
  Papel
  Tesoura
}

/// Determina quem ganhou entre *jogador1* ou *jogador2* baseado nas regras de uma
/// partida de Jokenpo
/// Pedra - Pedra -> Empate
/// Pedra - Papel -> 2
/// Pedra - Tesoura -> 1
/// Papel - Pedra -> 1
/// Papel - Papel -> Empate
/// Papel - Tesoura -> 2
/// Tesoura - Pedra -> 2
/// Tesoura - Papel -> 1
/// Tesoura - Tesoura -> Empate
pub fn ganhador(
  jogador1: String,
  jogada1: Jokenpo,
  jogador2: String,
  jogada2: Jokenpo,
) -> String {
  case jogada1, jogada2 {
    Pedra, Papel -> jogador2
    Pedra, Tesoura -> jogador1
    Papel, Tesoura -> jogador2
    Papel, Pedra -> jogador1
    Tesoura, Pedra -> jogador2
    Tesoura, Papel -> jogador1
    _, _ -> "Empate"
  }
}

/// 19) Desempenho Futebol
pub type Placar {
  Placar(feitos: Int, sofridos: Int)
}

/// Atualiza os *pontos* de um time com base no último placar
pub fn att_desempenho(pontos: Int, jogo: Placar) -> Int {
  case jogo.feitos > jogo.sofridos {
    True -> pontos + 3
    False ->
      case jogo.feitos == jogo.sofridos {
        True -> pontos + 1
        False -> pontos
      }
  }
}

/// 20) Duração em segundos
pub type Duracao {
  Duracao(horas: Int, minutos: Int, segundos: Int)
}

/// Converte *duracao* em segundos para uma Duracao com horário simplificado
/// em horas, minutos e segundos
pub fn conversao(duracao: Int) -> Duracao {
  let horas: Int = duracao / 3600
  let min: Int = { duracao - horas * 3600 } / 60
  let segs: Int = duracao - horas * 3600 - min * 60
  Duracao(horas, min, segs)
}

/// Traz uma visualização de uma Duracao em String, ignorando valores nulos
pub fn relogio(horario: Duracao) -> String {
  case horario.horas == 0 {
    True -> ""
    False -> int.to_string(horario.horas) <> "h : "
  }
  <> case horario.minutos == 0 {
    True -> ""
    False -> int.to_string(horario.minutos) <> "m : "
  }
  <> case horario.segundos == 0 {
    True -> ""
    False -> int.to_string(horario.segundos) <> "s"
  }
}

/// 21) Tabuleiro
pub type Posicao {
  Posicao(x: Int, y: Int)
}

/// Retorna o máximo possível de espaços a serem andados pelo tabuleiro 10x10
/// de acordo com a *posi* atual e a *direcao* que está olhando
pub fn max_passos(posicao: Posicao, direcao: Direcao) -> Int {
  case direcao {
    Norte -> 10 - posicao.y
    Sul -> { posicao.y - 10 } * { -1 }
    Leste -> 10 - posicao.x
    Oeste -> { posicao.x - 10 } * { -1 }
  }
}

/// 22) Janela em exibição
pub type Janela {
  Janela(x_inicio: Int, x_fim: Int, y_inicio: Int, y_fim: Int)
}

/// Retorna se *click* está dentro de *janela* numa tela 1920x1080
pub fn clicou(janela: Janela, click: Posicao) -> Bool {
  click.x >= janela.x_inicio
  && click.x <= janela.x_fim
  && click.y >= janela.y_inicio
  && click.y <= janela.y_fim
}

/// 23) Jogador no tabuleiro
pub type Jogador {
  Jogador(posicao: Posicao, direcao: Direcao)
}

/// Retorna o mesmo *jogador* mas com sua direção girada 90 graus à direita
pub fn vira_direita(jogador: Jogador) -> Jogador {
  let nova_dire: Direcao = prox_horario(jogador.direcao)
  Jogador(..jogador, direcao: nova_dire)
}

/// Retorna o mesmo *jogador* mas com sua direção girada 90 graus à esquerda
pub fn vira_esquerda(jogador: Jogador) -> Jogador {
  let nova_dire: Direcao = prox_antihorario(jogador.direcao)
  Jogador(..jogador, direcao: nova_dire)
}

/// Retorna o mesmo *jogador* mas com sua posição andada para direção em *n* casas.
/// Caso ultrapasse o limite do tabuleiro 10x10, para na posição 10
pub fn anda_passos(jogador: Jogador, n: Int) -> Jogador {
  case jogador.direcao, max_passos(jogador.posicao, jogador.direcao) > n {
    Norte, True ->
      Jogador(
        ..jogador,
        posicao: Posicao(jogador.posicao.x, jogador.posicao.y + n),
      )
    Norte, False -> Jogador(..jogador, posicao: Posicao(jogador.posicao.x, 10))
    Sul, True ->
      Jogador(
        ..jogador,
        posicao: Posicao(jogador.posicao.x, jogador.posicao.y - n),
      )
    Sul, False -> Jogador(..jogador, posicao: Posicao(jogador.posicao.x, 0))
    Leste, True ->
      Jogador(
        ..jogador,
        posicao: Posicao(jogador.posicao.x + n, jogador.posicao.y),
      )
    Leste, False -> Jogador(..jogador, posicao: Posicao(10, jogador.posicao.y))
    Oeste, True ->
      Jogador(
        ..jogador,
        posicao: Posicao(jogador.posicao.x - n, jogador.posicao.y),
      )
    Oeste, False -> Jogador(..jogador, posicao: Posicao(0, jogador.posicao.y))
  }
}

/// 24) Desconto Forma de Pagamento
pub type Pagamento {
  Pix
  Dinheiro
  Boleto
  Parcelado(parcelas: Int)
}

/// Retorna o *valor* de compra com suas alterações baseado na *forma* de pagamento
/// 10% de desconto para pagamento em Pix/Dinheiro, 8% no boleto, até 3 parcelas, preço
/// integro e mais de 3 parcelas, acréscimo de 12%
pub fn forma_pagamento(valor: Float, forma: Pagamento) -> Float {
  case forma {
    Boleto -> valor *. 0.92
    Parcelado(_) ->
      case forma.parcelas > 3 {
        True -> valor *. 1.12
        False -> valor
      }
    _ -> valor *. 0.9
  }
}

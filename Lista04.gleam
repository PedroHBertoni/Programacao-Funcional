/// import sgleam/check
import gleam/float
import gleam/option.{type Option, None}

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
    Retangulo(_, _), Circulo(_) ->
          float.power(
            fig1.altura *. fig1.altura +. fig1.largura *. fig1.largura,
            0.5,
          )
          ]<=. fig2.raio *. 2.0

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
  Data(dia:Int, ano: Int, mes:Int)
}

/// Extrai uma Data a partir de *texto*
pub fn extrai_data(texto: String) -> Data {

}

/// Verifica se *data* é 31 de Dezembro
pub fn ultimo_dia(data: Data) -> Bool {
  data.dia == 31 && data.mes == 12
}

/// Verifica se *data1* vem antes de *data2* no calendário
pub fn vem_antes(data1: Data, data2: Data) -> Bool {
  case data1.ano <= data2.ano {
    False -> False
    True -> case data1.ano < data2.ano {
      True -> True
      False -> case data1.mes <= data2.mes {
        False -> False
        True -> case data1.mes < data2.mes {
          True -> True
          False -> case data1.dia < data2.dia {
            True -> True
            False -> False
          }
        }
      }
    } 
  }
}

/// import sgleam/check
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

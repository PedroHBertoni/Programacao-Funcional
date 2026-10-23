import gleam/int
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/string
import sgleam/check

///
/// 7) Retorna uma lista com *n* vezes o elemento *v*
///
pub fn lista_repeticoes(n: Int, v: Int) -> Result(List(Int), Nil) {
  case n {
    _ if n < 0 -> Error(Nil)
    _ if n == 0 -> Ok([])
    _ ->
      case lista_repeticoes(n - 1, v) {
        Ok(resto) -> Ok([v, ..resto])
        Error(Nil) -> Error(Nil)
      }
  }
}

pub fn lista_repeticoes_examples() {
  check.eq(lista_repeticoes(-2, 3), Error(Nil))
  check.eq(lista_repeticoes(0, 3), Ok([]))
  check.eq(lista_repeticoes(1, 3), Ok([3]))
  check.eq(lista_repeticoes(5, 3), Ok([3, 3, 3, 3, 3]))
}

///
///  8) Calcula o valor de *a* elevando a *n*
///
pub fn potencia(a: Int, n: Int) -> Result(Int, Nil) {
  case n {
    _ if n < 0 -> Error(Nil)
    _ if n == 0 -> Ok(1)
    _ ->
      case potencia(a, n - 1) {
        Ok(resto) -> Ok(a * resto)
        Error(Nil) -> Error(Nil)
      }
  }
}

pub fn potencia_examples() {
  check.eq(potencia(-2, -1), Error(Nil))
  check.eq(potencia(-2, 0), Ok(1))
  check.eq(potencia(-2, 3), Ok(-8))
}

///
/// 9) Retorna o fatorial de *n*
/// 
pub fn fatorial(n: Int) -> Result(Int, Nil) {
  case n {
    _ if n < 0 -> Error(Nil)
    _ if n == 0 -> Ok(1)
    _ ->
      case fatorial(n - 1) {
        Ok(resto) -> Ok(n * resto)
        Error(Nil) -> Error(Nil)
      }
  }
}

pub fn fatorial_examples() {
  check.eq(fatorial(-2), Error(Nil))
  check.eq(fatorial(0), Ok(1))
  check.eq(fatorial(3), Ok(6))
}

///
/// 10) Retorna se *n* é par, senão pega o retorno da funcao impar()
///
pub fn par(n: Int) -> String {
  case n {
    _ if n % 2 == 0 -> "Par"
    _ -> impar(n)
  }
}

/// Retorna se *n* é impar, senão pega o retorno da funcao par()
///
pub fn impar(n: Int) -> String {
  case n {
    _ if n % 2 != 0 -> "Impar"
    _ -> par(n)
  }
}

pub fn par_impar_examples() {
  check.eq(par(2), "Par")
  check.eq(impar(2), "Par")
  check.eq(par(1), "Impar")
  check.eq(impar(1), "Impar")
  check.eq(par(0), "Par")
  check.eq(impar(0), "Par")
}

///
/// 11) Retorna a diferença entre o maior valor e o menor em *lst*
///
pub fn amplitude(lst: List(Int)) -> Option(Int) {
  case maior(lst), menor(lst) {
    Some(maior), Some(menor) -> Some(maior - menor)
    _, _ -> None
  }
}

/// auxiliar -> amplitude
/// Encontra o maior valor em uma Lista *lst*
///
pub fn maior(lst: List(Int)) -> Option(Int) {
  case lst {
    [] -> None
    [primeiro] -> Some(primeiro)
    [primeiro, segundo, ..resto] ->
      case primeiro > segundo {
        True -> maior([primeiro, ..resto])
        False -> maior([segundo, ..resto])
      }
  }
}

/// auxiliar -> amplitude
/// Encontra o menor valor em uma Lista *lst*
///
pub fn menor(lst: List(Int)) -> Option(Int) {
  case lst {
    [] -> None
    [primeiro] -> Some(primeiro)
    [primeiro, segundo, ..resto] ->
      case primeiro < segundo {
        True -> menor([primeiro, ..resto])
        False -> menor([segundo, ..resto])
      }
  }
}

pub fn amplitude_examples() {
  check.eq(amplitude([]), None)
  check.eq(amplitude([1]), Some(0))
  check.eq(amplitude([2, 3, 1]), Some(2))
  check.eq(amplitude([1, 2, 3, 4]), Some(3))
}

///
/// 12) Determina o tamanho médio das Strings de *lst*
///
pub fn media_strings(lst: List(String)) -> Float {
  let lst_tamanhos = tamanhos(lst)
  let tamanho_total = tamanho_total(lst_tamanhos)

  case list.length(lst) != 0 {
    True -> int.to_float(tamanho_total) /. int.to_float(list.length(lst))
    False -> 0.0
  }
}

/// auxiliar -> media_strings
/// Retorna o tamanho de cada palavra em *lst*
pub fn tamanhos(lst: List(String)) -> List(Int) {
  case lst {
    [] -> []
    [primeiro, ..resto] -> [string.length(primeiro), ..tamanhos(resto)]
  }
}

/// auxiliar -> media_strings
/// Retorna a soma de todos os tamanhos
pub fn tamanho_total(lst: List(Int)) -> Int {
  case lst {
    [] -> 0
    [primeiro, ..resto] -> primeiro + tamanho_total(resto)
  }
}

pub fn media_strings_examples() {
  check.eq(media_strings([]), 0.0)
  check.eq(media_strings(["a"]), 1.0)
  check.eq(media_strings(["a", "a"]), 1.0)
  check.eq(media_strings(["abc", "abcd", "abc", "a"]), 2.75)
}

///
/// 13) Determina se *lst* tem mais valores positivos ou negativos
///
pub fn sinal_frequente(lst: List(Int)) -> String {
  let num = quant_positivos(lst)
  case num {
    _ if num > 0 -> "Positivo"
    _ if num < 0 -> "Negativo"
    _ -> "Neutro"
  }
}

/// auxiliar -> sinal_frequente
/// Retorna quantos números positivos tem em *lst*
pub fn quant_positivos(lst: List(Int)) -> Int {
  case lst {
    [] -> 0
    [primeiro, ..resto] ->
      case primeiro > 0 {
        _ if primeiro > 0 -> 1 + quant_positivos(resto)
        _ if primeiro < 0 -> { -1 } + quant_positivos(resto)
        _ -> 0 + quant_positivos(resto)
      }
  }
}

pub fn sinal_frequente_examples() {
  check.eq(sinal_frequente([]), "Neutro")
  check.eq(sinal_frequente([0]), "Neutro")
  check.eq(sinal_frequente([1]), "Positivo")
  check.eq(sinal_frequente([-1]), "Negativo")
  check.eq(sinal_frequente([1, 2, 3, 1, -2, 3]), "Positivo")
  check.eq(sinal_frequente([1, 2, 3, -1, -2, -3]), "Neutro")
  check.eq(sinal_frequente([-1, -2, -3, -1, 2, 3]), "Negativo")
}

///
/// 14) Determina quantos nós de grau 2 tem uma árvore binária *ab*
///
pub fn quant_nos(ab: Arvore) {
  case ab.esq, ab.dir {
    None, None -> 0
    Some(ramo), None | None, Some(ramo) -> quant_nos(ramo)
    Some(esq), Some(dir) -> 1 + quant_nos(esq) + quant_nos(dir)
  }
}

pub type Arvore {
  Arvore(valor: Int, esq: Option(Arvore), dir: Option(Arvore))
}

pub fn quant_nos_examples() {
  check.eq(quant_nos(Arvore(2, None, None)), 0)
  check.eq(quant_nos(Arvore(2, Some(Arvore(1, None, None)), None)), 0)
  check.eq(
    quant_nos(Arvore(
      2,
      Some(Arvore(1, None, None)),
      Some(Arvore(3, None, None)),
    )),
    1,
  )
}

///
/// 15) Retorna se uma árvore binária está cheia ou não, verificando se 
/// todos os nós possuem grau 0 ou 2
///
pub fn arvore_cheia(ab: Arvore) -> Bool {
  case ab.esq, ab.dir {
    Some(esquerda), Some(direita) ->
      arvore_cheia(esquerda) && arvore_cheia(direita)
    None, None -> True
    _, _ -> False
  }
}

pub fn arvore_cheia_examples() {
  check.eq(arvore_cheia(Arvore(2, None, None)), True)
  check.eq(arvore_cheia(Arvore(2, Some(Arvore(1, None, None)), None)), False)
  check.eq(
    arvore_cheia(Arvore(
      2,
      Some(Arvore(1, None, None)),
      Some(Arvore(3, None, None)),
    )),
    True,
  )
}

///
/// 16) Determina se uma árvore binária está balanceada
///
pub fn arvore_balanceada(ab: Arvore) -> Bool {
  let altura_esq = altura_arvore(ab.esq)
  let altura_dir = altura_arvore(ab.dir)

  case altura_dir > altura_esq {
    True -> altura_dir - altura_esq <= 1
    False -> altura_esq - altura_dir <= 1
  }
  && case ab.esq {
    None -> True
    Some(esquerda) -> arvore_balanceada(esquerda)
  }
  && case ab.dir {
    None -> True
    Some(direita) -> arvore_balanceada(direita)
  }
}

///
/// auxiliar -> arvore_balanceada
/// Retorna a altura de uma subárvore opcional
///
pub fn altura_arvore(ab: Option(Arvore)) -> Int {
  case ab {
    None -> 0
    Some(ramo) ->
      case maior([altura_arvore(ramo.esq), altura_arvore(ramo.dir)]) {
        Some(altura_maior) -> altura_maior + 1
        _ -> 0
      }
  }
}

pub fn arvore_balanceada_examples() {
  check.eq(arvore_balanceada(Arvore(2, None, None)), True)

  check.eq(
    arvore_balanceada(Arvore(2, Some(Arvore(1, None, None)), None)),
    True,
  )

  check.eq(
    arvore_balanceada(Arvore(
      2,
      Some(Arvore(1, Some(Arvore(0, None, None)), None)),
      None,
    )),
    False,
  )

  check.eq(
    arvore_balanceada(Arvore(
      2,
      Some(Arvore(1, None, None)),
      Some(Arvore(3, None, None)),
    )),
    True,
  )
}

///
/// 17) Determina se uma árvore binária é uma árvore binária de busca
///
pub fn arvore_busca(ab: Arvore) -> Bool {
  arvore_busca_limites(Some(ab), None, None)
}

///
/// auxiliar -> arvore_busca
/// Verifica se os valores respeitam os limites mínimo e máximo
///
pub fn arvore_busca_limites(
  ab: Option(Arvore),
  minimo: Option(Int),
  maximo: Option(Int),
) -> Bool {
  case ab {
    None -> True
    Some(no) ->
      case minimo {
        Some(min) if no.valor <= min -> False
        _ ->
          case maximo {
            Some(max) if no.valor >= max -> False
            _ ->
              arvore_busca_limites(no.esq, minimo, Some(no.valor))
              && arvore_busca_limites(no.dir, Some(no.valor), maximo)
          }
      }
  }
}

pub fn arvore_busca_examples() {
  check.eq(arvore_busca(Arvore(2, None, None)), True)

  check.eq(
    arvore_busca(Arvore(
      2,
      Some(Arvore(1, None, None)),
      Some(Arvore(3, None, None)),
    )),
    True,
  )

  check.eq(
    arvore_busca(Arvore(
      2,
      Some(Arvore(3, None, None)),
      Some(Arvore(4, None, None)),
    )),
    False,
  )

  check.eq(
    arvore_busca(Arvore(
      10,
      Some(Arvore(5, None, Some(Arvore(12, None, None)))),
      None,
    )),
    False,
  )

  check.eq(arvore_busca(Arvore(2, Some(Arvore(2, None, None)), None)), False)
}

///
/// 18) Determina se um elemento está em uma árvore binária de busca
///
pub fn buscar_bst(valor: Int, ab: Arvore) -> Bool {
  case valor == ab.valor {
    True -> True
    False ->
      case valor < ab.valor, ab.esq, ab.dir {
        True, Some(ramo), _ -> buscar_bst(valor, ramo)
        False, _, Some(ramo) -> buscar_bst(valor, ramo)
        _, _, _ -> False
      }
  }
}

pub fn buscar_bst_examples() {
  let arvore =
    Arvore(3, Some(Arvore(1, None, Some(Arvore(2, None, None)))), None)

  check.eq(buscar_bst(4, Arvore(3, None, None)), False)
  check.eq(buscar_bst(4, Arvore(4, None, None)), True)
  check.eq(buscar_bst(1, arvore), True)
  check.eq(buscar_bst(2, arvore), True)
  check.eq(buscar_bst(3, arvore), True)
  check.eq(buscar_bst(4, arvore), False)
}

///
/// 20) Determina se um aluno receberá a Láurea Acadêmica
///
pub fn laurea_academica(notas: List(Float)) -> Bool {
  let total = list.length(notas)
  let maiores = quant_notas_maiores(notas)

  total > 0 && maiores * 3 > total * 2
}

///
/// auxiliar -> laurea_academica
/// Retorna quantas notas são maiores que 9.0
///
pub fn quant_notas_maiores(notas: List(Float)) -> Int {
  case notas {
    [] -> 0
    [primeira, ..resto] ->
      case primeira >. 9.0 {
        True -> 1 + quant_notas_maiores(resto)
        False -> quant_notas_maiores(resto)
      }
  }
}

pub fn laurea_academica_examples() {
  check.eq(laurea_academica([]), False)
  check.eq(laurea_academica([10.0]), True)
  check.eq(laurea_academica([9.0]), False)
  check.eq(laurea_academica([10.0, 10.0, 8.0]), False)
  check.eq(laurea_academica([10.0, 10.0, 10.0]), True)
  check.eq(laurea_academica([10.0, 10.0, 10.0, 8.0]), True)
  check.eq(laurea_academica([10.0, 8.0, 7.0]), False)
}

///
/// 21) Determina o resultado de uma eleição
/// 0 representa voto em branco
/// 1 representa voto no primeiro candidato
/// 2 representa voto no segundo candidato
///
pub fn resultado_eleicao(votos: List(Int)) -> String {
  let brancos = quant_votos(votos, 0)
  let candidato1 = quant_votos(votos, 1)
  let candidato2 = quant_votos(votos, 2)
  let total = list.length(votos)

  case brancos * 2 > total {
    True -> "Nova eleição"
    False ->
      case candidato1 > candidato2 {
        True -> "Candidato 1"
        False ->
          case candidato2 > candidato1 {
            True -> "Candidato 2"
            False -> "Empate"
          }
      }
  }
}

///
/// auxiliar -> resultado_eleicao
/// Conta quantas vezes um voto aparece na lista
///
pub fn quant_votos(votos: List(Int), voto: Int) -> Int {
  case votos {
    [] -> 0
    [primeiro, ..resto] ->
      case primeiro == voto {
        True -> 1 + quant_votos(resto, voto)
        False -> quant_votos(resto, voto)
      }
  }
}

pub fn resultado_eleicao_examples() {
  check.eq(resultado_eleicao([1, 1, 2]), "Candidato 1")
  check.eq(resultado_eleicao([1, 2, 2]), "Candidato 2")
  check.eq(resultado_eleicao([1, 2]), "Empate")
  check.eq(resultado_eleicao([0, 0, 1]), "Nova eleição")
  check.eq(resultado_eleicao([0, 1, 2]), "Empate")
  check.eq(resultado_eleicao([0, 0, 1, 2]), "Empate")
}

///
/// 22) Determina o menor retângulo delimitador de um conjunto de pontos
///
pub type Retangulo {
  Retangulo(min_x: Float, max_x: Float, min_y: Float, max_y: Float)
}

pub type Ponto {
  Ponto(x: Float, y: Float)
}

pub fn retangulo_delimitador(pontos: List(Ponto)) -> Option(Retangulo) {
  let xs = coordenadas_x(pontos)
  let ys = coordenadas_y(pontos)

  case menor_float(xs), maior_float(ys), maior_float(xs), menor_float(ys) {
    Some(min_x), Some(max_y), Some(max_x), Some(min_y) ->
      Some(Retangulo(min_x, max_x, min_y, max_y))
    _, _, _, _ -> None
  }
}

///
/// auxiliar -> retangulo_delimitador
/// Retorna as coordenadas x dos pontos
pub fn coordenadas_x(pontos: List(Ponto)) -> List(Float) {
  case pontos {
    [] -> []
    [Ponto(x, _), ..resto] -> [x, ..coordenadas_x(resto)]
  }
}

///
/// auxiliar -> retangulo_delimitador
/// Retorna as coordenadas y dos pontos
pub fn coordenadas_y(pontos: List(Ponto)) -> List(Float) {
  case pontos {
    [] -> []
    [Ponto(_, y), ..resto] -> [y, ..coordenadas_y(resto)]
  }
}

/// auxiliar -> retangulo_delimitador
/// Encontra o menor valor em uma lista de Floats
pub fn menor_float(lst: List(Float)) -> Option(Float) {
  case lst {
    [] -> None
    [primeiro] -> Some(primeiro)
    [primeiro, segundo, ..resto] ->
      case primeiro <. segundo {
        True -> menor_float([primeiro, ..resto])
        False -> menor_float([segundo, ..resto])
      }
  }
}

/// auxiliar -> retangulo_delimitador
/// Encontra o maior valor em uma lista de Floats
pub fn maior_float(lst: List(Float)) -> Option(Float) {
  case lst {
    [] -> None
    [primeiro] -> Some(primeiro)
    [primeiro, segundo, ..resto] ->
      case primeiro >. segundo {
        True -> maior_float([primeiro, ..resto])
        False -> maior_float([segundo, ..resto])
      }
  }
}

pub fn retangulo_delimitador_examples() {
  check.eq(retangulo_delimitador([]), None)

  check.eq(
    retangulo_delimitador([Ponto(1.0, 2.0)]),
    Some(Retangulo(1.0, 1.0, 2.0, 2.0)),
  )

  check.eq(
    retangulo_delimitador([Ponto(1.0, 2.0), Ponto(4.0, 6.0), Ponto(2.0, 3.0)]),
    Some(Retangulo(1.0, 4.0, 2.0, 6.0)),
  )

  check.eq(
    retangulo_delimitador([Ponto(-2.0, 5.0), Ponto(3.0, -1.0), Ponto(0.0, 2.0)]),
    Some(Retangulo(-2.0, 3.0, -1.0, 5.0)),
  )
}

///
/// 23) Determina quantos itens de classe 1 são necessários
/// para construir um item da classe n
///
pub fn itens_classe(n: Int) -> Result(Int, Nil) {
  case n {
    _ if n < 1 || n > 10 -> Error(Nil)
    1 -> Ok(1)
    _ ->
      case itens_classe(n - 1) {
        Ok(quantidade) -> Ok(quantidade + quantidade)
        Error(Nil) -> Error(Nil)
      }
  }
}

pub fn itens_classe_examples() {
  check.eq(itens_classe(0), Error(Nil))
  check.eq(itens_classe(1), Ok(1))
  check.eq(itens_classe(2), Ok(2))
  check.eq(itens_classe(3), Ok(4))
  check.eq(itens_classe(4), Ok(8))
  check.eq(itens_classe(5), Ok(16))
  check.eq(itens_classe(10), Ok(512))
  check.eq(itens_classe(11), Error(Nil))
}

///
/// 25) Determina se *lsta* é prefixo de *lstb*
///
pub fn lista_prefixo(lsta: List(Int), lstb: List(Int)) -> Bool {
  case lsta, lstb {
    [], _ -> True
    [prima, ..resta], [primb, ..restb] ->
      case prima == primb {
        True -> lista_prefixo(resta, restb)
        False -> False
      }
    _, _ -> False
  }
}

pub fn lista_prefixo_examples() {
  check.eq(lista_prefixo([], []), True)
  check.eq(lista_prefixo([], [1, 2]), True)
  check.eq(lista_prefixo([1, 2], [1, 2]), True)
  check.eq(lista_prefixo([1, 2], [1, 2, 3]), True)
  check.eq(lista_prefixo([1, 2], [1]), False)
  check.eq(lista_prefixo([1, 2], []), False)
}

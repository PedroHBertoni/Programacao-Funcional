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
  int.to_float(tamanho_total) /. int.to_float(list.length(lst))
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
/// 14) Determina quantos nós tem uma árvore binária *ab*
///
pub fn quant_nos(ab: Arvore) {
  1
  + case ab.esq {
    None -> 0
    Some(ramo) -> quant_nos(ramo)
  }
  + case ab.dir {
    None -> 0
    Some(ramo) -> quant_nos(ramo)
  }
}

pub type Arvore {
  Arvore(valor: Int, esq: Option(Arvore), dir: Option(Arvore))
}

pub fn quant_nos_examples() {
  check.eq(quant_nos(Arvore(2, None, None)), 1)
  check.eq(quant_nos(Arvore(2, Some(Arvore(1, None, None)), None)), 2)
  check.eq(
    quant_nos(Arvore(
      2,
      Some(Arvore(1, None, None)),
      Some(Arvore(3, None, None)),
    )),
    3,
  )
}


///
/// 15) Retorna se uma árvore binária está cheia ou não, verificando se 
/// todos os nós possuem grau 0 ou 2
///
pub fn arvore_cheia(ab: Arvore) -> Bool {
  todo
}

/// auxiliar -> arvore_cheia
/// Retorna o Grau de um nó de uma árvore binária
pub fn grau_no(ab: Arvore) -> Int {
  todo
}
pub fn 

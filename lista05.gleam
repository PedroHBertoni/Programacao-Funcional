import gleam/int
import gleam/list
import sgleam/check

/// 6) Concatena todos os elementos String de *lista* 
pub fn concatena_lista(lista: List(String)) -> String {
  case lista {
    [] -> ""
    [primeiro, ..resto] -> primeiro <> concatena_lista(resto)
  }
}

pub fn concatena_lista_examples() {
  check.eq(concatena_lista([]), "")
  check.eq(concatena_lista(["Opa"]), "Opa")
  check.eq(concatena_lista(["Olá ", "Mundo"]), "Olá Mundo")
}

/// 7) Determina a quantidade de elementos duma lista de números
pub fn quantidade_elementos(lista: List(Int)) -> Int {
  case lista {
    [] -> 0
    [_primeiro, ..resto] -> 1 + quantidade_elementos(resto)
  }
}

pub fn quantidade_elementos_examples() {
  check.eq(quantidade_elementos([]), 0)
  check.eq(quantidade_elementos([0]), 1)
  check.eq(quantidade_elementos([1, -1]), 2)
}

/// 8) Converte uma lista de inteiros para lista de String
pub fn converte_inteiros(lista: List(Int)) -> List(String) {
  case lista {
    [] -> []
    [primeiro, ..resto] ->
      list.append([int.to_string(primeiro)], converte_inteiros(resto))
  }
}

pub fn converte_inteiros_examples() {
  check.eq(converte_inteiros([]), [])
  check.eq(converte_inteiros([1]), ["1"])
  check.eq(converte_inteiros([1, 2]), ["1", "2"])
}

/// 10) Indica se uma lista de booleanos apresenta só True
pub fn totalmente_true(lista: List(Bool)) -> Bool {
  case lista {
    [] -> True
    [primeiro, ..resto] -> primeiro && totalmente_true(resto)
  }
}

pub fn totalmente_true_examples() {
  check.eq(totalmente_true([]), True)
  check.eq(totalmente_true([True]), True)
  check.eq(totalmente_true([True, True]), True)
  check.eq(totalmente_true([False]), False)
  check.eq(totalmente_true([False, True]), False)
  check.eq(totalmente_true([True, False]), False)
}

/// 11) Verifica se a *lista* está em ordem não decrescente
pub fn nao_decresce(lista: List(Int)) -> Bool {
  case lista {
    [] -> True
    [_primeiro] -> True
    [primeiro, segundo, ..resto] ->
      primeiro <= segundo && nao_decresce(list.append([segundo], resto))
  }
}

pub fn nao_decresce_examples() {
  check.eq(nao_decresce([]), True)
  check.eq(nao_decresce([1]), True)
  check.eq(nao_decresce([1, 1, 1]), True)
  check.eq(nao_decresce([1, 2, 2]), True)
  check.eq(nao_decresce([1, 2, 1]), False)
}

/// 12) Inverte os elementos de uma lista
pub fn inverte_lista(lista: List) ->

pub fn aux_

import gleam/int
import sgleam/check

/// 1) O que significa dizer que funções são entidades de primeira classe?
///
///
/// 2) O que é uma função de alta ordem?
///
///
/// 3) Quando podemos utilizar as funções map, filter e foldr?
///
///
/// 4) Qual estratégia foi discutida para projetar funções que recebem funções como parâmetro?
///
///
/// 5) O que é uma variável livre?
///
///
/// 6) O que é um fechamento?
///
///
/// 7) Quando devemos utilizar funções anônimas?
///
///
/// 8) Qual é o uso mais comum para funções que produzem funções?
///
///
/// 9) 
///
/// 10) Aplica uma função *predicado* sobre os elementos de *lst* retornando quantos
/// elementos resultam a função como True
///
pub fn conta(lst: List(a), predicado: fn(a) -> Bool) -> Int {
  case lst {
    [] -> 0
    [a, ..resto] ->
      case predicado(a) {
        True -> 1 + conta(resto, predicado)
        False -> 0 + conta(resto, predicado)
      }
  }
}

pub fn conta_examples() {
  check.eq(conta([3, 1, 2, 4, 7], int.is_odd), 3)
}

import gleam/int
import sgleam/check

/// 1) O que significa dizer que funções são entidades de primeira classe?
/// Podem ser passadas como argumentos, retornadas e armazenadas como valores
///
/// 2) O que é uma função de alta ordem?
/// É uma função que recebe ou retorna outras funções
///
/// 3) Quando podemos utilizar as funções map, filter e foldr?
/// Quando precisamos transformar elementos, filtrar valores e combinar elementos de uma lista
///
/// 4) Qual estratégia foi discutida para projetar funções que recebem funções como parâmetro?
/// Identificamos comportamentos semelhantes e transformamos suas diferenças em parâmetros.
///
/// 5) O que é uma variável livre?
/// É uma variável que não é parâmetro, local ou global da função
///
/// 6) O que é um fechamento?
/// É uma função junto ao ambiente que contém referências às suas variáveis livres
///
/// 7) Quando devemos utilizar funções anônimas?
/// Quando precisamos de uma função simples e específica, geralmente usada em um único local
///
/// 8) Qual é o uso mais comum para funções que produzem funções?
/// Criar funções parametrizadas, fixando alguns de seus parâmetros
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

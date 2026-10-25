import gleam/int

import sgleam/check

/// 1) O que significa dizer que funções são entidades de primeira classe?
/// Podem ser passadas como argumentos, retornadas e armazenadas como valores. Também podem ser
/// construídas e tipas normalmente igual variáveis
///
/// 2) O que é uma função de alta ordem?
/// É uma função que recebe ou retorna outras funções
///
/// 3) Quando podemos utilizar as funções map, filter e foldr?
/// Quando precisamos transformar elementos, filtrar valores e combinar elementos de uma lista
/// por inteira
///
/// 4) Qual estratégia foi discutida para projetar funções que recebem funções como parâmetro?
/// Identificamos comportamentos semelhantes e transformamos suas diferenças em parâmetros.
///
/// 5) O que é uma variável livre?
/// É uma variável que não é parâmetro, local ou global da função
///
/// 6) O que é um fechamento?
/// É uma função junto ao ambiente léxico que contém referências às suas variáveis livres
///
/// 7) Quando devemos utilizar funções anônimas?
/// Quando uma função como parâmetro é simples e específica, geralmente usada em um único local
///
/// 8) Qual é o uso mais comum para funções que produzem funções?
/// Criar funções parametrizadas, fixando alguns de seus parâmetros
///
/// 9) 10 -> list.length(list.filter(lst))
/// 11 -> 
///
/// 10) Aplica uma função *predicado* sobre os elementos de *lst* retornando quantos
/// elementos resultam a função como True
///
/// 
pub fn conta(lst: List(a), pred: fn(a) -> Bool) -> Int {
  case lst {
    [] -> 0
    [a, ..r] ->
      case pred(a) {
        True -> 1 + conta(r, pred)
        False -> conta(r, pred)
      }
  }
}

pub fn conta_examples() {
  check.eq(conta([3, 1, 2, 4, 7], int.is_odd), 3)
}

///
/// 11) Aplica a função f, duas vezes
///
pub fn duas_vezes(f: fn(a) -> a) -> fn(a) -> a {
  fn(x) { f(f(x)) }
}

pub fn duas_vezes_examples() {
  check.eq(duas_vezes(fn(x) { x + 1 })(3), 5)
  check.eq(duas_vezes(fn(x) { x * 10 })(3), 300)
  check.eq(duas_vezes(fn(s) { s <> "!" })("Olá"), "Olá!!")
}

///
/// 12) Implementação list.map2, list.filter_map e list.fold_until
///
///list.map2
/// Combina os elementos de *lsta* e *lstb* mapeando de acordo com *f*,
/// se uma lista é maior que a outra, dropa os restantes
pub fn mapeia2(lsta: List(a), lstb: List(b), f: fn(a, b) -> c) -> List(c) {
  case lsta, lstb {
    [], _ | _, [] -> []
    [pa, ..ra], [pb, ..rb] -> [f(pa, pb), ..mapeia2(ra, rb, f)]
  }
}

pub fn mapeia2_examples() {
  check.eq(mapeia2([1, 2, 3], [4, 5, 6], fn(x, y) { x + y }), [5, 7, 9])
  check.eq(mapeia2([1, 2, 3], [4], fn(x, y) { x + y }), [5])
  check.eq(mapeia2([1], [4, 5, 6], fn(x, y) { x + y }), [5])
  check.eq(mapeia2([1, 2], ["a", "b", "c"], fn(i, x) { #(i, x) }), [
    #(1, "a"),
    #(2, "b"),
  ])
}

///list.filter_map
/// Retorna uma lista filtrando os elementos de *lst* mapeando todos com *f*
/// e deixando apenas aqueles que devolvem um Ok(_)
pub fn filtro_mapeia(lst: List(a), f: fn(a) -> Result(b, _)) -> List(b) {
  case lst {
    [] -> []
    [p, ..r] ->
      case f(p) {
        Ok(b) -> [b, ..filtro_mapeia(r, f)]
        Error(_) -> filtro_mapeia(r, f)
      }
  }
}

pub fn filtro_mapeia_examples() {
  check.eq(filtro_mapeia([2, 4, 6, 1], Error), [])
  check.eq(filtro_mapeia([2, 4, 6, 1], fn(x) { Ok(x + 1) }), [3, 5, 7, 2])
}

///
pub type ContinueOrStop(a) {
  Continue(a)
  Stop(a)
}

///list.fold_until
/// Combina os elementos de *lst* em um acumulador, começando em *init* e aplicando
/// *f* sobre cada elemento até chegar num caso de Stop(_)
pub fn reduz_ate(lst: List(a), init: b, f: fn(b, a) -> ContinueOrStop(b)) -> b {
  case lst {
    [] -> init
    [p, ..r] ->
      case f(init, p) {
        Continue(novo_init) -> reduz_ate(r, novo_init, f)
        Stop(resultado) -> resultado
      }
  }
}

pub fn reduz_ate_examples() {
  check.eq(
    reduz_ate([1, 2, 3, 4], 0, fn(acc, i) {
      case i < 3 {
        True -> Continue(acc + i)
        False -> Stop(acc)
      }
    }),
    3,
  )
  check.eq(
    reduz_ate([1, 2, 3, 4], 0, fn(acc, i) {
      case i < 0 {
        True -> Continue(acc + i)
        False -> Stop(acc)
      }
    }),
    0,
  )
  check.eq(
    reduz_ate([1], 0, fn(acc, i) {
      case i < 3 {
        True -> Continue(acc + i)
        False -> Stop(acc)
      }
    }),
    1,
  )
}

///
/// 13)
///
pub fn num_reduz()

pub fn _examples() {
  check.eq()
}

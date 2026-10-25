import gleam/list
import sgleam/check

/// 1) Quando devemos considerar o uso das estratégias de processamento simultâneo?
/// Quando a função tem dois ou mais argumentos com autorreferência, então analisamos
/// a melhor estratégia.
///
/// 2) Quais são as três estratégias de processamento simultâneo que foram estudadas?
/// Tratar um argumento como atômico, Processamento sincronizado, Combinar o modelo
/// para ambos os argumentos.
///
///
/// 3) Verifica se todos os elementos de *lsta* aparecem em *lstb*
/// 
pub fn contem(lsta: List(a), lstb: List(a)) -> Bool {
  case lsta {
    [] -> True
    [a, ..restoa] -> inserido(a, lstb) && contem(restoa, lstb)
  }
}

/// auxiliar -> contem()
/// Verifica se *elem* está em lst
pub fn inserido(elem: a, lst: List(a)) -> Bool {
  case lst {
    [] -> False
    [primeiro, ..resto] ->
      case primeiro == elem {
        True -> True
        False -> inserido(elem, resto)
      }
  }
}

pub fn contem_examples() {
  check.eq(contem([], []), True)
  check.eq(contem([], [1]), True)
  check.eq(contem([1], [1]), True)
  check.eq(contem([2], [1, 2, 3]), True)
  check.eq(contem([4], [1, 2, 3]), False)
  check.eq(contem([4], []), False)
}

///
/// 4) Retorna todas as possíveis duplas entre elementos de *lsta* e *lstb*
///
pub fn duplas(lsta: List(a), lstb: List(a)) -> List(List(a)) {
  case lsta {
    [] -> []
    [a, ..resto] -> {
      let lst_elem_a = duplas_elem(a, lstb)
      list.append(lst_elem_a, duplas(resto, lstb))
    }
  }
}

/// auxiliar -> duplas_list
/// Retorna todas as duplas com *elem* e os elementos de *lst*
pub fn duplas_elem(elem: a, lst: List(a)) -> List(List(a)) {
  case lst {
    [] -> []
    [prim, ..resto] -> [[elem, prim], ..duplas_elem(elem, resto)]
  }
}

pub fn duplas_list_examples() {
  check.eq(duplas([3, 1, 8], [7, 4]), [
    [3, 7],
    [3, 4],
    [1, 7],
    [1, 4],
    [8, 7],
    [8, 4],
  ])
  check.eq(duplas([], []), [])
  check.eq(duplas([1], []), [])
  check.eq(duplas([], [2]), [])
  check.eq(duplas([1], [2]), [[1, 2]])
}

///
/// 5) Retorna apenas os nomes de *lsta* correspondentes em index àos booleanos
/// em *lstb* iguais a True
/// 
pub fn seleciona(lsta: List(String), lstb: List(Bool)) -> List(String) {
  case lsta, lstb {
    [], _ | _, [] -> []
    [a, ..restoa], [b, ..restob] ->
      case b {
        True -> [a, ..seleciona(restoa, restob)]
        False -> seleciona(restoa, restob)
      }
  }
}

pub fn seleciona_examples() {
  check.eq(seleciona([], []), [])
  check.eq(seleciona(["Pedro"], [True, True]), ["Pedro"])
  check.eq(seleciona(["Pedro", "Wagner"], [True]), ["Pedro"])
  check.eq(
    seleciona(["Jorge", "Amanda", "Pedro", "Joana"], [True, False, False, True]),
    ["Jorge", "Joana"],
  )
}

///
/// 6) Verifica se *lsta* é igual *lstb*
///
pub fn igualdade(lsta: List(Int), lstb: List(Int)) -> Bool {
  case lsta, lstb {
    [], [] -> True
    [a, ..restoa], [b, ..restob] -> a == b && igualdade(restoa, restob)
    _, _ -> False
  }
}

pub fn igualdade_examples() {
  check.eq(igualdade([], []), True)
  check.eq(igualdade([1], []), False)
  check.eq(igualdade([], [1]), False)
  check.eq(igualdade([1, 3, 2], [2, 1, 3]), False)
  check.eq(igualdade([1, 2, 3], [1, 2, 3]), True)
}

///
/// 7) Verifica se *lsta* tem mais elementos que *lstb* 
///
pub fn maior_tamanho(lsta: List(a), lstb: List(a)) -> Bool {
  case lsta, lstb {
    [], _ -> False
    _, [] -> True
    [_, ..restoa], [_, ..restob] -> maior_tamanho(restoa, restob)
  }
}

pub fn maior_tamanho_examples() {
  check.eq(maior_tamanho([1, 2], [1]), True)
  check.eq(maior_tamanho([1], []), True)
  check.eq(maior_tamanho([1, 2], [1, 2]), False)
  check.eq(maior_tamanho([1], [1, 2]), False)
}

///
/// 8) Devolve *lst* com apenas seus *n* primeiros elementos
///
pub fn mantem(lst: List(a), n: Int) -> List(a) {
  case lst {
    _ if n <= 0 -> []
    [] -> []
    [primeiro, ..resto] -> [primeiro, ..mantem(resto, n - 1)]
  }
}

pub fn mantem_examples() {
  check.eq(mantem([], 3), [])
  check.eq(mantem([5, 6, 7], 0), [])
  check.eq(mantem([10, 40, 70, 20, 3], 2), [10, 40])
}

///
/// 9) Devolve *lst* retirando seus *n* primeiros elementos
///
pub fn descarta(lst: List(a), n: Int) -> List(a) {
  case lst {
    _ if n <= 0 -> lst
    [] -> []
    [_, ..resto] -> descarta(resto, n - 1)
  }
}

pub fn descarta_examples() {
  check.eq(descarta([], 2), [])
  check.eq(descarta([10, 20], 2), [])
  check.eq(descarta([10, 20], 0), [10, 20])
  check.eq(descarta([10, 40, 70, 20, 3], 2), [70, 20, 3])
}

///
/// 10) Devolve *lst* retirando o elemento no index *n*
///
pub fn remove_em(lst: List(a), n: Int) -> Result(List(a), Nil) {
  case lst {
    _ if n < 0 -> Error(Nil)
    [] -> Error(Nil)
    [_, ..resto] if n == 0 -> Ok(resto)
    [primeiro, ..resto] ->
      case remove_em(resto, n - 1) {
        Ok(removido) -> Ok([primeiro, ..removido])
        Error(_) -> Error(Nil)
      }
  }
}

pub fn remove_em_examples() {
  check.eq(remove_em([], -1), Error(Nil))
  check.eq(remove_em([2], 1), Error(Nil))
  check.eq(remove_em([2], 0), Ok([]))
  check.eq(remove_em([3, 6, 1, 2], 2), Ok([3, 6, 2]))
}

///
/// 11) Devolve *lst* adicionando o elemento no index *n*
///
pub fn insere_em(lst: List(a), elem: a, n: Int) -> Result(List(a), Nil) {
  case lst {
    _ if n < 0 -> Error(Nil)
    [] if n == 0 -> Ok([elem])
    [] -> Error(Nil)
    [primeiro, ..resto] if n == 0 -> Ok([elem, primeiro, ..resto])
    [primeiro, ..resto] ->
      case insere_em(resto, elem, n - 1) {
        Ok(inserido) -> Ok([primeiro, ..inserido])
        _ -> Error(Nil)
      }
  }
}

pub fn insere_em_examples() {
  check.eq(insere_em([], 5, -1), Error(Nil))
  check.eq(insere_em([], 5, 1), Error(Nil))
  check.eq(insere_em([], 5, 0), Ok([5]))
  check.eq(insere_em([3, 6], 5, 0), Ok([5, 3, 6]))
  check.eq(insere_em([3, 6], 5, 2), Ok([3, 6, 5]))
  check.eq(insere_em([3, 6, 1, 2], 5, 2), Ok([3, 6, 5, 1, 2]))
}

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

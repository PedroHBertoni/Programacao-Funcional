import gleam/string

pub fn area_retangulo(altura: Float, largura: Float) -> Float {
  altura *. largura
}

pub fn produto_anterior_posterior(n: Int) -> Int {
  { n - 1 } * n * { n + 1 }
}

pub fn eh_par(n: Int) -> Bool {
  { n % 2 } == 0
}

pub fn tem_tres_digitos(n: Int) -> Bool {
  { n >= 100 } && { n <= 999 }
}

pub fn maximo(x: Int, y: Int) -> Int {
  case x >= y {
    True -> x
    False -> y
  }
}

pub fn ordem(a: Int, b: Int, c: Int) -> String {
  case a > b {
    True ->
      case b > c {
        True -> "Descrescente"
        False -> "Sem Ordem"
      }
    False ->
      case b < c {
        True -> "Crescente"
        False -> "Sem Ordem"
      }
  }
}

pub fn so_primeira_maiuscula(palavra: String) -> String {
  string.uppercase(string.slice(palavra, 0, 1))
  <> string.lowercase(string.slice(palavra, 1, 20))
}

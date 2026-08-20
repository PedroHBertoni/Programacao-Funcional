import gleam/string
import sgleam/check

/// Produz True se uma pessoa com *idade* é isento da
/// tarifa de transporte público, isto é, tem menos
/// que 18 anos ou 65 ou mais. Produz False caso contrário.
pub fn isento_tarifa(idade: Int) -> Bool {
  idade < 18 || idade >= 65
}

pub fn isento_tarifa_examples() {
  check.eq(isento_tarifa(17), True)
  check.eq(isento_tarifa(18), False)
  check.eq(isento_tarifa(50), False)
  check.eq(isento_tarifa(65), True)
  check.eq(isento_tarifa(70), True)
}

/// Conta a quantidade de dígitos de *n*.
/// Se *n* é 0, então devolve zero.
/// Se *n* é menor que zero, então devolve a quantidade
/// de dígitos do valor absoluto de *n*.
pub fn quantidade_digitos(n: Int) -> Int {
  case n == 0 {
    True -> 0
    False -> 1 + quantidade_digitos(n / 10)
  }
}

pub fn quantidade_digitos_examples() {
  check.eq(quantidade_digitos(123), 3)
  check.eq(quantidade_digitos(0), 0)
  check.eq(quantidade_digitos(-1519), 4)
}

/// Produz True se uma pessoa com *idade* é supercentenária,
/// isto é, tem 110 anos ou mais, False caso contrário.
pub fn supercentenario(idade: Int) -> Bool {
  idade >= 110
}

pub fn supercentenario_examples() {
  check.eq(supercentenario(101), False)
  check.eq(supercentenario(110), True)
  check.eq(supercentenario(112), True)
}

/// Transforma a string *data* que está no formato "dia/mes/ano"
/// para o formato "ano/mes/dia".
///
/// Requer que o dia e o mês tenham dois dígitos e que
/// o ano tenha quatro dígitos.
pub fn dma_para_amd(data: String) -> String {
  string.slice(data, 6, 4)
  <> string.slice(data, 2, 4)
  <> string.slice(data, 0, 2)
}

pub fn dma_para_amd_examples() {
  check.eq(dma_para_amd("19/07/2023"), "2023/07/19")
  check.eq(dma_para_amd("01/01/1980"), "1980/01/01")
  check.eq(dma_para_amd("02/02/2002"), "2002/02/02")
}

/// Transforma o *valor* pelo seu acréscimo percentual de
/// *porcentagem*.
pub fn aumenta(valor: Float, porcentagem: Float) -> Float {
  valor *. { 1.0 +. porcentagem /. 100.0 }
}

pub fn aumenta_examples() {
  check.eq(aumenta(100.0, 20.0), 120.0)
  check.eq(aumenta(100.0, 100.0), 200.0)
  check.eq(aumenta(100.0, -20.0), 80.0)
}

/// Retorna "curto" caso *nome* possua 4 letras ou menos, senão
/// retorna "médio", caso possua 10 letras ou menos e caso.
/// contrário retorna "longo".
pub fn tamanho_nome(nome: String) -> String {
  case string.length(nome) <= 4 {
    True -> "curto"
    False ->
      case string.length(nome) <= 10 {
        True -> "médio"
        False -> "longo"
      }
  }
}

pub fn tamanho_nome_examples() {
  check.eq(tamanho_nome("pepi"), "curto")
  check.eq(tamanho_nome("munir"), "médio")
  check.eq(tamanho_nome("dez_letras"), "médio")
  check.eq(tamanho_nome("onze_letras"), "longo")
}

/// Transforma *frase* colocando um ponto final em seu fim, caso
/// não possua.
pub fn formata_ponto(frase: String) -> String {
  case
    string.slice(
      frase,
      {
        string.length(frase)
        -1
      },
      1,
    )
    == "."
  {
    True -> frase
    False -> frase <> "."
  }
}

pub fn formata_ponto_examples() {
  check.eq(formata_ponto("Hello World"), "Hello World.")
  check.eq(formata_ponto("Olá Mundo."), "Olá Mundo.")
  check.eq(formata_ponto(""), ".")
}

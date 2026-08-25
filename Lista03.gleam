import gleam/string
import sgleam/check

/// 13)
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

/// 14)
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

/// 15)
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

/// 16)
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

/// 17)
/// Transforma o *valor* pelo seu acréscimo percentual de
/// *porcentagem*, retornando com esse aumento.
pub fn aumenta(valor: Float, porcentagem: Float) -> Float {
  valor *. { 1.0 +. porcentagem /. 100.0 }
}

pub fn aumenta_examples() {
  check.eq(aumenta(100.0, 20.0), 120.0)
  check.eq(aumenta(100.0, 100.0), 200.0)
  check.eq(aumenta(100.0, -20.0), 80.0)
}

/// 18)
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

/// 19)
/// Transforma *frase* colocando um ponto final em seu fim, caso
/// não possua, caso possua retorna *frase* diretamente.
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

/// 20)
/// Retorna True se *palavra* tem um '-' na sua escrita.
pub fn verifica_traco(palavra: String) -> Bool {
  case string.slice(palavra, 0, 1) == "" {
    True -> False
    False ->
      case string.slice(palavra, 0, 1) == "-" {
        True -> True
        False ->
          verifica_traco(string.slice(palavra, 1, string.length(palavra)))
      }
  }
}

pub fn verifica_traco_examples() {
  check.eq(verifica_traco("lero-lero"), True)
  check.eq(verifica_traco("girassol"), False)
  check.eq(verifica_traco("Guarda-Chuva"), True)
}

/// 21)
/// Retorna qual entre *num1*, *num2* e *num3* representa maior valor
pub fn retorna_maior(num1: Int, num2: Int, num3: Int) -> Int {
  case num1 > num2 {
    True ->
      case num1 > num3 {
        True -> num1
        False -> num3
      }
    False ->
      case num2 > num3 {
        True -> num2
        False -> num3
      }
  }
}

pub fn retorna_maior_examples() {
  check.eq(retorna_maior(1, 2, 3), 3)
  check.eq(retorna_maior(3, 2, 1), 3)
  check.eq(retorna_maior(1, 3, 2), 3)
}

/// 22)
/// Retorna *palavra*, porém alterados seus primeiros *n*
/// caracteres para 'x'. Essa alteração não considera tamanho 
/// *n* que extrapole a palavra, retornando tudo como 'x'.
pub fn troca_caracteres_por_x(palavra: String, n: Int) -> String {
  case n > 0 && string.length(palavra) != 0 {
    True ->
      "x"
      <> troca_caracteres_por_x(
        string.slice(palavra, 1, string.length(palavra)),
        n - 1,
      )
    False -> palavra
  }
}

pub fn troca_caracteres_por_x_examples() {
  check.eq(troca_caracteres_por_x("Pedro Henrique", 5), "xxxxx Henrique")
  check.eq(troca_caracteres_por_x("André", 25), "xxxxx")
}

/// R E S O L V E N D O   P R O B L E M A S
///
/// 23)
/// Retorna uma verificação se *texto* começa ou termina com
/// " ", retornando True caso NÃO possua.
pub fn sem_espacos_extras(texto: String) -> Bool {
  string.slice(texto, 0, 1) != " "
  && string.slice(
    texto,
    {
      string.length(texto)
      -1
    },
    1,
  )
  != " "
}

pub fn sem_espacos_extras_examples() {
  check.eq(sem_espacos_extras("Hello World"), True)
  check.eq(sem_espacos_extras(" Hello World"), False)
  check.eq(sem_espacos_extras("Hello World "), False)
  check.eq(sem_espacos_extras(" Hello World "), False)
  check.eq(sem_espacos_extras(""), True)
}

/// 24)
/// Traz os impostos com base no *dinheiro*
/// -Para 0 < dinheiros < 1000, 5% de imposto sobre
/// -Para 1000 < dinheiros < 5000, 10% de imposto sobre
/// -Para 5000 < dinheiros, 20% de imposto sobre
/// Retornando a soma de todos os impostos calculados com
/// valor até completar *dinheiro*
///
/// Requer *dinheiro* positivo.
pub fn calcula_impostos(dinheiro: Float) -> Float {
  case { dinheiro -. 5000.0 } >. 0.0 {
    True ->
      { { dinheiro -. 5000.0 } *. 0.2 }
      +. { 4000.0 *. 0.1 }
      +. { 1000.0 *. 0.05 }
    False ->
      case { dinheiro -. 1000.0 } >. 0.0 {
        True -> { { dinheiro -. 1000.0 } *. 0.1 } +. { 1000.0 *. 0.05 }
        False -> dinheiro *. 0.05
      }
  }
}

pub fn calcula_impostos_examples() {
  check.eq(calcula_impostos(1000.0), 50.0)
  check.eq(calcula_impostos(4000.0), 350.0)
  check.eq(calcula_impostos(5000.0), 450.0)
  check.eq(calcula_impostos(7000.0), 850.0)
}

/// 25)
/// Verifica se *palavra* é formada pela duplicação de uma palavra
/// menor, caso possua um hífen na sua metade, analisa suas partes
/// sem ele. Retornando True, caso seja uma palavra duplicada.
pub fn verifica_duplicacao(palavra: String) -> Bool {
  case string.slice(palavra, { string.length(palavra) } / 2, 1) == "-" {
    True ->
      string.slice(palavra, 0, { string.length(palavra) } / 2)
      == string.slice(
        palavra,
        { { string.length(palavra) } / 2 } + 1,
        { string.length(palavra) } / 2,
      )
    False ->
      string.slice(palavra, 0, { string.length(palavra) } / 2)
      == string.slice(
        palavra,
        { div_teto({ string.length(palavra) }, 2) },
        { string.length(palavra) } / 2,
      )
  }
}

/// Função auxiliar usada para ter uma divisão teto entre dois
/// valores inteiros, retorando um resultante inteiro. Ou seja,
/// para divisão não inteira, seu valor é arredondado para cima.
pub fn div_teto(numerador: Int, denominador: Int) -> Int {
  { numerador + denominador - 1 } / denominador
}

pub fn div_teto_examples() {
  check.eq(div_teto(6, 2), 3)
  check.eq(div_teto(5, 2), 3)
  check.eq(div_teto(4, 2), 2)
}

pub fn verifica_duplicacao_examples() {
  check.eq(verifica_duplicacao("mimi"), True)
  check.eq(verifica_duplicacao("lero-lero"), True)
  check.eq(verifica_duplicacao("arara"), False)
}


/// 26)
/// Retorna o número de azulejos inteiros necessários para ocupar
/// uma área de acordo com *altura* e *comprimento*. Azulejos que
/// não são usados inteiramente ainda são contados.
pub fn calcula_azulejos(altura: Float, comprimento: Float) -> Int

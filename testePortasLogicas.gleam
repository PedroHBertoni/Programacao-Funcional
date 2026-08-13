pub fn custo_combustivel(distancia, preco_do_litro, rendimento) {
  { distancia /. rendimento } *. preco_do_litro
}

pub fn not(x) {
  case x {
    True -> False
    False -> True
  }
}

pub fn buffer(x) {
  case x {
    True -> True
    False -> False
  }
}

pub fn and(x, y) {
  case x {
    False -> False
    True ->
      case y {
        True -> True
        False -> False
      }
  }
}

pub fn or(x, y) {
  case x {
    True -> True
    False ->
      case y {
        True -> True
        False -> False
      }
    //Acho q podia retornar y direto
  }
}

pub fn nand(x, y) {
  case x {
    False -> True
    True ->
      case y {
        True -> False
        False -> True
      }
  }
}

pub fn nor(x, y) {
  case x {
    True -> False
    False ->
      case y {
        True -> False
        False -> True
      }
  }
}

pub fn xor(x, y) {
  case x {
    True ->
      case y {
        True -> False
        False -> True
      }
    False ->
      case y {
        True -> True
        False -> False
      }
    //Acho q podia retornar y direto
  }
}

pub fn xnor(x, y) {
  case x {
    True ->
      case y {
        True -> True
        False -> False
      }
    //Acho q podia retornar y direto
    False ->
      case y {
        True -> False
        False -> True
      }
  }
}

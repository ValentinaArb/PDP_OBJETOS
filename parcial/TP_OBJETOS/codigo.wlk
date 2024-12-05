// class Espada  {
//   var property poderBase = 0
  
//   method poder() {
//     const poder = poderBase*10
//     return poder
//   }
// }

// const espadaElfica = new Espada(poderBase=25)
// const espadaEnana = new Espada(poderBase=20)
// const espadaHumana = new Espada(poderBase=10)
class EspadaElfica{
  const property poderBase = 25
  var poder = 0
  method poder(){
    poder = poderBase*10
    return poder 
  }
}
  class EspadaEnana{
  const property poderBase = 20
  var poder = 0
  method poder(){
    poder = poderBase*10
    return poder 
  }
  }
  class EspadaHumana{
  const property poderBase = 15
  var poder = 0
  method poder(){
    poder = poderBase*10
    return poder 
  }
  }

class Baculo {
  const poder = 400
  method poder () = poder
}

object gandalf {
  var property vida = 100
  var poder = 0
  const glamdring = new EspadaElfica() 
  const baculo = new Baculo ()

  var property armas = #{glamdring,baculo}
  method vida (_vida) {
    vida = _vida.max(0).min(100)
    }
  
  method poder () {
    var poderArmas =  armas.sum { arma => arma.poder() }
    var multiplicativoPoder = 0
    if (vida < 10) { 
      multiplicativoPoder = 300
      }
    else {
      multiplicativoPoder = 15
      }
      poder = vida * multiplicativoPoder + poderArmas*2
      return poder
  }
  //method puedeAtravesar(Zona)
}
// class Zona{
//   const guerrero = #{gandalf,tomBombadil}
//   var property poderMinimo = 0
//   var property cantMinimaDeArmas = 0
//   var property vidaPerdida = 0
  
//   method efecto(){
//       guerrero.vida(guerrero.vida - vidaPerdida)
//   }
// }
// const lebennin = new Zona(poderMinimo = 1500)
object lebennin {
  method puedeAtravesar(guerrero){
    return guerrero.poder() > 1500
  }
  method efecto(guerrero){
  }
}

object minasTirith {
  method puedeAtravesar(guerrero){
    return guerrero.armas().size() > 0
  }
  method efecto(guerrero){
    const vida = guerrero.vida()
    guerrero.vida(vida - 10)
  }
}

object lossarnach {
  method puedeAtravesar(guerrero){
    return true
  }
  method efecto(guerrero) {
    const vida = guerrero.vida()
    guerrero.vida(vida + 1)
  }
}

class Camino {
  var property zonas = []

  method puedeAtravesar(guerrero) {
      return zonas.all { zona => zona.puedeAtravesar(guerrero) }
  }

  method efecto(guerrero) {
  zonas.forEach { zona => zona.efecto(guerrero)}
  }
}

object tomBombadil {
  var property vida = 100
  method vida (_vida) {
    vida = _vida.max(0).min(100)
    }
  method puedeAtravesar(zona) {
    return true
  }

  method efecto(zona) {
  }
}

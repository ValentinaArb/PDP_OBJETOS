import personas.*

class Saludable inherits Sobreviviente{
  override method efectoAtacar(){}
  override method efectoComer(){}
}

class Arrebatado inherits Sobreviviente{
  override method efectoAtacar(){
    carisma += 1
  }

  override method efectoComer(){
    resistencia += 50
    carisma += 20
  }
}

class Infectado inherits Sobreviviente{
  var cantidadVecesInfectado = 0
  override method efectoAtacar(){
    cantidadVecesInfectado += 1
    resistencia -= puntosDeAtaque.puntos() - 3
    if(cantidadVecesInfectado >= 5){
      self.cambiarEstado(Desmayado)
    }
  }

  override method efectoComer(){
    resistencia += 40
    if(cantidadVecesInfectado >= 3){
      cantidadVecesInfectado = 0
    }
    else{
      self.cambiarEstado(Saludable)
    }
  }
}

class Desmayado inherits Sobreviviente{
  override method efectoAtacar(){}
  override method efectoComer(){
    self.cambiarEstado(Saludable)
  }
}
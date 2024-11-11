import estados.*

class Caminante{
  var sedDeSangre
  var estaSomnoliento 
  const cantidadDientes
  
  method poderCorrosivo() = 2 * sedDeSangre + cantidadDientes

  method estaDebil() = sedDeSangre < 15 && estaSomnoliento
}

object puntosDeAtaque{
  var property puntos = 2 
}

class Sobreviviente{
  var resistencia
  var property carisma
  var estado = Saludable
  const puntosBaseSobreviviente

  const armas = []

  method eliminarArmas() = armas.removeAllSuchThat(true)

  method aniadirArmas(conjuntoArmas) = armas + conjuntoArmas //2.b
  
  method poderPropio(){
    return puntosBaseSobreviviente * (1 + carisma / 100)
  }

  method poderOfensivo(){
    armas.any{arma => arma.poderOfensivo()} + self.poderPropio()
  }

  method cambiarEstado(nuevoEstado) {
    estado = nuevoEstado
  }

  method condicionAtaque() = resistencia > 12

  method efectoAtacar()
  method efectoComer()

  method consumirGuarnicion() = self.efectoComer() //2.a

  method atacar(caminante){ //punto 1.b
    if(self.condicionAtaque()){
      resistencia -= puntosDeAtaque.puntos()
      self.efectoAtacar()
    }
  }

  method noTieneArmaRuidosa(){
    !armas.any{arma => arma.tipo() == "ruidosa"} //seguro está mal como implementé ruidosa y silenciosa, antes lo pensé como un object pero no sabia como plantearlo
  }
}

class Predadores inherits Sobreviviente{

  const caminantesEsclavizados = #{}
  
  override method atacar(caminante){
    super(caminante)
    self.esclavizar(caminante)
  }

  method esclavizar(caminante){
    if(caminante.estaDebil()){
      caminantesEsclavizados.add(caminante)
    }
  }

  method poderCorrosivoEsclavos() = caminantesEsclavizados.sum{caminante => caminante.poderCorrosivo()}

  override method poderOfensivo(){
    super()/2 + self.poderCorrosivoEsclavos()
  }
}

 
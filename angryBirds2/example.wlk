object isla{
  const pajarosIsla = #{}
  const fuertes = pajarosIsla.filter{pajaro => pajaro.esFuerte()}
  method fuerzaIsla() = fuertes.sum{pajaroFuerte => pajaroFuerte.fuerza()}

  method atacarIslaCerdito(){
    const obstaculo = islaCerdito.obstaculos.min{obstaculo => obstaculo.distancia()}
    const pajaroElegido = pajarosIsla.anyOne()
    pajaroElegido.puedeDerribar(obstaculo)
  }
}

class Pajaro{  
  var property ira = 0  

  method enojo()
  method fuerza()

  method esFuerte() = self.fuerza() > 50  

  method tranquilizar(){
    self.ira() - 5
  }

  method puedeDerribar(obstaculo){
    if(self.fuerza() > obstaculo.resistencia()){
      islaCerdito.derribarObstaculo(obstaculo)
    }
  }

  method huevosRecuperados() = islaCerdito.sinObstaculos()
}

class PajaroComun inherits Pajaro{
  override method fuerza() = ira * 2
}

class PajaroRencoroso inherits Pajaro{
  const cantidadEnojos = 0
  const multiplicador = 0
  override method fuerza() = ira * multiplicador * cantidadEnojos
}

object red inherits PajaroRencoroso(multiplicador = 10){
  override method enojo(){}
}

object bomb inherits PajaroComun{
  var limite = 9000
  override method fuerza() = self.fuerza().min(limite)
  override method enojo(){}
}

object chuck inherits PajaroComun{
  var velocidad = 0
  override method fuerza() = 150 + (5 * (velocidad - 80).max(0))
  override method enojo(){
    velocidad *= 2
  }

  override method tranquilizar(){}

}

object matilda inherits PajaroComun{
  var huevos = []
  override method fuerza() = super() + self.fuerzaHuevos()
  override method enojo(){
  }
  method fuerzaHuevos() = huevos.sum{huevo => huevo.fuerza()}
  method ponerHuevo(peso){
    huevos.add(peso) //deberia agregarse un huevo pero no se bien how
  }
}

class Huevo{
  const property peso
  method fuerza() = peso
}

class Evento{
  method manejoDeIra() = isla.pajarosIsla.forEach{pajaro => pajaro.tranquilizar()}

  method invasionCerditos(cantidad){
    const vecesARepetir = (cantidad/100)
    vecesARepetir.times { index => isla.pajarosIsla.forEach{pajaro => pajaro.enojar()}} 
  }

  method fiestaSorpresa(){
    //homenajeados?
  }

  method aplicarEvento(evento) = isla.pajarosIsla.forEach{pajaro => pajaro.evento()}

  method serieDeEventos(){
    const eventos = []    
    eventos.forEach{evento => self.aplicarEvento(evento)}
  } 
}

object islaCerdito{
  var obstaculos = []

  method derribarObstaculo(obstaculo) = obstaculos.remove(obstaculo)

  method sinObstaculos() = obstaculos.isEmpty()
}

class Obstaculo{
  method distancia() = 10 // no se como poner la distancia, no la espeficica nunca
  method resistencia()
}
class Pared inherits Obstaculo{
  const multiplicador
  const anchoPared = 20

  override method resistencia() = multiplicador * anchoPared
}

object paredVidrio inherits Pared(multiplicador=10){}
object paredMadera inherits Pared(multiplicador=25){}
object paredPiedra inherits Pared(multiplicador=50){}

object cerditoObrero inherits Obstaculo{
  override method resistencia() = 50
} 

class CerditoArmado inherits Obstaculo{
  method resistenciaExtra()
  override method resistencia() = 10 * self.resistenciaExtra()
}

class CerditoCasco inherits CerditoArmado{
  const resistenciaCasco
  override method resistenciaExtra() = resistenciaCasco
}

class CerditoEscudo inherits CerditoArmado{
  const resistenciaEscudo
  override method resistenciaExtra() = resistenciaEscudo
}
class Jugador{
  const nombre
  var edad
  var peso
  var altura
  var posicion = Posicion

  method mideMasDe(alturaComparar) = altura > alturaComparar  
  method cambiarPosicion(nuevaPosicion){
    posicion = nuevaPosicion
    nuevaPosicion.cambioDePosicion()
  } 
  method nombreTerminaCon(palabra) = nombre.endsWith(palabra)

  method esEstrella() = posicion.esEstrella(self)
  method habilidad() = posicion.habilidad()

  method jugar() {
		posicion.jugar()
	}
}

class Posicion{
  var goles
  var partidosJugados  

  method jugar() {
		partidosJugados += 1
	}
  method cambioDePosicion(){
    goles = 0
    partidosJugados = 0 
  }
  method promedioGoles() = goles / partidosJugados
  method esEstrella(jugador)
  method compararMayor(mayor,numero) = mayor > numero
  method habilidad()  
}

class Arquero inherits Posicion{
  var golesContra
  override method esEstrella(jugador){
      return (self.compararMayor(partidosJugados,100) && self.compararMayor(0.8,self.promedioGoles())) || jugador.mideMasDe(1.90)
    }

  override method habilidad() = partidosJugados * 2 + goles * 500 - golesContra
}

class Defensor inherits Posicion{
  var amarillas = 0
  var rojas = 0
  method promedioAmarillas() = amarillas / partidosJugados

  override method esEstrella(jugador){
    return self.compararMayor(partidosJugados,149) && self.compararMayor(0.5,self.promedioAmarillas()) && self.compararMayor(rojas,4)
  }

  override method habilidad() = partidosJugados * 3 + goles * 5 - amarillas - rojas * 10
}

class MedioCampista inherits Posicion{
  var asistencias = 0
  var jugoConSuSeleccion
  

  override method esEstrella(jugador){
    return (self.compararMayor(partidosJugados,250) && self.compararMayor(goles,19) && self.compararMayor(asistencias,79) && jugoConSuSeleccion) || jugador.nombreTerminaCon("inho")
  }

  override method habilidad() {
    var auxiliar = 0
    if(jugoConSuSeleccion){
      auxiliar = 100
    }
   partidosJugados * + goles * 2 + asistencias * 3  + auxiliar
  }
  
}

class Delantero inherits Posicion{
  override method esEstrella(jugador) = true

  override method habilidad() = 1500
}


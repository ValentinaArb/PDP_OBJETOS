class Jugador{
  const nombre
  var edad
  var peso
  var altura

  var property posicion = Posicion

  method cambiarPosicion(nuevaPosicion){
    self.posicion(nuevaPosicion)
    nuevaPosicion.resetearEstadisticas()
  }
  
  method mideMasDe(alturaComparar) = altura > alturaComparar 
  
  method nombreTerminaCon(palabra) = nombre.endsWith(palabra)
}

class Posicion{
 var goles = 0 //recibidos o hechos segun la posicion
 var property partidosJugados = 0 

  method resetearEstadisticas(){
    goles = 0
    partidosJugados = 0
  }

  method esEstrella(jugador)
  method habilidad()
}

class Arquero inherits Posicion{
  var golesAFavor
  method promedioGoles() = goles/partidosJugados
  override method esEstrella(jugador){
    return (partidosJugados > 100 && self.promedioGoles() < 0.8) || jugador.mideMasDe(1.9)
  }
  override method habilidad(){
    return partidosJugados * 2 + golesAFavor * 500 - goles
  }
}

class Defensor inherits Posicion{
  var amarillas
  var rojas
  method promedioAmarillas() = amarillas/partidosJugados

  override method esEstrella(jugador){
    return partidosJugados >= 150 && self.promedioAmarillas() < 0.5 && rojas >= 5
  }

  override method habilidad(){
    return partidosJugados * 3 + goles * 5 - amarillas - rojas * 10
  }
}

class MedioCampista inherits Posicion{
  var asistencias
  var jugoEnLaSeleccion

  override method esEstrella(jugador){
    return (partidosJugados > 250 && goles > 20 && asistencias > 80 && jugoEnLaSeleccion) || jugador.nombreTerminaCon("inho")
  }
  
  override method habilidad(){
    var extra = 0
    if(jugoEnLaSeleccion){
      extra = 100
    }
    return partidosJugados + goles * 2 + asistencias * 3 + extra
  }

  method jugoEnLaSeleccion(){
    jugoEnLaSeleccion = true
  } 

}

class Delantero inherits Posicion{
  override method esEstrella(jugador) = true
  override method habilidad() = 1500
}


class Equipo{
  const cantidadJugadoresLimite = 11

  const equipo = #{}
  method cantidadJugadores() = equipo.size()
  method cantidadJugadoresEstrellas() = equipo.filter{jugador => jugador.posicion().esEstrella()}

  method habilidadJugadores() = equipo.sum{jugador => jugador.posicion().habilidad()}

  const cantidadEstrellasAdmitidas

  method equipoLleno() = self.cantidadJugadores() == cantidadJugadoresLimite
  method estrellasLlenas() = self.cantidadJugadoresEstrellas() == cantidadEstrellasAdmitidas

  method agregarJugador(jugador){
    if(self.equipoLleno()){
      self.error("el equipo está completo")
    }
    else if(jugador.posicion().esEstrella(jugador) && self.estrellasLlenas()){
      self.error("no pueden haber más estrellas")
    }
    else{
      equipo.add(jugador)
    }
  }

  method ganar(){
    ganados +=1
  }
  method perder(){
    perdidos +=1
  }
  method empatar(){
    empatados+=1
  }
  var ganados = 0
  var perdidos = 0
  var empatados = 0

  method jugo(){
    equipo.forEach{jugador => jugador.posicion().partidosJugados() + 1}
    
    const medioCampistas = equipo.filter{jugador => jugador.posicion() == MedioCampista}
    
    medioCampistas.forEach{jugador => jugador.jugoEnLaSeleccion()}
  }
}

object equiposPro inherits Equipo(cantidadEstrellasAdmitidas = 9){}
object equiposMedioPelo inherits Equipo(cantidadEstrellasAdmitidas = 3){}
object brasil inherits Equipo(cantidadEstrellasAdmitidas = cantidadJugadoresLimite){}



class Partido{
  var equipoLocal
  var equipoVisitante

  method mejorEquipo(local,visitante){
    if(local.habilidadJugadores() > visitante.habilidadJugadores()){
      return 5
    }else{
      return 0
    }
  }

  method puntoLocal() = 1

  method puntoEstrellas(equipo) = equipo.cantidadJugadoresEstrellas()

  method puntosLocal(local,visitante){
    return self.puntoEstrellas(local) + self.mejorEquipo(local,visitante) + self.puntoLocal()
  }

  method puntosVisitante(local,visitante){
    return self.puntoEstrellas(visitante) + self.mejorEquipo(visitante,local)
  }

  method resultado(local,visitante){
    if(self.puntosLocal(local,visitante) > (self.puntosVisitante(local,visitante))){
      equipoLocal.ganar()
      equipoVisitante.perder()
    }else if (self.puntosLocal(local,visitante) < (self.puntosVisitante(local,visitante))){
      equipoLocal.perder()
      equipoVisitante.ganar()
    }else{
      equipoLocal.empatar()
      equipoVisitante.empatar()
    }
  }

  method jugar(local,visitante){
    if(local.equipoLleno() && visitante.equipoLleno()){
      self.resultado(local,visitante)
      equipoLocal.jugo()
      equipoVisitante.jugo()
    }
  } 
}

object mundial {

	const equipos = #{}

	method agregarEquipo(equipo) {
		equipos.add(equipo)
	}

	method huboBatacazo() = equipos.any{ equipo => equipo.cantidadJugadoresEstrellas() < 2 && equipo.puntos() > 0 }

	method estamosBien() = equipos.all{ equipo => equipo.cumplioSuMinimo() }

}
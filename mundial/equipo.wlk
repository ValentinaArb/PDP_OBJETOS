import jugador.*

class Equipo{
    const cantidadJugadores = 11

    method cantidadEstrellasAdmitidas()

    const jugadores = #{}
    var victorias = 0
	var derrotas = 0
	var empates = 0
    
   method agregarJugador(jugador) {
		self.chequearQueSePuedeAgregar(jugador)
		jugadores.add(jugador)
	}

    method estaCompleto() = cantidadJugadores == 11

    method completoDeEstrellas() = self.cantidadEstrellas() == self.cantidadEstrellasAdmitidas()

	method chequearQueSePuedeAgregar(jugador) {
		if (self.estaCompleto()) {
			self.error("¡El equipo está completo, ya son 11!")
		}
		if (jugador.esEstrella() && self.completoDeEstrellas()) {
			self.error("Ya hay muchas estrellas, no se puede agregar otra")
		}
	}

    method cantidadEstrellas() = jugadores.filter{jugador => jugador.esEstrella()}.size()

    method habilidad() = jugadores.sum{jugador => jugador.habilidad()}
}

class EquipoPro inherits Equipo{
    override method cantidadEstrellasAdmitidas() = 9
}

class EquipoMedioPelo inherits Equipo{
    override method cantidadEstrellasAdmitidas() = 3
}

object brasil inherits Equipo{
    override method cantidadEstrellasAdmitidas() = cantidadJugadores
}
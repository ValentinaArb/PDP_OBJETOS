import equipo.*

class Partido {

	const local
	const visitante

	method jugar() {
		self.chequearEstanCompletos()
		if (self.ganaLocal()) {
			self.gano(local, visitante)
		} else if (self.empatan()) {
			self.empataron()
		} else {
			self.gano(visitante, local)
		}
		local.jugar()
		visitante.jugar()
	}

	method chequearEstanCompletos() {
		if (not (local.estaCompleto() && visitante.estaCompleto())) {
			self.error('Los equipos no están completos, ambos tienen que tener 11 jugadores')
		}
	}

	method gano(ganador, perdedor) {
		ganador.ganar()
		perdedor.perder()
	}

	method empataron() {
		local.empatar()
		visitante.empatar()
	}

	method ganaLocal() = self.puntosLocal() >= self.puntosVisitante()

	method empatan() = self.puntosLocal() == self.puntosVisitante()

	method puntosLocal() {
		return self.puntos(local, visitante) + self.puntosPorLocalia()
	}

	method puntosVisitante() {
		return self.puntos(visitante, local)
	}

	method puntos(equipo, rival) {
		return self.puntosPorEstrellas(equipo) + self.puntosSiEsMejor(equipo, rival)
	}

	method puntosPorEstrellas(equipo) = equipo.cantidadEstrellas()

	method puntosSiEsMejor(equipo, rival) {
		if (equipo.habilidad() > rival.habilidad()) {
			return 5
		} else {
			return 0
		}
	}

	method puntosPorLocalia() = 1

}
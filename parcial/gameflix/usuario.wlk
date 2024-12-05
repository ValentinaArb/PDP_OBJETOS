import suscripcion.*
import gameflix.*

class Usuarios{
    var plata
    var property suscripcion = premium
    var humor
    method humor() = humor.max(0)
    var horasJugadas

    method puedeJugar(juego) = suscripcion.puedeJugar(juego)

    method actualizar(nuevaSuscripcion) = true /* self.suscripcion(nuevaSuscripcion) */

    method pagar(cantidad){
        if(plata > cantidad){
            plata -= cantidad
        }else{
            self.actualizar(prueba)
            throw new NoHayPlataSuficiente(message= "No tenes plata suficiente")
        }
    }

    method efecto(juego)

    method jugar(juego){
        self.puedeJugar(juego) && self.efecto(juego)
    }

    method modificarHumor(unidad) {
      humor += horasJugadas * unidad
    }
}
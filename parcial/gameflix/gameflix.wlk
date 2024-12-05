import suscripcion.*
import juego.*

class Gameflix{
    const juegos = #{}
    method filtrar(unaCategoria){
        juegos.filter ({juego => juego.esDeCategoria(unaCategoria)})
    }

    method buscar(unNombre){
        try{
            return juegos.find{juego => juego.seLlama(unNombre)}
        }catch elementNotFoundException{
            throw new NoExisteJuego(message= "No ecxiste el juego con nombre: " + unNombre)
        }
    }

    method recomendar() =juegos.anyOne()

    method cobrarSuscripcion(usuario){
        const cantidadPlata = usuario.suscripcion().costo()
        usuario.pagar(cantidadPlata)
    }
}

class NoExisteJuego inherits Exception {}
class NoHayPlataSuficiente inherits Exception {}
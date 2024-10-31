import suscripcion.*

class Juego{
    const nombre
    const categoria
    var precio

    method esDeCategoria(unaCategoria) = categoria.toLowerCase() == unaCategoria.toLowerCase()

    method seLlama(unNombre) = nombre.toLowerCase() == unNombre.toLowerCase()

    method esBarato() = precio < 30
}

class JuegoViolento inherits Juego{
    method efecto(jugador){
        jugador.modificarHumor(-10)
    }
}

class MOBA inherits Juego{
    method efecto(jugador){
        jugador.pagar(30)
    }
}

class Terror inherits Juego{
    method efecto(jugador){
        jugador.actualizar(Infantil)
    }
}

class Estrategico inherits Juego{
    method efecto(jugador){
        jugador.modificarHumor(5)
    }
}

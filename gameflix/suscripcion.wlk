class Premium{
    method costo() = 50 
    method puedeJugar(juego) = true
}

class Base{
    method costo() = 25 
    method puedeJugar(juego) = juego.esBarato()    
}

class Infantil{
    method costo() = 10
    method puedeJugar(juego) = juego.esDeCategoria("Infantil")
}

class Prueba{
    method costo() = 0
    method puedeJugar(juego) = juego.esDeCategoria("Demo")
}
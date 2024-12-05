object premium{
    method costo() = 50 
    method puedeJugar(juego) = true
}

object base{
    method costo() = 25 
    method puedeJugar(juego) = juego.esBarato()    
}

object infantil{
    method costo() = 10
    method puedeJugar(juego) = juego.esDeCategoria("Infantil")
}

object prueba{
    method costo() = 0
    method puedeJugar(juego) = juego.esDeCategoria("Demo")
}
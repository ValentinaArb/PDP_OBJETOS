class SalaEscape{
  const nombre
  const dificultad
  const precioBase = 10000
  var precioExtra
  method precioExtra() = precioExtra
  method precio() = precioBase + self.precioExtra()

  method esDificil() = dificultad > 7
}

class SalaEscapeAnime inherits SalaEscape{
  override method precioExtra() = 7000
  override method precio() = precioBase + self.precioExtra()
}

class SalaEscapeHistoria inherits SalaEscape{
  const basadaEnHechoReal
  override method precioExtra() = dificultad * 0.314
  override method precio() = precioBase + self.precioExtra()

  override method esDificil(){
    return dificultad > 7 && !basadaEnHechoReal
  }
}

class SalaEscapeTerror inherits SalaEscape{
  const cantidadSustos
  
  /* override method precioExtra(){   
    if(cantidadSustos > 5){
      return cantidadSustos * 0.2
    } else{
      return 0
    }
  } */

  override method esDificil(){
    return dificultad > 7 || cantidadSustos > 5
   }

  override method precio() = precioBase + self.precioExtra()
}


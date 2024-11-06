class SalaEscape{
  const nombre
  const dificultad
  const precioBase = 10000
  
  method precioExtra()
  
  method precio() = precioBase + self.precioExtra()

  method esDificil() = dificultad > 7
}

class SalaEscapeAnime inherits SalaEscape{
  override method precioExtra() = 7000
}

class SalaEscapeHistoria inherits SalaEscape{
  const basadaEnHechoReal
  override method precioExtra() = dificultad * 0.314

  override method esDificil(){
    return super() && !basadaEnHechoReal
  }
}

class SalaEscapeTerror inherits SalaEscape{
  const cantidadSustos
  
  override method precioExtra(){   
    if(self.tieneMuchosSustos()){
      return cantidadSustos * 0.2
    } else{
      return 0
    }
  }

  override method esDificil(){
    return super() || self.tieneMuchosSustos()
   }

   method tieneMuchosSustos() = cantidadSustos > 5
}


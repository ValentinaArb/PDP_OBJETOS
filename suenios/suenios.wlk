import personas.*

class Suenio{
  const property nivelFelicidad

  method lograr(persona){
    if(self.condicion(persona)){
      self.logrado(persona)
    }
    else{
      self.error("No es posible ya que alguna condición no se cumple")
    }
  }
  method condicion(persona)
  method logrado(persona)

}

class Recibirse inherits Suenio{
  const carrera

  override method condicion(persona) = persona.quiereEstudiar(carrera) && !persona.yaEstudio(carrera)

  override method logrado(persona){
    persona.recibirse(carrera)
    persona.cumplirSuenio(self)
  }  
}

class Trabajo inherits Suenio{
  const sueldo

  override method condicion(persona) = !persona.sueldoMenorAlSoniado(sueldo)

  override method logrado(persona){
    persona.cumplirSuenio(self)
  }  
}

class TenerHijo inherits Suenio{
  override method logrado(persona){
    persona.tenerHijo()
  }
  /* si uno tiene un hijo no se puede adoptar otro (así lo pidió el usuario) */
}

class SuenioMultiple inherits Suenio{
  const sueniosMultiples = #{}
  method intentarLograr(persona){
    sueniosMultiples.forEach{suenio => suenio.lograr(persona)}
  }
}
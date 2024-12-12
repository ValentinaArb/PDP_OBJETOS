class Plato{
  const caloriasBase = 100
  const property cocinero
  method esBonito()
  method cantidadAzucar()
  
  method menosDeNCalorias(cantidad) = caloriasBase < cantidad

  method calorias() = 3 * self.cantidadAzucar() + caloriasBase
}

/* object caloriasEstandar {
    method valor() = 100
} */

class Entrada inherits Plato{
  override method esBonito() = true
  override method cantidadAzucar() = 0
}

class Principal inherits Plato{
  const esBonito
  const cantidadAzucar
  
  override method esBonito() = esBonito
  override method cantidadAzucar() = cantidadAzucar
}  

class Postre inherits Plato{
  const colores
  override method esBonito() = colores >= 3
  override method cantidadAzucar() = 120
}

class Cocinero{
  var especialidad = new Chef(cantidadCaloriasDeseadas = 0)
  method cocinar() = especialidad.cocinar(self)
  method catar(plato) = especialidad.catar(plato)

  method cambiarEspecialidad(nueva){
    especialidad = nueva
  }
}

class Chef{
  const cantidadCaloriasDeseadas

  method platoCumpleExpectativa(plato) = plato.esBonito() && plato.cantidadCalorias() <= cantidadCaloriasDeseadas
	
  method catar(plato){
    if(self.platoCumpleExpectativa(plato)) {
      return 10
    } else{
      return self.calificacionSiNoCumpleExpectativa(plato)
    }
  }
	
  method calificacionSiNoCumpleExpectativa(plato) = 0

  method cocinar(cocinero) = new Principal(cocinero = cocinero, esBonito = true, cantidadAzucar = cantidadCaloriasDeseadas)
}

class Pastelero{
  const nivelDulzor
  method catar(plato) = (5*plato.cantidadAzucar() / nivelDulzor).min(10)
  method coloresPostre() = nivelDulzor.div(50)

  method cocinar(cocinero) = new Postre(cocinero = cocinero,colores = self.coloresPostre())
}

class SousChef inherits Chef{
  override method calificacionSiNoCumpleExpectativa(plato) = (plato.calorias() / 100).min(6)

  override method cocinar(cocinero) = new Entrada(cocinero = cocinero)
}

class Torneo {
  const catadores = #{}
  const platos = #{}

  method platosVacio() = platos.isEmpty()

  method participar(cocinero) {
    platos.add(cocinero.cocinar())
  }

  method ganador() {
    if(self.platosVacio()){
      self.error("No hay participantes!!")
    }else{
      return platos.max({plato=>self.calificacionTotal(plato)}).cocinero()    
    }
  }

  method calificacionTotal(plato) = catadores.sum {catador => catador.catar(plato)}
}
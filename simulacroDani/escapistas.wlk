import salas.*
class Escapista{
  var maestria
  method maestria() = maestria

  method actualizar(nuevaMaestria) = true 

  var property salasEscapadas = []
  var saldo

  method hizoMuchasSalas() = self.salasEscapadas().size() > 6

  method condicionAmateur(sala) = !sala.esDificil() && self.hizoMuchasSalas()

  method puedeSalir(sala)

  method subirNivelMaestria(){
    if(self.hizoMuchasSalas() && self.maestria() == "amateur"){
      self.actualizar("profesional")
    }
  }

  method salasLogradas() = self.salasEscapadas().asSet()
}

class EscapistaAmateur inherits Escapista{
  override method maestria() = "amateur"

  override method puedeSalir(sala) = self.condicionAmateur(sala)
}

class EscapistaProfesional inherits Escapista{
  override method maestria() = "profesional"

  override method puedeSalir(sala) = true
}
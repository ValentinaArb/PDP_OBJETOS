import salas.*
class Escapista{
  var maestria
  var saldo
  var salasEscapadas = []

  method puedeSalir(sala) = maestria.puedeSalir(sala,self)

  method hizoMuchasSalas() = salasEscapadas.size() >= 6

  method subirNivelMaestria(){
    if(self.hizoMuchasSalas()){
      maestria = maestria.siguienteNivel()
    }
  }

  method registrarSala(sala) = salasEscapadas.add(sala)

  method salasLogradas() = salasEscapadas.map { unaSala => unaSala.nombre() }.withoutDuplicates()

  method pagar(cantidad) {
    saldo -= cantidad
  }  

  method puedePagar(cantidad) = cantidad <= saldo
}

object amateur{
  method condicionAmateur(sala,escapista) = !sala.esDificil() && escapista.hizoMuchasSalas()
  
  method puedeSalir(sala,escapista) = self.condicionAmateur(sala,escapista)

  method siguienteNivel() = profesional
}

object profesional{
  method puedeSalir(sala,escapista) = true

  method siguienteNivel() = self
}
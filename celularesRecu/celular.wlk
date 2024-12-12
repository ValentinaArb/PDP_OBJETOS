object empresa {
  var derechoDeAutor = 10
  const usuarios = #{}


  method cobrar(usuario,contenido){
    const precio = self.montoTotal(usuario,contenido) 
    if(usuario.plan() == prepago){
      if(usuario.puedePagar(precio)){
        usuario.pagar(precio,contenido)

      }else{
        self.error("No tiene plata suficiente")
      }
    }
    else{
      usuario.acumular(precio)
    }
  }


  method montoTotal(usuario,contenido){
    const recargo = usuario.plan().recargo()
    return self.calcularMonto(usuario,contenido) * recargo
  }

  method calcularMonto(usuario,contenido) =
    self.montoDerechoDeAutor(contenido) + self.montoTelecomunicaciones(usuario,contenido) + self.ganancia(contenido)
  
  method montoDerechoDeAutor(contenido) = contenido.monto()

  method montoTelecomunicaciones(usuario,contenido) =
    usuario.compania().monto(self.montoDerechoDeAutor(contenido))
  

  method ganancia(contenido) =
    0.25 * self.montoDerechoDeAutor(contenido)
}

class Descarga {
    const nombre
    const fecha = new Date()
  }

class Plan {
    const property recargo 
}

const prepago = new Plan (recargo = 1.1)
const facturado = new Plan (recargo = 1)

class Usuario {
    var dinero
    const compania = Compania
    var property plan
    const descargas = []

    method descargar(contenido){
      empresa.cobrar(self,contenido)
    }

    method cambiarPlan(planNuevo){
      plan = planNuevo
    }

    method puedePagar(monto) = dinero >= monto

    method pagar(monto,contenido){
      dinero -= monto

      const descarga = new Descarga (nombre = contenido)
      descargas.add(descarga)

    }

    method totalPorUsuario(mes){
    const descargasUsuario = descargas.filter{descarga => descarga.fecha().month() == mes}
    return descargasUsuario.sum {descarga => empresa.montoTotal(self,descarga.nombre())}
  }
    
  method esColgado(){
    const descargasPorNombre = descargas.groupBy { descarga => descarga.nombre() }
    return descargasPorNombre.any { grupo => grupo.size() > 1 }
  }

  method acumular(monto){
    var acumulador
    acumulador += monto
  }
}

object montoCompaniaExtranjera {
  method valor () = 1
}
class Compania{
  method monto(derechoAutor) = 0.05 * derechoAutor
}

const companiaNacional = new Compania ()

/* class CompaniaExtranjera inherits Compania{
  override method monto(derechoAutor){
    return super(monto) + montoCompaniaExtranjera.valor()
  }  
} */


class Contenido {
  method monto()
}

class Ringtone inherits Contenido {
  const duracion
  const precioPorMinuto

  override method monto () =  duracion * precioPorMinuto
}

object montoFijo {
  method valor () = 1
}

class Chiste inherits Contenido {
  const cantidadCaracteres
  override method monto() = cantidadCaracteres * montoFijo.valor()
}

class Juego inherits Contenido {
  var monto
  override method monto() = monto
}
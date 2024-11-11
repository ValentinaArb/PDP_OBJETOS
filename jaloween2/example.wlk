class ninio{
  const actitud
  const elementos = #{}
  var property bolsaCaramelos

  method actitud() = actitud.max(0).min(10)

  method capacidadAsustar() = actitud * elementos.sum{elemento => elemento.susto()}

  method intentarAsustar(persona){
    persona.darCaramelos(ninio)
    
  }
}

object maquillaje{
  var property susto = 3
}

object trajeTierno{
  const property susto = 2
}

object trajeTerrorifico{
  const property susto = 5
}

class Adulto{
  const tolerancia = 10 * niniosIntento
  var niniosIntento = 0

  method seAsusta(ninio){
    if(ninio.bolsaCaramelos() > 15){
      niniosIntento += 1 
    }
    return tolerancia < ninio.capacidadAsustar()
  }

  method cantidadCaramelos() = tolerancia / 2

  method darCaramelos(ninio){
    if(self.seAsusta(ninio)){
      return self.cantidadCaramelos()
    }else{
      return 0
    }
  }
}

class Abuelo inherits Adulto{
  override method seAsusta(ninio) = true

  override method cantidadCaramelos() =  super() / 2
}

class AdultoNecio inherits Adulto{
  override method seAsusta(ninio) = false
}



class Ninios{
  const elementos = #{}
  var actitud  /* method actitud() = aactitud.mx(0).min(10) */ /* limitar actitud */
  var cantidadDeCaramelos = 0
  
  method cantidadDeCaramelos() = cantidadDeCaramelos

  method elementos()= elementos

  method capacidadDeAsustar()= self.sustosQueGenera() * actitud

  method sustosQueGenera()= elementos.sum({unElemento => unElemento.susto()})

  method tieneMasDe15Caramelos()= cantidadDeCaramelos>15

  method tieneMasDe10Caramelos() = cantidadDeCaramelos>10

  method recibirCaramelos(unaCantidad){
    cantidadDeCaramelos +=unaCantidad
  }

  method intentarAsustar(unAdulto){
    unAdulto.esAsustadoPor(self)
  }



  method puedeComer(unaCantidad) = cantidadDeCaramelos > unaCantidad


  method comerCaramelos(unaCantidad){
    if(self.puedeComer(unaCantidad)){
      cantidadDeCaramelos -=unaCantidad
    }
    else{
      throw new Exception(message = "no podes comer tantos caramelos paa")
    }
  }
}


class Maquillaje{
  method susto() = 3
}

class TrajeTierno{
  method susto() = 2
}

class TrajeTerrorifico{
  method susto() = 5
}

class Adulto{ 
  var ninosQueIntentanAsustarlo
  
  method tolerancia() = 10 * ninosQueIntentanAsustarlo
  
  method loAsusta(unNinio){
    if(unNinio.tieneMasDe15Caramelos()){
      ninosQueIntentanAsustarlo +=1
    }
    
   return self.tolerancia() < unNinio.capacidadDeAsustar()
  }
  
  method esAsustadoPor(unNinio){
    if(self.loAsusta(unNinio)){
      unNinio.recibirCaramelos(self.tolerancia()/2)
    }
  }
}

class Abuelo inherits Adulto{
  override method loAsusta(unNinio)= true 

  override method esAsustadoPor(unNinio){
    super(unNinio)/2
  }
}

class AdultoNecio inherits Adulto{
  override method loAsusta(unNinio)= false
}

/* const Dani = new Ninio (vida = 0, elementos = {maquillaje}, cantidadDeCaramelos = 0)
Dani.intentarAsustar(Valen) */

class Legion{

  const grupo= #{}

  method capacidadDeAsustar() = grupo.sum({unNinio => unNinio.capacidadDeAsustar()})

  method cantidadDeCaramelos() = grupo.sum({unNinio => unNinio.catidadDeCaramelos()})

  method lider() = grupo.max({unNinio => unNinio.capacidadDeAsustar()})

  method recibirCaramelos(unaCantidad){
    self.lider().cantidadDeCaramelos(unaCantidad)
  }

  method intentarAsustar(unAdulto){
    unAdulto.esAsustadoPor(self)
  }
}

class Barrio{
  const ninios = #{}

  method top3()= ninios.sortedBy({unNinio,otroNinio => unNinio.cantidadDeCaramelos()> otroNinio.cantidadDeCaramelos()}).take(3)

  method elementosDeNinioConMasDe10Caramelos()= ninios.filter({unNinio => unNinio.tieneMasDe10Caramelos()}).map({unNinio => unNinio.elementos()}).asSet()
}
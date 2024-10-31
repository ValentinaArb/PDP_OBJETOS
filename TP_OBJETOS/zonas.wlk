import guerreros.*
//creo q capaz deberiamos eliminar la clse zona y q todos sean objetos nomas
class Zona{
    method puedeAtravesar(guerreros)
    method requerimientoGuerrero(guerreros) = true     
    method requerimientoItem(cantidadItem,itemBuscado,guerreros) = true 
}


object belfalas inherits Zona{    
    override method puedeAtravesar(guerreros) = true
}

object lebennin inherits Zona{    
    override method puedeAtravesar(guerreros){
       return self.requerimientoGuerrero(guerreros)
    }
  
    override method requerimientoGuerrero(guerreros) {
        return guerreros.any { guerrero => guerrero.poder()>1500 }
    }
}

object minasTirith inherits Zona {
    override method puedeAtravesar(guerreros) {
        return self.requerimientoGuerrero(guerreros) && self.requerimientoItem(10, "lemba", guerreros)
    }
    override method requerimientoItem(cantidadItem,itemBuscado,guerreros){
        return guerreros.sum {guerrero=> guerrero.cantidadItem(itemBuscado)} >= 10
    }
    override method requerimientoGuerrero(guerreros){
       return guerreros.all { guerrero => guerrero.cantidadArmas() > 0 }
    }
}

object lossarnach inherits Zona {
    override method puedeAtravesar(guerreros) = true
}

object edoras inherits Zona {
    override method puedeAtravesar(guerreros) = true
}

object bosqueDeFangorn inherits Zona {
    override method puedeAtravesar (guerreros) {
        return self.requerimientoGuerrero(guerreros)
    }

    override method requerimientoGuerrero(guerreros) {
        return guerreros.any { guerrero => guerrero.cantidadArmas() > 0 }
    }
}

object estemnet inherits Zona{    
    override method puedeAtravesar (guerreros) {
        return self.requerimientoItem(3, "capaElfica", guerreros)
    }
    
    override method requerimientoItem(cantidadItem,itemBuscado,guerreros){
        return guerreros.sum {guerrero=> guerrero.cantidadItem(itemBuscado)} >= 3
    }
}
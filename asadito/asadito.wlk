class Comensal {
   var posicion = "0"
   var elementos = []
   var criterioPasar = normal
   var criterioComida = vegetariano
   var comidos = []

   method pedir(elemento, persona){
        if(self.verificarElemento(elemento)){
            if(criterioPasar != cambiarPosicion){
                const elementoPasar = criterioPasar.elemento(self,elemento)
                persona.pasar(elemento,self)
            }
            else{
                criterioPasar.cambiar(self,persona)
            }
        } else {
            self.error("No tiene el elemento")
        }
    }
    
    method verificarElemento(elemento){
        return elementos.contains(elemento)
    }

    method pasar(elemento,persona){
        self.eliminarElemento(elemento)
        persona.agregarElemento(elemento)
    }

   method elementoMasAMano() = elementos.head()
   method agregarElemento(elemento) = elementos.addAll(elemento)
   method eliminarElemento(elemento) = elementos.remove(elemento)

   method cambiarPosicionCon(persona2){
        const posicion2 = persona2.posicion()
        persona2.posicion(posicion)
        posicion = posicion2
   }

   method cambiarElementos(persona2){ 
        const elementos2 = persona2.elementos()
        persona2.elementos(elementos)
        elementos = elementos2
   }

   method cambiarCriterioPasar(nuevoCriterio){
        criterioPasar = nuevoCriterio
   }

   method cambiarCriterioComida(nuevoCriterio){
        criterioComida = nuevoCriterio
   }

   method estaPipon(){
        comidos.any{comida=>comida.esPesada()}

   }

   method comer(comida){
    if(criterioComida.acepta(comida)){
        comidos.add(comida)
    }else{ self.error("ayunaste reini")}
    }
   
    method laEstaPasandoBien() = !comidos.isEmpty() && self.condicionPersonal()

    method condicionPersonal() = true
}

const osky = new Comensal()

object moni inherits Comensal{
    override method condicionPersonal() = posicion == "1@1"
}

object facu inherits Comensal{
    override method condicionPersonal() = comidos.any{comida => comida.esCarne()}
}

object vero inherits Comensal{
    override method condicionPersonal() = elementos.size() <= 3
}

object sordo{
    method elemento(comensal,elemento){
        return comensal.elementoMasAMano()
    }
}

object todo {
    method elemento(comensal,elemento) {
        return comensal.elementos()
    }
}

object cambiarPosicion{
    method cambiar(comensal,persona) {
        comensal.cambiarPosicionCon(persona)
        comensal.cambiarElementos(persona)
    }
}

object normal{
    method elemento(comensal,elemento){
        return elemento
    }
}


class Comida {
    const cantidadCalorias
    method esCarne()

    method tieneMenosDe(cantidad) = cantidadCalorias < cantidad

    method esPesada() = cantidadCalorias > 500
}

object vegetariano{
    method acepta(comida) = !comida.esCarne()
}

object dietetico{
    method acepta(comida) = comida.tieneMenosDe(500)
}

object alternado{
    var aceptoAnterior = false
    method acepta(comida){        
        if(aceptoAnterior){
            return !aceptoAnterior
        }else{
            return aceptoAnterior
        }
        aceptoAnterior = !aceptoAnterior
    }
}

object pesado{
    const condiciones = #{}
    method acepta(comida) = condiciones.all{condicion=> condicion.acepta(comida)
    }
}
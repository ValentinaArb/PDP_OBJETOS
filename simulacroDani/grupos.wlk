import escapistas.*
import salas.*
class Grupo{
    const property grupo = #{}

    method cantidadEscapistas() = self.grupo().size()

    method puedeSalir() = grupo.any{integrante => integrante.puedeSalir()}
    
    method ingresar(sala){
        if(self.puedeSalir()){
            self.escapar(sala)
        }
    }

    method escapar(sala) {      
        grupo.forEach{escapista => escapista.salasEscapadas().add(sala)}
    }
    
    method pagar(sala){
        const precioSala = sala.precio() 
        self.ingresar(sala)
        if(self.puedePagar(sala)){
            self.restarGastos(precioSala)
        }
    }

    method puedePagar(sala){
        const precioSala = sala.precio() 
        return self.dividirGastos(precioSala) || self.cubrirPersonas(precioSala)
    }
   
    method restarGastos(precioSala){
        grupo.forEach{escapista => escapista.saldo() - precioSala/self.cantidadEscapistas()} //logica repe precioSala/self.cantidadEscapistas()
    }

    method dividirGastos(precioSala) = grupo.forEach{escapista => escapista.puedePagar(precioSala/self.cantidadEscapistas())}

    method cubrirPersonas(precioSala) {
        const puedenPagarlo = grupo.filter{escapista => escapista.puedePagar(precioSala/self.cantidadEscapistas())}
        return puedenPagarlo.saldo().sum() >= precioSala
    }
}

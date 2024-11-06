import escapistas.*
import salas.*
class Grupo{
    const grupo = #{}

    method cantidadEscapistas() = grupo.size()

    method puedeSalir(sala) = grupo.any{integrante => integrante.puedeSalir(sala)}
    
    method escapar(sala) {  
        self.pagar(sala)   
        grupo.forEach{escapista => escapista.registrarSala(sala)}
    }
     
    method pagar(sala){
        const precioSala = sala.precio() 
        if(self.puedePagar(sala)){
            grupo.forEach{miembro => miembro.pagar(self.montoPorPersonaPara(sala))}
        }
        else{
            self.error("No tiene dinero suficiente")
        }
    }

    method puedePagar(sala){
        const precioSala = sala.precio() 
        return self.dividirGastos(precioSala) || self.cubrirPersonas(precioSala)
    }
   
    method dividirGastos(sala) = grupo.all{escapista => escapista.puedePagar(self.montoPorPersonaPara(sala))}

    method adinerados(sala) = grupo.filter{escapista => escapista.puedePagar(self.montoPorPersonaPara(sala))}

    method plataAdinerados(sala) = self.adinerados(sala).sum{adinerado => adinerado.saldo()}

    method cubrirPersonas(sala) =  self.plataAdinerados(sala) >= sala.precio()

    method montoPorPersonaPara(sala) = sala.precio() / self.cantidadEscapistas()
}

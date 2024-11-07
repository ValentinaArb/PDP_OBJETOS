import grupos.*
import personas.*
class Lugar{
    const caminantes = #{}

    

    method poderCorrosivo() = caminantes.sum{caminante => caminante.poderCorrosivo()} //repeticion

    method puedeTomar()
}

class Prision inherits Lugar{
    const cantidadPabellones 
    const armasAbandonadas = []

    method puedeTomar(grupo) = grupo.poderOfensivo() > 2 * cantidadPabellones
    
    method efecto(grupo) = grupo.elMasDebil().armas() + armasAbandonadas
}

class Granja inherits Lugar{    
    method puedeTomar(grupo) = true
    
    method efecto(grupo) = grupo.forEach{integrante => integrante.consumirGuarnicion()}
}

class Bosque inherits Lugar{  
    var tieneNiebla  
    method puedeTomar(grupo) = grupo.forEach{integrante => integrante.noTieneArmaRuidosa()}
    
    method efecto(grupo){
        if(tieneNiebla){
            grupo.anyOne().eliminarArmas()
        }
    }
}
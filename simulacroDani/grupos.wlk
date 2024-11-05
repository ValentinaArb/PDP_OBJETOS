import escapistas.*
import salas.*
class Grupo{
    const grupo = #{}

    method puedeSalir() = grupo.any{integrante => integrante.puedeSalir()}
    
}
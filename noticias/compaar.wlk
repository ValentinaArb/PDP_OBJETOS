
class Noticia{
    const fechaDePublicacion //en formato "hace cuantos dias se publico"
    const autor 
    const gradoDeImportancia
    const titulo
    const desarrollo 

    method esCopada() = gradoDeImportancia >= 8 && fechaDePublicacion < 3

    method diceTitulo(palabra) = titulo.contains(palabra)

    method tamanioDesarrollo() { return desarrollo.count(" ") + 1}

    method tamanioTitulo() { return titulo.count(" ") + 1}

    method comienzaConLetra(letra) = titulo.take(1) == letra

    method estaBienEscrita() {
    if(self.tamanioTitulo() < 2) {
        throw new DomainException(message = "El título debe contener al menos dos palabras.")
    } 
    if(desarrollo.isEmpty()){
        throw new DomainException(message = "El desarrollo no puede estar vacío.")
    }
    return true
}
}
class NoticiaComun inherits Noticia{

    const links = #{}

    override method esCopada() = super().esCopada() && links.size() >= 2
}
class NoticiaPublicidad inherits Noticia{

    const costoDeLaNoticia

    override method esCopada() = super().esCopada() && costoDeLaNoticia > 2000000
}
class NoticiaReportaje inherits Noticia{

    const artistaEntrevistado

    override method esCopada() = super().esCopada() && (artistaEntrevistado.length()).odd()
}
class NoticiaCobertura inherits Noticia{

    const grupoDeNoticias = #{}

    override method esCopada() = grupoDeNoticias.all{noticia => noticia.esCopada()}
}

class Periodista{
        const fechaDeIngreso
        const preferencia
        const noticiaPublicadasHoy = #{}

        method esDeSuPreferencia(noticia) = preferencia.perteneceAGrupo(noticia)

        method contarNoticiasAburridas() {return noticiaPublicadasHoy.count{noticia => not preferencia.perteneceAGrupo(noticia)}}

        method puedePublicarNoticia(noticia) { 
            if (!preferencia.perteneceAGrupo(noticia)) {             
                return self.contarNoticiasAburridas() < 2 && noticia.estaBienEscrita()

            } else {
                return noticia.estaBienEscrita()            
            }
        }

        method publicarNoticia(noticia){
            if(self.puedePublicarNoticia(noticia)) {
                noticiaPublicadasHoy.add(noticia)
            }
        }
}

object preferenciaCopada{
    method perteneceAGrupo(noticia) = noticia.esCopada()
}
object preferenciaSensacionalista{
    method perteneceAGrupo(noticia) = noticia.diceTitulo("espectacular") || noticia.diceTitulo("increbible") || noticia.diceTitulo("grandioso")
}
object preferenciaVaga{
    method perteneceAGrupo(noticia) = noticia.tamanioDesarrollo() < 100
}
object preferenciaJosesito{
    method perteneceAGrupo(noticia) = noticia.comienzaConLetra("T")
}
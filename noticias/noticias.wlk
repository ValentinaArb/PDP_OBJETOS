class Noticia{
    const fechaPublicacion
    const periodistas
    const importancia
    const titulo
    const desarrollo

    method esImportante() = importancia >= 8

    method publicadaHaceMenosDe(cantidadDias){
        const hoy = new Date()
        const haceNDias = hoy.minusDays(cantidadDias)
        return fechaPublicacion.between(haceNDias,hoy)
    }

    method requisitoCopada()

    method esCopada() = self.esImportante() && self.publicadaHaceMenosDe(3) && self.requisitoCopada()

    method esSensacionalista() = titulo.contains("espectacular") || titulo.contains("increible")  || titulo.contains("grandioso")
    

    method tieneMenosDe(parte,palabras) = parte.size() < palabras
    method tieneMasDe(parte,palabras) = parte.size() > palabras
    

    method tieneDesarrollo() = not desarrollo.isEmpty()
    
    method esVaga() = self.tieneMenosDe(desarrollo,100)

    method comienzaCon(letra) = titulo.at(0) == letra 
}

class Comun inherits Noticia{
    const links = #{}
    override method requisitoCopada() = links.size() >= 2
}

class Chivo inherits Noticia{
    const plataChivo
    override method requisitoCopada() = plataChivo > 2000000
    override method esVaga() = true
}

class Reportaje inherits Noticia{
    const entrevistado

    method esEntrevistado(nombre) = nombre == entrevistado
    override method requisitoCopada() = entrevistado.size().odd()

    override method esSensacionalista(){
        return super() && (entrevistado == "Dibu Martinez")
    }
}

class Cobertura inherits Noticia{
    const relacionadas = #{}
    override method requisitoCopada() = relacionadas.all{relacionada => relacionada.esCopada()}
}

class Periodista {
    const fechaIngreso
    var contadorNoPreferidas = 0
    var noticiasPublicadas = #{}
    const hoy = new Date()

    method preferencia(noticia)

    method alcanzoLimiteNoPreferidas() = contadorNoPreferidas >= 2

    method verificarBienEscrita(noticia) = noticia.tieneDesarrollo() && noticia.tieneMasDe(noticia.titulo(),2)

    method puedePublicar(noticia) {
        if(self.verificarBienEscrita(noticia)){
            if(not self.preferencia(noticia))
                return self.alcanzoLimiteNoPreferidas()
            else{self.error("No se puede publicar por noticia no preferida")}
        }else{self.error("No se puede publicar por noticia mal escrita")}
    }

    method publicar(noticia){
        if(self.puedePublicar(noticia)){
            if(not self.preferencia(noticia)){
                contadorNoPreferidas+=1
            }
            noticiasPublicadas.add(noticia)
        }
    }

    method esReciente() {
        const haceNAnio = hoy.minusYears(1)
        return fechaIngreso.between(haceNAnio,hoy)
    }

    method publicaronHaceMenosDeUnaSemana(){
        const haceNSemanas = hoy.minusDays(7)
        return fechaIngreso.between(haceNSemanas,hoy)
    }
}

class Diario{
    const periodistas = #{}

    method recientes(){
        periodistas.filter{periodista => periodista.esReciente() && periodista.publicaronHaceMenosDeUnaSemana()}
    }
}

class Vago inherits Periodista {
    override method preferencia(noticia) = noticia.esVaga()
}

class Copado inherits Periodista {
    override method preferencia(noticia) = noticia.esCopada()
}

class Sensacionalista inherits Periodista {
    override method preferencia(noticia) = noticia.esSensacioanlista()
}

object joseDeZer inherits Periodista(fechaIngreso = new Date ()){
    override method preferencia(noticia) = noticia.comienzaCon("T")
}
class Resumen{   
    
    const introduccion

    const secciones = #{}

    var property likes = 0
    var property dislikes = 0

    method duracionIntro() = introduccion.words().size() * 10

    method duracionSecciones() = secciones.sum{seccion => seccion.duracion()}

    method duracionResumen() = self.duracionIntro() + self.duracionSecciones()

    method agregarSeccion(seccionnnombre){
        /* const seccionnombre = new Seccion() //esto deberia pasar en la terminal */
        secciones.add(seccionnnombre)
    }

    method tieneCancion(nombre) = secciones.any {seccion=> seccion.tieneCancion(nombre)}

    method tieneReferencia() = secciones.any {seccion => seccion.esReferencial()}

    method libreto(){        
        const speeches = [introduccion]
		speeches.addAll(secciones.map {seccion => seccion.speech()})
		return speeches.join(" . ")
    }

    method RecibirLike(resumen) {
        likes += 1
    }
    method RecibirDislike(resumen){
        dislikes += 1
    }

}

//Resumen Asi Nomas

class ResumenAsiNomas inherits Resumen{
    const factorVelocidad
    const property resumenes = #{}

    override method duracionResumen() = super() * factorVelocidad
}

class Seccion{
    const property duracion
    const property speech
        
    method esMusicalizada() = false
    method esReferencial () = false
}

class SeccionMusicalizada inherits Seccion {
    const nombreCancion

    override method esMusicalizada () = true
    
    method tieneCancion(cancion) =  cancion.toLowerCase() == nombreCancion.toLowerCase()
}

class SeccionReferencial inherits Seccion {
    const resumenReferencia
    override method esReferencial () = true

    method tieneReferencia(resumen) = resumen.toLowerCase() == resumenReferencia.toLowerCase()

        
    override method speech () = speech + " . " + resumenReferencia.libreto()
    override method duracion() = duracion + resumenReferencia.duracionResumen()
}
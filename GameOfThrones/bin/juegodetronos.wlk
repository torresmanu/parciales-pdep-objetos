class Personaje{
	var property casa
	var property conyuges = #{}
	var property acompaniantes = #{}
	var property estaVivo = true
	method esPeligroso(){
		if(!estaVivo){
			return false
		}
		else{
			return self.dineroAliadosMayorQue(10000) or self.conyugesDeCasaRica() or self.aliadoConPeligroso()
		}
	}
	method aliadoConPeligroso(){
		return self.aliados().any({unAl=>unAl.esPeligroso()})
	}
	method conyugesDeCasaRica(){
		return conyuges.all({conyuge=>conyuge.casaRica()})
	}
	method casaRica(){
		return casa.esRica()
	}
	method dineroAliadosMayorQue(numero){
		return self.aliados().sum({unAliado=>unAliado.patrimonio()})>numero
	}
	method estaSolo(){
		return acompaniantes.size()==0
	}
	method aliados(){
		return conyuges+acompaniantes+casa.miembros()
	}
	method agregarConyuge(nuevoConyuge){
		conyuges.add(nuevoConyuge)
	}
	method casarse(nuevoConyuge){
		if(self.puedenCasarse(nuevoConyuge)){
			self.agregarConyuge(nuevoConyuge)
			nuevoConyuge.agregarConyuge(self)
		}
		else self.error("no se pueden casar")
	}
	method puedenCasarse(conyuge){
		return casa.puedenCasarse(self,conyuge) and	casa.puedenCasarse(conyuge,self)
	}
	method patrimonio(){
		return casa.patriomonio()/casa.cantidadMiembros()
	}
	method cantidadConyuges() = self.conyuges().size()
	
	method esTraidor(personaje){
		return self.aliados().contains(personaje)
	}
}
class Casa{
	var property patrimonio
	var property miembros = #{}
	var property ciudad
	
	method cantidadMiembros(){
		return miembros.size()
	}
	method esRica(){
		return patrimonio>=1000
	}
}

object lannister inherits Casa{
	method puedenCasarse(personaje, conyuge){
		return personaje.cantidadConyuges()==0
	}
}

object stark inherits Casa{
	method puedenCasarse(personaje, conyuge){
		return personaje.casa() != conyuge.casa()
	}
}
object guardia inherits Casa{
	method puedeCasarse(personaje, conyuge) = false
}

class Animal{
	const property patrimonio=0
}

class Dragon inherits Animal{
	method esPeligroso()=true
}
class Lobo inherits Animal{
	var esHuargo
	
	method esPeligroso()= esHuargo
}

class Conspiracion{
	var property objetivo
	var property complotados
	
	constructor(_personaje,_complotados){
		if(_personaje.esPeligroso()){
			objetivo=_personaje
			complotados=_complotados
		}
		else self.error("No se puede contruir")
	}
	
	method traidores(){
		return complotados.count({unP=>unP.esTraidor(objetivo)})
	}
}


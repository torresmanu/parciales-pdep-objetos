class Personaje{
	var property casa
	var property personalidad
	var property conyuges = #{}
	var property acompaniantes = #{}
	var property estaVivo = true
	
	method derrochar(porcentaje){
		casa.derrochar(porcentaje)
	}
	method morir(){
		estaVivo = false
	}
	method esPeligroso(){
		if(!estaVivo){
			return false
		}
		else{
			return self.dineroAliadosMayorQue(10000) or self.conyugesDeCasaRica() or self.aliadoConPeligroso()
		}
	}
	method soltero(){
		return self.cantidadConyuges()==0
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
		return self.aliados().find(personaje)
}
}
class Casa{
	var property patrimonio
	var property miembros = #{}
	var property ciudad
	
	method derrochar(porcentaje){
		patrimonio -= patrimonio*porcentaje
	}
	method miembrosSolteros(){
		return miembros.filter({miembro=>miembro.soltero()})
	}
	method cantidadMiembros(){
		return miembros.size()
	}
	method esRica(){
		return patrimonio>=1000
	}
	method solterosVivos(){
		return self.miembrosSolteros().filter({miembro=>miembro.estaVivo()})
	}
}

object lannister inherits Casa{
	method puedenCasarse(personaje, conyuge){
		return personaje.soltero()
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
	const property objetivo
	const property complotados
	var property ejecutada=false
	
	constructor(_objetivo,_complotados){
		if(_objetivo.esPeligroso()){
			objetivo = _objetivo
			complotados = _complotados
		}
		else self.error("el objetivo no es peligroso")
	}
	method traidores(){
		return complotados.count(complotado=>complotado.traidor(objetivo))
	}
	method ejecutar(){
		complotados.map({complotado=>complotado.accion(objetivo)})
		ejecutada = true
	}
	method objetivoCumplido(){
		return ejecutada and !objetivo.esPeligroso()
	}
}
class Juego{
	var property casas
	method casaMasPobre(){
		return casas.min(unaCasa=>unaCasa.patrimonio)
	}
}
object sutil{
	const juego
	method casaMasPobre(){
		return juego.casaMasPobre()
	}
	method accion(objetivo){
		objetivo.casarse(self.casaMasPobre().solterosVivos().anyOne())
	}
}
object asesino{
	method accion(objetivo){
		objetivo.morir()
	}
}
object asesinoPrecavido{
	method accion(objetivo){
		if(objetivo.estaSolo()){
			objetivo.morir()
		}
	}
}
object disipados{
	var property porcentajeDerroche
	method accion(objetivo){
		objetivo.derrochar()
	}
}
object miedoso{
	method accion(objetivo)
}

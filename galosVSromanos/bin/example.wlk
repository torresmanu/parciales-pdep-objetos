class Persona{
	var property fuerza
	var property resistencia
	var property enCombate
	method poder(){
		return self.fuerza() * self.resistencia() 
	}
	method recibirDanio(cantidad){
		self.reducirResistencia(cantidad)
		if (self.resistencia()==0){
			self.enCombate(false)
		}
	}
	method reducirResistencia(cantidad){
		return 0.min(self.resistencia()- cantidad)
	}
	method tomarPosion(posion){
		posion.serIngerida(self)
	}
	
	method pelearContra(enemigo){
		self.recibirDanio(enemigo.diferenciaPoder(self))
	}
}

class Posion{
	var property ingredientes = []
	method cantidadIngredientes(){
		return self.ingredientes().size()
	}
	method serIngerida(persona){
		self.ingredientes().map({ingrediente => ingrediente.accion(persona,self)})
	}
}

class Ingrediente{

}

class DulceDeLeche inherits Ingrediente{
		method accion(persona,posion){
		if (!persona.enCombate()){
			persona.sumarResistencia(2)
		}
		else{
			persona.aunmentarFuerza(10)
		}
	}
}

class PuniadoDeHongos inherits Ingrediente{
	var property cantidadHongos
	method accion(persona,posion){
		persona.aumentarFuerza(self.cantidadHongos())
		if (self.cantidadHongos()>5){
			persona.reducirResistencia(persona.resistencia()*0.5)
		}
	}
}

class Grog inherits Ingrediente{
	method accion(persona,posion){
		persona.aumentarFuerza(persona.fuerza() * posion.cantidadIngredientes())
	}
}

class GrogXD inherits Grog{
	override method accion(persona,posion){
		super(persona,posion)
		persona.sumarResistencia(persona.resistencia())
		
	}
}

class Ejercito{
	var property cantidadAdelante = 10
	var property integrantes
	method integrantesEnCombate(){
		return self.integrantes().filter({integrante=>integrante.enCombate()})
	}
	method poder(){
		return self.integrantesEnCombate().sum({integrante=>integrante.poder()})
	}
	method integrantesxPoder(){
		return self.integrantesEnCombate().sortBy({integrante=>integrante.poder()})
	}
	method integrantesMasPoderosos(cantidad){
		return self.integrantesxPoder().take(cantidad)
	}
	method integrantesAdelante(){
		if (self.integrantesEnCombate().size()<self.cantidadAdelante()){
			return self.integrantes()
		}
		else{
			return self.integrantesMasPoderosos(self.cantidadAdelante())
		}
	}
	
	method recibirDanio(danio){
		self.integrantesAdelante().map({persona=> persona.recibirDanio(danio / self.integrantesAdelante().size())})
	}
	method menosPoderoso(){
		return self.integrantesxPoder().last()
	}
	method diferenciaPoder(enemigo){
		return (self.poder()-enemigo.poder()).abs()
	}
	method pelearContra(enemigo){
		if(self.integrantesEnCombate()==0){
		}
		else{
			self.menosPoderoso().recibirDanio(self.diferenciaPoder(enemigo))
			}
	}
	method pelear(enemigo){
			self.pelearContra(enemigo)
			enemigo.pelearContra(self)
	}
}

class Legion {
	var property formacion
}

class FormacionTortuga inherits Ejercito{
	override method poder(){
		return 0
	}
	override method recibirDanio(danio){
		super(0)
	}
}

class FormacionEnCuadro inherits Ejercito{
	constructor(_cantidadAdeltante){
		cantidadAdelante =  _cantidadAdeltante
	}
}

class FormacionFrontemAllargate inherits Ejercito{
	override method poder(){
		return super() * 1.1
	}
	override method recibirDanio(danio){
		super(danio*2)
	}
	override method cantidadAdelante(){
		return super()/2
	}
}

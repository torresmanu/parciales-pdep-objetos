class Empleado{
	var property rol
	var property estamina
	var property tareasRealizadas = []
	method fuerza(){
		return estamina/2 +2 +rol.fuerza()
	}
	method comerFruta(fruta){
		estamina += fruta.valor()
	}

	method tengoHerramientas(maquina){
		return rol.tengoHerraminetas()
	}
	method arreglarMaquina(maquina){
		if(maquina.dificultas()<estamina and self.tengoHerramientas(maquina) ){
			estamina -= maquina.dificultad()
			tareasRealizadas.add(maquina)
			return maquina.dificultad()
		}
		else{
			throw new Exception("No es posibe que este empleado arregle la maquina")
		}
	}

	method bajarEstamina(numero){
		estamina=estamina-numero
	}
	method defenderSector(amenaza){
		if(self.fuerza()>amenaza.gradoAmenaza()){
			rol.defenderSector(self)
			tareasRealizadas.add(amenaza)
			return amenaza.dificultad()
		}
		else throw new Exception("no tiene suficiente fuerza")
	}
	method puedoLimpiar(sector){
		return estamina>=sector.estaminaRequerida()
	}
	method limpiarSector(sector){
		if(rol.puedoLimpiar(self,sector)){
			rol.limpiarSector(self,sector)
		}
		
	}
}
object banana{
	const property valor = 10
}
object manzana{
	const property valor = 5
}
object uva{
	const property valor = 1
}

class Tarea{
	method dificultad()
}
class ArreglarMaquina inherits Tarea{
	var property complejidad
	const property herraminetasRequeridas = #{}
	override method dificultad(){
		return complejidad*2
	}
}
class DefenderSector inherits Tarea{
	const property gradoAmenaza
	override method dificultad(){
		return gradoAmenaza
	}
}
class LimpiarSector inherits Tarea{
	var property dificultad = 10
	const property esGrande
	method estaminaRequerida(){
		if(esGrande){
			return 4
		}
		else return 1 
		}
}




class Biclopes inherits Empleado{

}
class Ciclopes inherits Empleado{
	override method fuerza(){
		return super()*2
	}
}

class Rol{
	method fuerza()=0
	method esSoldado()=false
	method tengoHerramientas(maquina)
	method defenderSector(empleado){
		return empleado.bajarEstamina(empleado.estamina()/2)
	}
	method limpiarSector(sector,empleado){
		return empleado.bajarEstamina(sector.estaminaRequerida())
	}
	method puedoLimpiar(empleado,sector){
		return empleado.puedoLimpiar(sector)
	}
}

class Soldado inherits Rol{
	var property practica
	var property danioExtra
	override method fuerza(){
		return danioExtra*3
	}
	override method esSoldado()= true
	override method defenderSector(empleado){
		return empleado.bajarEstamina(1)
	}
}
class Obrero inherits Rol{
	var property herramientas = #{}
	override method tengoHerramientas(maquina){
		return maquina.herramientasRequqeridas().all(herramientas.contains())	
	}
	
}
class Mucama inherits Rol{
	override method defenderSector(empleado){
		return new Exception ("las mucamas no defienden")	
	}
	override method puedoLimpiar(empleado,sector){
		return true
	}
	override method limpiarSector(empleado,sector){
		return empleado.bajarEstamina(0)
	}
}
 
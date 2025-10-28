class Nave {
  const velocidadMaxima = 100000
  var velocidad
  var direccion
  var combustible
  
  method prepararViaje()
  method estaTranquila()
  method escapar()
  method avisar()
  method tenerPocaActividad()

  method estaDeRelajo() = self.estaTranquila() and self.tenerPocaActividad()

    method recibirAmenza(){
        self.escapar()
        self.avisar()
    }

  method condicionesDeTranquilidad() = (combustible >= 4000) and (velocidad <= 12000)
  
  
  method accionAdicional(){
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }
  
  method combustible() = combustible
  
  method acelerar(cuanto) {
    velocidad = (velocidad + cuanto).min(velocidadMaxima)
  }
  
  method desacelerar(cuanto) {
    velocidad = (velocidad - cuanto).max(0)
  }
  
  method irHaciaElSol() {
    direccion = 10
  }
  
  method escaparDelSol() {
    direccion = -10
  }
  
  method ponerseParaleloAlSol() {
    direccion = 0
  }
  
  method acercarseUnPocoAlSol() {
    direccion = (direccion + 1).min(10)
  }
  
  method alejarseUnPocoDelSol() {
    direccion = (direccion - 1).max(-10)
  }
  
  method cargarCombustible(cantidad) {
    combustible += cantidad
  }
  
  method descargarComustible(cantidad) {
    combustible = (combustible - cantidad).max(0)
  }
}

class NaveBaliza inherits Nave {
  var color
  var cambioDeColor = false
  method cambiarColorBaliza(nuevoColor) {
    color = nuevoColor
    cambioDeColor = true
  }
  
  method color() = color
  method cambioDeColor() = cambioDeColor
  
  override method prepararViaje() {
    self.accionAdicional()
    self.cambiarColorBaliza("verde")
    self.ponerseParaleloAlSol()
  }
  override method estaTranquila() = self.condicionesDeTranquilidad() and (self.color() !="rojo")
  override method tenerPocaActividad() = not self.cambioDeColor()
}

class NaveDePasajeros inherits Nave {
  var pasajeros
  var comida
  var bebida
  
  method pasajeros() = pasajeros
  
  method comida() = comida
  
  method bebida() = bebida
  
  override method prepararViaje() {
    self.accionAdicional()
    comida += self.pasajeros() * 4
    bebida += self.pasajeros() * 6
    self.acercarseUnPocoAlSol()
  }
  override method estaTranquila() = self.condicionesDeTranquilidad()
}

class NaveDeCombate inherits Nave {
  var invisible
  var misiles
  const mensajes = []
  
  method ponerseInvisible() {
    invisible = true
  }
  
  method ponerseVisible() {
    invisible = false
  }
  
  method estaInvisible() = invisible
  
  method desplegarMisilies() {
    misiles = true
  }
  
  method replegarMisilies() {
    misiles = false
  }
  
  method enviarMensaje(mensaje) {
    mensajes.add(mensaje)
  }
  
  method misilesDesplegados() = misiles
  
  method mensajesEmitidos() = mensajes
  
  method primerMensajeEmitido() = mensajes.first()
  
  method ultimoMensajeEmitido() = mensajes.last()
  
  method esEscueta() = not mensajes.any({ m => m.length() > 30 })
  
  method emitioMensaje(mensaje) {
    mensajes.contains(mensaje)
  }
  
  override method prepararViaje() {
    self.accionAdicional()  
    self.ponerseVisible()
    self.replegarMisilies()
    self.acelerar(15000)
    self.enviarMensaje("saliendo en mision")
  }
  override method estaTranquila() = self.condicionesDeTranquilidad() and not self.misilesDesplegados()
}

class NaveHospital inherits NaveDePasajeros{
    var quirofanosPreparados
    method quirofanos() = quirofanosPreparados
    method prepararQuirofanos(){
        quirofanosPreparados = true
    }
    method utilizarQuirofanos(){
        quirofanosPreparados = false
    }
    override method estaTranquila() = super() and not self.quirofanos()
}

class NaveSigilosa inherits NaveDeCombate{
    override method estaTranquila() = super() and not self.estaInvisible()
}
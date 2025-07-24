// Historia Interactiva: Hansel y Gretel viajando por el mundo
// Proyecto interactivo que simula una travesía por diferentes maravillas del mundo,
// personajes animados y navegación con estados.
// Gabriela Espitia y veronica Ibarra
import processing.sound.*;
import processing.sound.FFT;


// VARIABLES GENERALES

PImage fondoBosque, globoImg, mapaImg, machuImg, cristoImg, murallaImg;
BotonImagen botonMachu, botonCristo, botonMuralla;


SoundFile soundfile;
FFT fft;

// Controla la pantalla actual
int estado = 0; // 0 = bosque, 1 = mapa, 2 = machu, 3 = cristo, 4 = muralla
boolean mostrarIntro = false; // NUEVA VARIABLE


// INSTANCIAS DE CLASES

Personaje ninos;
BotonImagen globoBosque;
Lugar machu, cristo, muralla;


// SETUP

void setup() {
  size(1000, 800);
  noStroke();
  rectMode(CENTER);

  // Cargar imágenes
  fondoBosque = loadImage("fondo_bosque.png");
  globoImg = loadImage("globo.png");
  mapaImg = loadImage("mapa.png");
  machuImg = loadImage("machu.png");
  cristoImg = loadImage("cristo.png");
  murallaImg = loadImage("muralla.png");

  // Botones sobre el mapa (posición ajustable)
  botonMachu = new BotonImagen(machuImg, 100, 250, 200, 150);     // Puedes ajustar estas coordenadas
  botonCristo = new BotonImagen(cristoImg, 350, 250, 200, 150);   // según tu imagen del mapa
  botonMuralla = new BotonImagen(murallaImg, 750, 300, 150, 100);



  // Reproducir música de fondo
  soundfile = new SoundFile(this, "musica.mp3");
  soundfile.play();

  // Crear instancias, Inicialización de personajes y botones
  ninos = new Personaje(400, 600);
  globoBosque = new BotonImagen(globoImg, 650, 100, 400, 550);

  // Cada lugar tiene su propio mensaje personalizado
  machu = new Lugar(
    machuImg, globoImg,
    "Estás explorando Machu Picchu, haz click en el monumento!. Haz click en el globo para regresar al mapa.",
    "Machu Picchu: Ciudadela inca ubicada en las montañas de Perú. Famosa por su arquitectura en piedra y su conexión espiritual con la naturaleza y los astros."
    );

  cristo = new Lugar(
    cristoImg, globoImg,
    "Estás explorando el Cristo Redentor, haz click en el monumento!. Haz click en el globo para regresar al mapa.",
    "Cristo Redentor: Estatua monumental de Jesús ubicada en Río de Janeiro, Brasil. Es un ícono de la fe y la hospitalidad brasileña, y una de las nuevas maravillas del mundo."
    );

  muralla = new Lugar(
    murallaImg, globoImg,
    "Estás explorando la Muralla China, haz click en el monumento!. Haz click en el globo para regresar al mapa.",
    "Muralla China: Antigua estructura defensiva construida para proteger el imperio chino. Se extiende por miles de kilómetros y es símbolo de la fuerza y perseverancia de China."
    );
}


// DRAW: Lógica de visualización según estado


void draw() {
  background(200);

  if (estado == 0) { // Bosque inicial
    image(fondoBosque, 0, 0, width, height);
    globoBosque.mostrar();
    ninos.dibujar();
    mostrarTexto("Hanzel y Gretel encontraron el globo! Muévelos con las teclas ← → y haz clic en el globo al llegar. preciona ESPACIO!", 15);

    // Texto introductorio opcional (con barra espaciadora)
    if (mostrarIntro) {

      fill(255);
      textAlign(CENTER);
      textSize(16);
      text("Una experiencia interactiva donde el usuario visita diferentes maravillas del mundo\n"
        + "y accede a información e ilustraciones al tocar cada una.\n"
        + "Inspirado en una maleta de viaje que se abre y despliega destinos.", width / 2, 140);
    }
  } else if (estado == 1) { // // Pantalla del mapa
    image(mapaImg, 0, 0, width, height);
    mostrarTexto("Haz clic donde quieras explorar", 15);
  } else if (estado == 2) machu.mostrar(ninos);
  else if (estado == 3) cristo.mostrar(ninos);
  else if (estado == 4) muralla.mostrar(ninos);
}


// INTERACCIONES
// teclado


void keyPressed() {
  if (keyCode == RIGHT) ninos.mover(10);
  if (keyCode == LEFT) ninos.mover(-10);
  if (key == 's' || key == 'S') estado = 0;

  // Mostrar/ocultar introducción
  if (estado == 0 && key == ' ') {
    mostrarIntro = !mostrarIntro;
  }
}

// MOUSE
void mousePressed() {
  if (estado == 0) {
    if (globoBosque.estaSobre(mouseX, mouseY)) {
      estado = 1; // Ir al mapa
    }
  } else if (estado == 1) {
    // Clic en botones del mapa
    if (botonMachu.estaSobre(mouseX, mouseY)) {
      estado = 2; // toggle de descripcion
    } else if (botonCristo.estaSobre(mouseX, mouseY)) {
      estado = 3;
    } else if (botonMuralla.estaSobre(mouseX, mouseY)) {
      estado = 4;
    }
  } else if (estado == 2) {
    // En Machu Picchu
    if (machu.clicEnGlobo(mouseX, mouseY)) {
      estado = 1;
    } else {
      machu.mostrarInfo = !machu.mostrarInfo;
    }
  } else if (estado == 3) {
    // En Cristo Redentor
    if (cristo.clicEnGlobo(mouseX, mouseY)) {
      estado = 1;
    } else {
      cristo.mostrarInfo = !cristo.mostrarInfo;
    }
  } else if (estado == 4) {
    // En Muralla China
    if (muralla.clicEnGlobo(mouseX, mouseY)) {
      estado = 1;
    } else {
      muralla.mostrarInfo = !muralla.mostrarInfo;
    }
  }
}



// CLASES personalizadas

// Clase que representa al personaje (niños)


class Personaje {
  int x, y;

  Personaje(int x, int y) {
    this.x = x;
    this.y = y;
  }

  void mover(int dx) {
    x += dx;
  }

  void resetX() {
    x = 100;
  }

  void dibujar() {
    dibujarNinos(x, y);
  }
}

// Clase reutilizable para representar botones con imagen

class BotonImagen {
  PImage img;
  int x, y, w, h;

  BotonImagen(PImage img, int x, int y, int w, int h) {
    this.img = img;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void mostrar() {
    image(img, x, y, w, h);
  }

  // Verifica si el mouse está sobre el botón

  boolean estaSobre(int mx, int my) {
    return mx > x && mx < x + w && my > y && my < y + h;
  }
}


// CLASE PARA CADA LUGAR

// Clase que representa cada lugar turístico

class Lugar {
  PImage fondo;
  BotonImagen globo;
  String mensaje;
  String infoExtra;
  boolean mostrarInfo = false;

  Lugar(PImage fondo, PImage globoImg, String mensaje, String infoExtra) {
    this.fondo = fondo;
    this.globo = new BotonImagen(globoImg, 750, 0, 250, 350);
    this.mensaje = mensaje;
    this.infoExtra = infoExtra;
  }

  // Mostrar el lugar
  void mostrar(Personaje personaje) {
    image(fondo, 0, 0, width, height);
    personaje.dibujar();
    globo.mostrar();
    mostrarTexto(mensaje, 15);
    // Mostrar información extra si está activada

    if (mostrarInfo) {
      mostrarTextoInfo(infoExtra);
    }
  }

  void activarInfo() {
    mostrarInfo = true;
  }

  boolean clicEnGlobo(int mx, int my) {
    return globo.estaSobre(mx, my);
  }
  // Muestra una caja de texto en la parte inferior
  void mostrarTextoInfo(String texto) {
    fill(0, 200);
    rect(width/2, height - 100, 800, 100, 20);
    fill(255);
    textSize(14);
    textAlign(CENTER, CENTER);
    text(texto, width / 2, height - 100, 780, 100);
  }
}


// FUNCIONES DE APOYO

// Mostrar texto principal en la parte superior

void mostrarTexto(String mensaje, int tam) {
  fill(0);
  textSize(tam);
  textAlign(CENTER, TOP);
  text(mensaje, width / 2, 20);
}

// Función que dibuja a los niños
// Dibujo detallado de los personajes Hansel y Gretel

void dibujarNinos(int x, int y) {
  color piel = #F2BE95;
  color pelo = #EAD682;
  color rojoVestido = #BF3436;
  color mediasAzules = #3E79BF;
  color zapatosNina = #24814D;
  color ropaNino = #248175;
  color ropaNino2 = #54A062;
  color zapatosNino = #3E4D89;
  color zapatosNino2 = #686E86;

  int dx = -80;

  fill(piel);
  rect(x + dx - 15, y + 80, 20, 100, 5);
  rect(x + dx + 15, y + 80, 20, 100, 5);
  fill(mediasAzules);
  rect(x + dx - 15, y + 130, 20, 20, 5);
  rect(x + dx + 15, y + 130, 20, 20, 5);
  fill(zapatosNina);
  ellipse(x + dx - 15, y + 145, 30, 20);
  ellipse(x + dx + 15, y + 145, 30, 20);

  fill(rojoVestido);
  rect(x + dx, y, 80, 150, 10);
  fill(piel);
  rect(x + dx - 50, y, 20, 80, 5);
  rect(x + dx + 50, y, 20, 80, 5);
  fill(rojoVestido);
  rect(x + dx - 50, y - 20, 30, 80, 5);
  rect(x + dx + 50, y - 20, 30, 80, 5);

  fill(pelo);
  ellipse(x + dx + 8, y - 50, 70, 95);
  ellipse(x + dx, y - 110, 80, 80);

  dx = +80;

  fill(ropaNino);
  rect(x + dx - 15, y + 100, 30, 90, 5);
  rect(x + dx + 15, y + 100, 30, 90, 5);
  fill(zapatosNino);
  arc(x + dx - 15, y + 145, 40, 30, -PI, 0);
  arc(x + dx + 15, y + 145, 40, 30, -PI, 0);
  fill(zapatosNino2);
  rect(x + dx - 15, y + 150, 40, 8, 10);
  rect(x + dx + 15, y + 150, 40, 8, 10);

  fill(ropaNino);
  rect(x + dx, y - 20, 80, 180, 10);
  fill(piel);
  rect(x + dx - 50, y - 20, 25, 80, 5);
  rect(x + dx + 50, y - 20, 25, 80, 5);
  ellipse(x + dx - 50, y + 20, 25, 25);
  ellipse(x + dx + 50, y + 20, 25, 25);
  ellipse(x + dx - 50, y + 40, 25, 25);
  ellipse(x + dx + 50, y + 40, 25, 25);

  fill(ropaNino2);
  rect(x + dx - 50, y - 20, 30, 120, 5);
  rect(x + dx + 50, y - 20, 30, 120, 5);

  fill(piel);
  ellipse(x + dx, y - 160, 80, 75);
  rect(x + dx, y - 120, 40, 30, 10);
  fill(pelo);
  ellipse(x + dx + 20, y - 160, 50, 70);
  ellipse(x + dx, y - 180, 80, 35);
}

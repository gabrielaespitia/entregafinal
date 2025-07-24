// codigo final hanzel y gretel.

PImage fondoBosque, globoImg, mapaImg, machuImg, cristoImg, murallaImg;
int estado = 0; // 0 = bosque, 1 = mapa, 2 = machu, 3 = cristo, 4 = muralla

int posX = 400;
int posY = 600;

// COLORES
color piel = #F2BE95;
color pelo = #EAD682;
color rojoVestido = #BF3436;
color mediasAzules = #3E79BF;
color zapatosNina = #24814D;
color ropaNino = #248175;
color ropaNino2 = #54A062;
color zapatosNino = #3E4D89;
color zapatosNino2 = #686E86;

import processing.sound.*;
import processing.sound.FFT;

SoundFile soundfile;
FFT fft;

void setup() {
  size(1000, 800);
  noStroke();
  rectMode(CENTER);

  soundfile = new SoundFile(this, "musica.mp3");

  // reproducir la cancion
  soundfile.play();

  fondoBosque = loadImage("fondo_bosque.png");
  globoImg = loadImage("globo.png");
  mapaImg = loadImage("mapa.png");
  machuImg = loadImage("machu.png");
  cristoImg = loadImage("cristo.png");
  murallaImg = loadImage("muralla.png");
}

void draw() {
  background(200);


  if (estado == 0) { // Bosque
    image(fondoBosque, 0, 0, width, height);
    image(globoImg, 650, 100, 400, 550);
    dibujarNinos(posX, posY);
    fill(255);// Color del texto
    textSize(15); // Tamaño del texto
    textAlign(CENTER, TOP); // Centrado horizontalmente, alineado arriba
    text("Hanzel y Gretel encontraron el globo! muevelos con las teclas derecha e izquierda para guiar su camino, presionalo (mouse) al llegar", width / 2, 20); // Posición centrada
  } else if (estado == 1) { // Mapa
    background(255);
    image(mapaImg, 0, 0, width, height);
    fill(0);// Color del texto
    textSize(15); // Tamaño del texto
    textAlign(CENTER, TOP); // Centrado horizontalmente, alineado arriba
    text("Haz clic donde quieras explorar!", width / 2, 20);
  } else if (estado == 2) { // Machu Picchu
    image(machuImg, 0, 0, width, height);
    dibujarNinos(posX, posY);
    image(globoImg, 750, 0, 250, 350);
    fill(0);// Color del texto
    textSize(15); // Tamaño del texto
    textAlign(CENTER, TOP); // Centrado horizontalmente, alineado arriba
    text(" Haz click en el monumento! Al acabar la exploración, vuelve al globo.", width / 2, 20);
  } else if (estado == 3) { // Cristo Redentor
    image(cristoImg, 0, 0, width, height);
    dibujarNinos(posX, posY);
    image(globoImg, 750, 0, 250, 350);
    fill(0);// Color del texto
    textSize(15); // Tamaño del texto
    textAlign(CENTER, TOP); // Centrado horizontalmente, alineado arriba
    text(" Haz click en el monumento! Al acabar la exploración, vuelve al globo.", width / 2, 20);
  } else if (estado == 4) { // Muralla China
    image(murallaImg, 0, 0, width, height);
    dibujarNinos(posX, posY);
    image(globoImg, 750, 0, 250, 350);
    fill(0);// Color del texto
    textSize(15); // Tamaño del texto
    textAlign(CENTER, TOP); // Centrado horizontalmente, alineado arriba
    text(" Haz click en el monumento! Al acabar la exploración, vuelve al globo.", width / 2, 20);
  }
}

void keyPressed() {
  if (keyCode == RIGHT) posX += 10;
  if (keyCode == LEFT) posX -= 10;

  if (key == 's' || key == 'S') {
    estado = 0;
  }
}

void mousePressed() {
  if (estado == 0) {
    if (mouseX > 650 && mouseX < 1050 && mouseY > 100 && mouseY < 650) {
      estado = 1;
    }
  } else if (estado == 1) {
    if (mouseX < width/3) {
      estado = 2;
      posX = 100;
    } else if (mouseX < 2*width/3) {
      estado = 3;
      posX = 100;
    } else {
      estado = 4;
      posX = 100;
    }
  } else if (estado >= 2 && estado <= 4) {
    if (mouseX > 850 && mouseX < 950 && mouseY > 50 && mouseY < 180) {
      estado = 1;
    }
  }
}

// NUEVA FUNCIÓN: Dibuja ambos niños en grupo
void dibujarNinos(int x, int y) {

  // NIÑA (a la izquierda)
  int dx = -80;

  // Piernas
  fill(piel);
  rect(x + dx - 15, y + 80, 20, 100, 5);
  rect(x + dx + 15, y + 80, 20, 100, 5);
  fill(mediasAzules);
  rect(x + dx - 15, y + 130, 20, 20, 5);
  rect(x + dx + 15, y + 130, 20, 20, 5);
  fill(zapatosNina);
  ellipse(x + dx - 15, y + 145, 30, 20);
  ellipse(x + dx + 15, y + 145, 30, 20);

  // Vestido y brazos
  fill(rojoVestido);
  rect(x + dx, y, 80, 150, 10);
  fill(piel);
  rect(x + dx - 50, y, 20, 80, 5);
  rect(x + dx + 50, y, 20, 80, 5);
  fill(rojoVestido);
  rect(x + dx - 50, y - 20, 30, 80, 5);
  rect(x + dx + 50, y - 20, 30, 80, 5);

  // Pelo y cabeza
  fill(pelo);
  ellipse(x + dx + 8, y - 50, 70, 95);
  ellipse(x + dx, y - 110, 80, 80); // cabeza color pelo

  // NIÑO (a la derecha)
  dx = +80;

  // Piernas
  fill(ropaNino);
  rect(x + dx - 15, y + 100, 30, 90, 5);
  rect(x + dx + 15, y + 100, 30, 90, 5);
  fill(zapatosNino);
  arc(x + dx - 15, y + 145, 40, 30, -PI, 0);
  arc(x + dx + 15, y + 145, 40, 30, -PI, 0);
  fill(zapatosNino2);
  rect(x + dx - 15, y + 150, 40, 8, 10);
  rect(x + dx + 15, y + 150, 40, 8, 10);

  // Tronco y brazos
  fill(ropaNino);
  rect(x + dx, y - 20, 80, 180, 10);
  fill(piel);
  rect(x + dx - 50, y - 20, 25, 80, 5); // brazo izquierdo
  rect(x + dx + 50, y - 20, 25, 80, 5); // brazo derecho
  ellipse(x + dx - 50, y + 20, 25, 25); // mano izquierda
  ellipse(x + dx + 50, y + 20, 25, 25); // mano derecha

  // manos nino
  fill(piel);
  ellipse(x + dx - 50, y + 40, 25, 25); // mano izquierda
  ellipse(x + dx + 50, y + 40, 25, 25); // mano derecha


  fill(ropaNino2);
  rect(x + dx - 50, y - 20, 30, 120, 5);
  rect(x + dx + 50, y - 20, 30, 120, 5);

  // Cabeza y cabello
  fill(piel);
  ellipse(x + dx, y - 160, 80, 75);
  rect(x + dx, y - 120, 40, 30, 10);
  fill(pelo);
  ellipse(x + dx + 20, y - 160, 50, 70);
  ellipse(x + dx, y - 180, 80, 35);
}

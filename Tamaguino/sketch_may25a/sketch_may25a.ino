#include <Adafruit_GFX.h>
#include <TFT_ILI9163C.h>
#include <SPI.h>

#define TFT_CS     10
#define TFT_RST    9
#define TFT_DC     8

TFT_ILI9163C tft = TFT_ILI9163C(TFT_CS, TFT_DC, TFT_RST);

int vida = 100;
int hambre = 0;
int felicidad = 100;

unsigned long lastFeedTime = 0;
unsigned long lastPlayTime = 0;

void setup() {
  Serial.begin(9600);
  tft.begin();
  tft.setRotation(3);
  tft.fillScreen(tft.Color565(0, 0, 0)); // Negro
}

void loop() {
  // Actualizar estado
  unsigned long currentTime = millis();
  if (currentTime - lastFeedTime > 5000) {
    if (hambre < 100) hambre++;
    lastFeedTime = currentTime;
  }
  if (currentTime - lastPlayTime > 3000) {
    if (felicidad > 0) felicidad--;
    lastPlayTime = currentTime;
  }
  if (vida > 0 && vida <= 100) vida = vida - hambre/200 - (100 - felicidad)/100;
  
  // Dibujar pantalla
  tft.fillScreen(tft.Color565(0, 0, 0)); // Negro
  tft.setTextColor(tft.Color565(255, 255, 255)); // Blanco
  tft.setCursor(5, 5);
  tft.setTextSize(2);
  tft.print("Tamagotchi");

  tft.setCursor(5, 25);
  tft.setTextSize(1);
  tft.print("Vida: ");
  tft.print(vida);

  tft.setCursor(5, 45);
  tft.print("Hambre: ");
  tft.print(hambre);

  tft.setCursor(5, 65);
  tft.print("Felicidad: ");
  tft.print(felicidad);

  tft.setCursor(5, 85);
  tft.print("Ultima comida: ");
  tft.print((currentTime - lastFeedTime) / 1000);
  tft.print("s");

  tft.setCursor(5, 105);
  tft.print("Ultimo juego: ");
  tft.print((currentTime - lastPlayTime) / 1000);
  tft.print("s");

  delay(1000000); // Actualizar cada 100ms
}

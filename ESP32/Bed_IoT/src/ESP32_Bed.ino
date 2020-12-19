/*
 *  This sketch demonstrates how to scan WiFi networks.
 *  The API is almost the same as with the WiFi Shield library,
 *  the most obvious difference being the different file you need to include:
 */
#include "WiFi.h"
#include "HTTPClient.h"
#include <ArduinoJson.h>
int contador =0;
void setup()
{
    Serial.begin(115200);

    WiFi.begin("iPhone de Sergio", "noteconectes");

    while (WiFi.status() != WL_CONNECTED)
    {
        delay(500);
        Serial.print("Connected to this Wifi with IP: ");
        Serial.println(WiFi.localIP());
    }
    
}


void loop() {
  // put your main code here, to run repeatedly:
  if(WiFi.status() == WL_CONNECTED){
      
    HTTPClient http;
    http.begin("https://us-central1-smarthospital-c09f4.cloudfunctions.net/app/api/update/TUHyuoIHW3lClcy8kDq5");
    http.addHeader("Content-Type", "application/json");
    
    StaticJsonDocument<20> tempDocument;
    tempDocument["value"] = contador;
    char buffer[20];
    serializeJson(tempDocument, buffer);
    Serial.println(buffer);
    http.PATCH(buffer);
    http.end();
    
    contador +=1;
  }else{
    Serial.println("Check your wifi connection");
  }

  delay(100);

}
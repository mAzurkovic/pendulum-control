#include <Encoder.h>

// Pins
#define ENC_A 2
#define ENC_B 3
#define OUT_PIN 9
// Gains
#define K_GAIN 10
#define SETPOINT 90
#define ENC_GAIN 2*PI/1024

// Global objects and variables
Encoder enc(ENC_A, ENC_B);
float err;
float currentPos;
int output; 

void setup() {
  pinMode(OUT_PIN, OUTPUT);
  // Set initial position of motor
  enc.write(0);
}

void loop() {
  currentPos = ENC_GAIN * enc.read();       // Read current position and account for gain
  err = (SETPOINT * PI/180) - currentPos;   // Compute set-point error
  output = (int) K_GAIN * err;              // Compute the control output
  analogWrite(OUT_PIN, output);             // Write to output pin, will automatically saturate the value (+/-5V)
}

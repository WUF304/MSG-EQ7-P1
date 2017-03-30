/*
need to set the ADC resolution to 8 bit for this code.
put analogReadResolution(8); into setup
*/

// Get audio spectrum data
void read_audio_fast()
{
  for (uint8_t band = 0; band < 7; band++)
  {
    FastPin<STROBE_PIN>::lo();
    delayMicroseconds(27);
    left[band] = analogRead(A1);
    right[band] = analogRead(A2);
    FastPin<STROBE_PIN>::hi();
  }
}

// Audio data smoothing
void soften_spectrum_data()
{
  for (byte i = 0; i < 7; i++)
  {
    uint8_t old = bands[i];
    uint16_t data = left[i] + right[i] + old + old;
    data = data / 4;
    bands[i] = data;
  }
}

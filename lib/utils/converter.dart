/// Converts temperature between Fahrenheit and Celsius.
/// This function takes a temperature value and a boolean flag to determine the conversion direction.
/// If [isFToC] is true, it converts from Fahrenheit to Celsius; otherwise, it converts from Celsius to Fahrenheit.
/// The following formulas are used:
/// - Fahrenheit to Celsius: °C = (°F - 32) × 5/9
/// - Celsius to Fahrenheit: °F = (°C × 9/5) + 32
/// Returns the converted temperature value as a double
double convertTemperature(double inputValue, bool isFToC) {
  return isFToC ? (inputValue - 32) * 5 / 9 : (inputValue * 9 / 5) + 32;
}

import 'package:flutter/material.dart';
import '../models/conversion_history.dart';
import '../utils/converter.dart';
import '../widgets/conversion_selector.dart';
import '../widgets/temperature_section.dart';
import '../widgets/conversion_history.dart';

/// The main screen of the Converter app.
class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  // Controller for the input text field
  final TextEditingController _inputController = TextEditingController();

  // Flag to determine conversion direction: true for F to C, false for C to F
  bool _isFahrenheitToCelsius = true;

  // Holds the converted temperature value
  double? _convertedValue;

  // List to store conversion history
  final List<ConversionHistory> _conversionHistory = [];

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  /// Handles the temperature conversion process.
  ///
  /// This method:
  /// 1. Validates the input value
  /// 2. Performs the conversion
  /// 3. Updates the conversion history
  /// 4. Updates the UI state
  void _handleConversion() {
    // Validate empty input
    if (_inputController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a temperature value')),
      );
      return;
    }

    // Validate numeric input
    final inputValue = double.tryParse(_inputController.text);
    if (inputValue == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid number')),
      );
      return;
    }

    // Perform conversion and update history
    final convertedValue = convertTemperature(
      inputValue,
      _isFahrenheitToCelsius,
    );
    final historyEntry = ConversionHistory(
      type: _isFahrenheitToCelsius ? 'F to C' : 'C to F',
      inputValue: inputValue,
      outputValue: convertedValue,
    );

    setState(() {
      _convertedValue = convertedValue;
      _conversionHistory.insert(0, historyEntry);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Converter',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        elevation: 0,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return _buildPortraitLayout();
          } else {
            return _buildLandscapeLayout();
          }
        },
      ),
    );
  }

  /// Builds the portrait layout of the app.
  Widget _buildPortraitLayout() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConversionSelector(
                    isFahrenheitToCelsius: _isFahrenheitToCelsius,
                    onChanged: (value) {
                      setState(() {
                        _isFahrenheitToCelsius = value;
                        _convertedValue = null;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TemperatureSection(
                    inputController: _inputController,
                    convertedValue: _convertedValue,
                    onInputChanged: () {
                      if (_convertedValue != null) {
                        setState(() {
                          _convertedValue = null;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _handleConversion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero, // No border radius
                        ),
                      ),
                      child: const Text(
                        'CONVERT',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ConversionHistorySection(history: _conversionHistory),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the landscape layout of the app.
  ///
  /// This layout arranges components horizontally:
  /// - Conversion controls on the left
  /// - History section on the right
  Widget _buildLandscapeLayout() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConversionSelector(
                        isFahrenheitToCelsius: _isFahrenheitToCelsius,
                        onChanged: (value) {
                          setState(() {
                            _isFahrenheitToCelsius = value;
                            _convertedValue = null;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      TemperatureSection(
                        inputController: _inputController,
                        convertedValue: _convertedValue,
                        onInputChanged: () {
                          if (_convertedValue != null) {
                            setState(() {
                              _convertedValue = null;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _handleConversion,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.zero, // No border radius
                            ),
                          ),
                          child: const Text(
                            'CONVERT',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ConversionHistorySection(history: _conversionHistory),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

const String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzIwNDAwNTQyLCJleHAiOjE3MjI5OTI1NDJ9.eFeAwJxFskbUmOUGcKLtA5gNribRoATe_MGp7omuZvQ';

class AddWorkerPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dailyRateController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final _genderOptions = ['Male', 'Female', 'Prefer not to say'];
  final _serviceOptions = ['Electrician', 'Helper', 'Carpenter', 'No Service'];
  final _countryOptions = [
    "Pakistan", "Rwanda", "Tanzania", "United States"
  ];
  String? _selectedGender;
  String? _selectedService;
  String? _selectedCountry;

  Future<int> getWorkerCount() async {
    final response = await http.get(
      Uri.parse('http://localhost:1337/workforces/count'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      throw Exception('Failed to load worker count');
    }
  }

  Future<void> submitWorkerData(Map<String, dynamic> workerData) async {
    final response = await http.post(
      Uri.parse('http://localhost:1337/workforces/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(workerData),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to submit worker data');
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        int currentCount = await getWorkerCount();
        int newId = currentCount + 1;

        Map<String, dynamic> workerData = {
          "id": newId,
          "worker_id": newId,
          "phone_number": phoneController.text,
          "national_id": nationalIdController.text,
          "project_name": "Interview-1",
          "daily_earnings": int.parse(dailyRateController.text),
          "trade": _selectedService,
          "names": nameController.text,
          "date_onboarded": DateFormat('yyyy-MM-dd').format(DateTime.now()),
          "gender": _selectedGender == 'Male' ? 'male' : _selectedGender == 'Female' ? 'female' : 'none',
          "country": _selectedCountry,
        };

        await submitWorkerData(workerData);

        Get.back();
        Get.snackbar('Success', 'This worker has been added',
            snackPosition: SnackPosition.BOTTOM);
      } catch (e) {
        Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  bool isRwandanNationalIdValid(String nationalId) {
    if (nationalId.length != 16) return false;
    final validPrefixes = ['11', '12', '21', '22'];
    return validPrefixes.any((prefix) => nationalId.startsWith(prefix));
  }

  bool isRwandanPhoneNumberValid(String phoneNumber) {
    final regex = RegExp(r'^07\d{8}$');
    return regex.hasMatch(phoneNumber);
  }

  bool isAgeValid(String dob) {
    final birthDate = DateFormat('yyyy-MM-dd').parse(dob);
    final currentDate = DateTime.now();
    final age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month || (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
      return age > 18;
    }
    return age >= 18;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Worker"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(controller: nameController, label: "Name"),
              _buildDropdownField(
                value: _selectedCountry,
                label: "Country",
                items: _countryOptions,
                onChanged: (String? newValue) {
                  _selectedCountry = newValue;
                },
              ),
              _buildNumericField(controller: nationalIdController, label: "National ID"),
              _buildNumericField(controller: phoneController, label: "Phone Number"),
              _buildDropdownField(
                value: _selectedGender,
                label: "Gender",
                items: _genderOptions,
                onChanged: (String? newValue) {
                  _selectedGender = newValue;
                },
              ),
              _buildDateField(context, dobController, "DOB"),
              _buildDropdownField(
                value: _selectedService,
                label: "Service",
                items: _serviceOptions,
                onChanged: (String? newValue) {
                  _selectedService = newValue;
                },
              ),
              _buildNumericField(controller: dailyRateController, label: "Daily Rate"),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownField({required String? value, required String label, required List<String> items, required Function(String?) onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) {
          onChanged(newValue);
          _formKey.currentState!.validate(); // Revalidate form on country change
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDateField(BuildContext context, TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        onTap: () => _selectDate(context),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          if (_selectedCountry == 'Rwanda' && !isAgeValid(value)) {
            return 'Worker must be at least 18 years old';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildNumericField({required TextEditingController controller, required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          if (_selectedCountry == 'Rwanda') {
            if (label == 'National ID' && !isRwandanNationalIdValid(value)) {
              return 'National ID must be 16 digits and start with 11, 12, 21, or 22';
            }
            if (label == 'Phone Number' && !isRwandanPhoneNumberValid(value)) {
              return 'Phone number must be in the format 07xxxxxxxx';
            }
          }
          if (double.tryParse(value) == null) {
            return 'Please enter a valid number';
          }
          return null;
        },
      ),
    );
  }
}

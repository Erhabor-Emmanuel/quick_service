import 'package:flutter/material.dart';


class BookingState extends ChangeNotifier {

  DateTime? selectedDate;
  String? selectedTime;
  int selectedDuration = 1;


  List<String> bookedSlots = ['11:00 AM', '3:00 PM', '7:00 PM'];


  void selectDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }


  void selectTime(String time) {
    selectedTime = time;
    notifyListeners();
  }

  // When user picks duration (1, 2, or 3 hours)
  void selectDuration(int duration) {
    selectedDuration = duration;
    notifyListeners(); // This tells Flutter to refresh the screen
  }

  // Check if a time slot is already booked
  bool isTimeBooked(String time) {
    return bookedSlots.contains(time);
  }

  // Check if user can click the confirm button
  // They can only confirm if they picked both date AND time
  bool canConfirm() {
    return selectedDate != null && selectedTime != null;
  }

  // Calculate the total price
  // Formula: hourly rate × number of hours
  double calculateTotal(double hourlyRate) {
    return hourlyRate * selectedDuration;
  }

  // Clear everything (reset to default)
  void reset() {
    selectedDate = null;
    selectedTime = null;
    selectedDuration = 1;
    notifyListeners(); // This tells Flutter to refresh the screen
  }
}
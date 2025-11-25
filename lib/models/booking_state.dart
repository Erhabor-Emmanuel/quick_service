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


  void selectDuration(int duration) {
    selectedDuration = duration;
    notifyListeners();
  }


  bool isTimeBooked(String time) {
    return bookedSlots.contains(time);
  }


  bool canConfirm() {
    return selectedDate != null && selectedTime != null;
  }


  double calculateTotal(double hourlyRate) {
    return hourlyRate * selectedDuration;
  }


  void reset() {
    selectedDate = null;
    selectedTime = null;
    selectedDuration = 1;
    notifyListeners();
  }
}
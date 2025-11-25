import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/provider_model.dart';
import '../models/booking_state.dart';


class BookingScreen extends StatelessWidget {
  final CardProvider provider;

  const BookingScreen({super.key, required this.provider});


  List<DateTime> getNext7Days() {
    List<DateTime> days = [];
    DateTime today = DateTime.now();

    for (int i = 0; i < 7; i++) {
      days.add(today.add(Duration(days: i)));
    }

    return days;
  }

  @override
  Widget build(BuildContext context) {

    final timeSlots = [
      '9:00 AM',
      '11:00 AM',
      '1:00 PM',
      '3:00 PM',
      '5:00 PM',
      '7:00 PM',
    ];

    return ChangeNotifierProvider(
      create: (context) => BookingState(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text('Book Service'),
          backgroundColor: const Color(0xFF2E7D32),
          foregroundColor: Colors.white,
        ),
        body: Consumer<BookingState>(
          builder: (context, bookingState, child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(provider.imageUrl),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                provider.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 16),
                                  const SizedBox(width: 4),
                                  Text(provider.rating.toString()),
                                  const SizedBox(width: 12),
                                  Text(
                                    '\$${provider.hourlyRate.toStringAsFixed(0)}/hr',
                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Select Date',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Horizontal list of next 7 days
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        final date = getNext7Days()[index];
                        final isSelected = bookingState.selectedDate != null &&
                            DateUtils.isSameDay(bookingState.selectedDate, date);

                        return GestureDetector(
                          onTap: () => bookingState.selectDate(date),
                          child: Container(
                            width: 70,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF2E7D32)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat('EEE').format(date), // Mon, Tue, etc
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  DateFormat('d').format(date), // Day number
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // "Select Time" title
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Select Time',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Time slots in a grid (2 columns)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: timeSlots.length,
                      itemBuilder: (context, index) {
                        final time = timeSlots[index];
                        final isBooked = bookingState.isTimeBooked(time);
                        final isSelected = bookingState.selectedTime == time;

                        return GestureDetector(
                          onTap: isBooked ? null : () => bookingState.selectTime(time),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isBooked
                                  ? Colors.grey[300]
                                  : isSelected
                                  ? const Color(0xFF2E7D32)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                isBooked ? '$time (Booked)' : time,
                                style: TextStyle(
                                  color: isBooked
                                      ? Colors.grey
                                      : isSelected
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // "Duration" title
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Duration',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Dropdown to select 1, 2, or 3 hours
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton<int>(
                        value: bookingState.selectedDuration,
                        isExpanded: true,
                        underline: const SizedBox(),
                        items: [1, 2, 3].map((duration) {
                          return DropdownMenuItem(
                            value: duration,
                            child: Text('$duration hour${duration > 1 ? 's' : ''}'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            bookingState.selectDuration(value);
                          }
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Total Price display
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Price',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${bookingState.calculateTotal(provider.hourlyRate).toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Confirm button (disabled until date and time are selected)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: bookingState.canConfirm()
                            ? () async {
                          // Show loading spinner for 0.5 seconds
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                          );

                          await Future.delayed(const Duration(milliseconds: 500));

                          Navigator.pop(context); // Close loading

                          // Show success popup
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Booking Confirmed!'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Provider: ${provider.name}'),
                                  Text('Date: ${DateFormat('MMM d, yyyy').format(bookingState.selectedDate!)}'),
                                  Text('Time: ${bookingState.selectedTime}'),
                                  Text('Duration: ${bookingState.selectedDuration} hour${bookingState.selectedDuration > 1 ? 's' : ''}'),
                                  Text('Total: \$${bookingState.calculateTotal(provider.hourlyRate).toStringAsFixed(0)}'),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Close dialog
                                    Navigator.pop(context); // Go back to list
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: bookingState.canConfirm()
                              ? const Color(0xFF2E7D32)
                              : Colors.grey,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Confirm Booking',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
import 'package:auto_route/auto_route.dart';
import 'package:image_delete_demo/core/modals/scrollable_sheet_page.dart';
import 'package:image_delete_demo/core/theme/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

@RoutePage()
class DateTimePickerBottomSheetPage extends StatefulWidget {
  const DateTimePickerBottomSheetPage({super.key, this.initialDate});

  final DateTime? initialDate;

  @override
  State<DateTimePickerBottomSheetPage> createState() =>
      _DateTimePickerBottomSheetPageState();
}

class _DateTimePickerBottomSheetPageState
    extends State<DateTimePickerBottomSheetPage> {
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return ScrollableSheetPage(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                use24hFormat: true,
                initialDateTime: widget.initialDate ?? DateTime.now(),
                onDateTimeChanged: (DateTime value) {
                  _selectedDate = value;
                },
              ),
            ),
            Gap(32),
            StyledButton.filled(
              title: "ok ;p",
              onPressed: () {
                context.router.maybePop(_selectedDate);
              },
            ),
          ],
        ),
      ),
    );
  }
}

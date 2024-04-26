import 'package:flutter_test/flutter_test.dart';
import 'package:qur_an/utils/schedule_prayer.dart';

void main() async {
  test("Test Schedule Prayer", () async {
    // Arrange
    final SchedulePrayer schedulePrayer = SchedulePrayer();

    // Act
    final resSetSchdule = await schedulePrayer.getSchedule();
    print(resSetSchdule);
  });
}

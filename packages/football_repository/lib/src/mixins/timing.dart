import 'dart:async';

mixin Timing {
  Timer? timer = null;
  Duration duration = Duration(minutes: 20);

  void startTimer() {
    timer = Timer.periodic(
      duration,
      (timer) {
        final remainingSeconds = duration.inSeconds - 1;
        if (remainingSeconds < 0) {
          timer?.cancel();
        } else {
          duration = Duration(seconds: remainingSeconds);
        }
      },
    );
  }

  bool get timerIsActive => timer?.isActive ?? false;
}

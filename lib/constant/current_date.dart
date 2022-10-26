import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class CurrentDate {
  static Map days = {
    "1": "Senin",
    "2": "Selasa",
    "3": "Rabu",
    "4": "Kamis",
    "5": "Jumat",
    "6": "Sabtu",
    "7": "Minggu"
  };

  static Map months = {
    "1": "Januari",
    "2": "Februari",
    "3": "Marer",
    "4": "April",
    "5": "Mei",
    "6": "Juni",
    "7": "Juli",
    "8": "Agustus",
    "9": "September",
    "10": "Oktober",
    "11": "November",
    "12": "Desember"
  };

  static dynamic dateNow;

  static dynamic updateNow() {
    tz.initializeTimeZones();
    var wib = tz.getLocation('Asia/Jakarta');
    dateNow = tz.TZDateTime.now(wib);
  }

  static String getDay() {
    updateNow();
    return days[dateNow.weekday.toString()];
  }

  static int getDate() {
    updateNow();
    return dateNow.day;
  }

  static String getMonth() {
    updateNow();
    return months[dateNow.month.toString()];
  }

  static int getYear() {
    updateNow();
    return dateNow.year;
  }
}

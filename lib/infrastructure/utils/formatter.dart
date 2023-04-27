class StrFormater {

  static String ellipsisCenter(String str) {
    try {
      return str.replaceRange(10, str.length - 10, '....');
    } catch (e) {
      return str;
    }
  }

  static String duration(Duration duration) =>
      RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
          .firstMatch('$duration')
          ?.group(1) ??
          '$duration';

  static String durationInSeconde(int secondes) =>
      RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
          .firstMatch('${Duration(seconds: secondes)}')
          ?.group(1) ??
          '${Duration(seconds: secondes)}';


  static printDuration(Duration d) => d.toString().split('.').first.padLeft(8, "0");

}

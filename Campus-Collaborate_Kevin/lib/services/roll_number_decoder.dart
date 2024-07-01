class RollNumberDecoder {
  final int rollNumber;

  RollNumberDecoder({required this.rollNumber});

  String getBranch() {
    final rollNumberString = rollNumber.toString();

    final branchCode = rollNumberString.substring(4, 6);

    switch (branchCode) {
      case "06":
        return "BSBE";
      case "07":
        return "CL";
      case "22":
        return "CST";
      case "04":
        return "CE";
      case "01":
        return "CSE";
      case "50":
        return "DSAI";
      case "02":
        return "ECE";
      case "08":
        return "EEE";
      case "21":
        return "EP";
      case "23":
        return "MnC";
      case "03":
        return "ME";
      default:
        return "Unknown Branch";
    }
  }
}

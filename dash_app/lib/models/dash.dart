class Dash {
  Dash(int datemonth, double value, String lang) {
    this.monthNumber = datemonth;
    switch (datemonth) {
      case 1:
        this.month = 'Jan';
        break;
      case 2:
        this.month = 'Feb';
        break;
      case 3:
        this.month = 'Mar';
        break;
      case 4:
        this.month = 'Apr';
        break;
      case 5:
        this.month = lang == "en" ? 'May' : 'Mai';
        break;
      case 6:
        this.month = 'Jun';
        break;
      case 7:
        this.month = 'Jul';
        break;
      case 8:
        this.month = lang == "en" ? 'Aug' : 'Ago';
        break;
      case 9:
        this.month = 'Set';
        break;
      case 10:
        this.month = 'Oct';
        break;
      case 11:
        this.month = 'Nov';
        break;
      case 12:
        this.month = 'Dec';
        break;
      default:
        this.month = '';
    }
    this.value = value;
  }

  String month;
  int monthNumber;
  double value;
}

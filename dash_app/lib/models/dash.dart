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

  static int fromMonthToNumber(String month) {
    int monthNumber;
    switch (month) {
      case 'Jan':
        monthNumber = 1;
        break;
      case 'Feb':
        monthNumber = 2;
        break;
      case 'Mar':
        monthNumber = 3;
        break;
      case 'Apr':
        monthNumber = 4;
        break;
      case 'May':
        monthNumber = 5;
        break;
      case 'Mai':
        monthNumber = 5;
        break;
      case 'Jun':
        monthNumber = 6;
        break;
      case 'Jul':
        monthNumber = 7;
        break;
      case 'Aug':
        monthNumber = 8;
        break;
      case 'Ago':
        monthNumber = 8;
        break;
      case 'Set':
        monthNumber = 9;
        break;
      case 'Oct':
        monthNumber = 10;
        break;
      case 'Nov':
        monthNumber = 11;
        break;
      case 'Dec':
        monthNumber = 12;
        break;
      default:
        monthNumber = 0;
    }
    return monthNumber;
  }

  String month;
  int monthNumber;
  double value;
}

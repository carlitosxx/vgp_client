
String getDayByNumber(int numberDay){
  switch (numberDay) {
    case 1:
      return 'Lun';
    case 2:
      return 'Mar';
    case 3:
      return 'Mie';
    case 4:
      return 'Jue';
    case 5:
      return 'Vier';
    case 6:
      return 'Sab';
    case 7:
      return 'Dom';
    default:
      return 'Error';
  }  
}
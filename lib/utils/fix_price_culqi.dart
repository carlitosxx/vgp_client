String fixPrice(String price) {
  final priceDecimals = price.split('.')[1];
  if (priceDecimals.length == 2) {
    return price.replaceAll(".", '');
  }
  if (priceDecimals.length == 1) {
    return '${price.replaceAll(".", '')}0';
  }
  return '${price}00';
}

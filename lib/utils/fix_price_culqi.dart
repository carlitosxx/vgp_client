// export const fixPrice=(price:number)=>{
//     const priceString:string=price.toString();
//     const priceDecimals =priceString.split('.')[1]
//     if(priceDecimals.length==2){
//         return priceString.replace(".",'')
//     }
//     if(priceDecimals.length==1){
//         return priceString.replace(".",'')+'0'
//     }
//     return priceString+'00'
// }

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

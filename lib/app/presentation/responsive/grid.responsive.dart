import 'package:vgp_cliente/app/core/constants/breakpoints.dart';

int gridCrossAxisCount(double maxWidh) {
  if (maxWidh <= kTabletSmallMaxWidth) {
    return 1;
  }
  if (maxWidh <= kTabletMediumMaxWidth) {
    return 2;
  }
  if (maxWidh <= kTabletLargeMaxWidth) {
    return 3;
  }
  if (maxWidh <= kDesktopMediumMaxWidth) {
    return 4;
  }
  if (maxWidh <= kDesktopLargeMaxWidth) {
    return 5;
  }
  if (maxWidh <= kDesktopXLargeMaxWidth) {
    return 6;
  }
  return 7;
}

double gridAspectRatio(double maxWidh) {
  if (maxWidh <= kTabletSmallMaxWidth) {
    return 0.70;
  }
  if (maxWidh <= kTabletMediumMaxWidth) {
    return 0.65;
  }
  if (maxWidh <= kTabletLargeMaxWidth) {
    return 0.60;
  }
  if (maxWidh <= kDesktopMediumMaxWidth) {
    return 0.55;
  }
  if (maxWidh <= kDesktopLargeMaxWidth) {
    return 0.63;
  }
  if (maxWidh <= kDesktopXLargeMaxWidth) {
    return 0.6;
  }
  return 0.62;
}

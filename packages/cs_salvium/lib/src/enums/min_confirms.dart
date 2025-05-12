enum MinConfirms {
  monero(10),
  wownero(15);

  final int value;
  const MinConfirms(this.value);
}

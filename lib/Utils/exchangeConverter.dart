class ExchangeConverter {
  String getExchangeSegmentName(int exchangeSegment) {
    switch (exchangeSegment) {
      case 1:
        return 'NSECM';
      case 2:
        return 'NSEFO';
      case 3:
        return 'NSECD';
      case 11:
        return 'BSECM';
      case 12:
        return 'BSEFO';
      case 13:
        return 'BSECD';
      default:
        return 'Unknown';
    }
  }
  
}
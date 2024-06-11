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

  int getExchangeSegmentNumber(String exchangeSegment) {
    switch (exchangeSegment) {
      case 'NSECM':
        return 1;
      case 'NSEFO':
        return 2;
      case 'NSECD':
        return 3;
      case 'BSECM':
        return 11;
      case 'BSEFO':
        return 12;
      case 'BSECD':
        return 13;
      default:
        return 0; // Return 0 or any other number for 'Unknown'
    }
  }
}
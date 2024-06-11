class UserProfile {
  // Define all fields from the API response here
  String clientId;
  String clientName;
  String emailId;
  String mobileNo;
  String pan;
  String dematAccountNumber;
  bool includeInAutoSquareoff;
  bool includeInAutoSquareoffBlocked;
  bool isProClient;
  bool isInvestorClient;
  String residentialAddress;
  String officeAddress;
  String dateOfBirth;
  List<Map<String, dynamic>> clientBankInfoList;
  Map<String, dynamic> clientExchangeDetailsList;
  bool isPOAEnabled;

  UserProfile({
    required this.clientId,
    required this.clientName,
    required this.emailId,
    required this.mobileNo,
    required this.pan,
    required this.dematAccountNumber,
    required this.includeInAutoSquareoff,
    required this.includeInAutoSquareoffBlocked,
    required this.isProClient,
    required this.isInvestorClient,
    required this.residentialAddress,
    required this.officeAddress,
    required this.dateOfBirth,
    required this.clientBankInfoList,
    required this.clientExchangeDetailsList,
    required this.isPOAEnabled,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      clientId: json['result']['ClientId'].toString() ?? '',
      clientName: json['result']['ClientName'] ?? '',
      emailId: json['result']['EmailId'] ?? '',
      mobileNo: json['result']['MobileNo'] ?? '',
      pan: json['result']['PAN'] ?? '',
      dematAccountNumber: json['result']['DematAccountNumber'] ?? '',
      includeInAutoSquareoff: json['result']['IncludeInAutoSquareoff'] ?? false,
      includeInAutoSquareoffBlocked:
          json['result']['IncludeInAutoSquareoffBlocked'] ?? false,
      isProClient: json['result']['IsProClient'] ?? false,
      isInvestorClient: json['result']['IsInvestorClient'] ?? false,
      residentialAddress: json['result']['ResidentialAddress'] ?? '',
      officeAddress: json['result']['OfficeAddress'] ?? '',
      dateOfBirth: json['result']['DateOfBirth'] ?? '',
      clientBankInfoList: List<Map<String, dynamic>>.from(
          json['result']['ClientBankInfoList'] ?? []),
      clientExchangeDetailsList:
          json['result']['ClientExchangeDetailsList'] ?? {},
      isPOAEnabled: json['result']['IsPOAEnabled'] ?? false,
    );
  }
}
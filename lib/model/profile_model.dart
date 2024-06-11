import 'dart:convert';

class UserProfile {
  String type;
  String code;
  String description;
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
  //List<ClientBankInfo> clientBankInfoList;
  //Map<String, ExchangeDetail> clientExchangeDetailsList;
  bool isPOAEnabled;
  String accountNumber;
  String accountType;
  String bankName;
  String bankBranchName;
  String bankCity;
  String customerId;
  String bankCityPincode;
  String bankIFSCCode;
  String lastUpdatedOn;

  UserProfile({
    required this.type,
    required this.code,
    required this.description,
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
    // required this.clientBankInfoList,
   // required this.clientExchangeDetailsList,
    required this.isPOAEnabled,
    required this.accountNumber,
    required this.accountType,
    required this.bankName,
    required this.bankBranchName,
    required this.bankCity,
    required this.customerId,
    required this.bankCityPincode,
    required this.bankIFSCCode,
    required this.lastUpdatedOn,
  });


  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      type: json['type'],
      code: json['code'],
      description: json['description'],
      clientId: json['result']['ClientId'],
      clientName: json['result']['ClientName'],
      emailId: json['result']['EmailId'],
      mobileNo: json['result']['MobileNo'],
      pan: json['result']['PAN'],
      dematAccountNumber: json['result']['DematAccountNumber'],
      includeInAutoSquareoff: json['result']['IncludeInAutoSquareoff']?? false,
      includeInAutoSquareoffBlocked: json['result']['IncludeInAutoSquareoffBlocked'] ?? false,
      isProClient: json['result']['IsProClient'] ?? false,
      isInvestorClient: json['result']['IsInvestorClient'] ?? false,
      residentialAddress: json['result']['ResidentialAddress']?? "",
      officeAddress: json['result']['OfficeAddress']?? "",
      dateOfBirth: json['result']['DateOfBirth'] ?? "",
      isPOAEnabled: json['IsPOAEnabled'] ?? false,
      // Access bank details only if ClientBankInfoList exists
      accountNumber: json['result']['ClientBankInfoList'] != null ? json['result']['ClientBankInfoList'][0]['AccountNumber'] : '',
      accountType: json['result']['ClientBankInfoList'] != null ? json['result']['ClientBankInfoList'][0]['AccountType'] : '',
      bankName: json['result']['ClientBankInfoList'] != null ? json['result']['ClientBankInfoList'][0]['BankName'] : '',
      bankBranchName: json['result']['ClientBankInfoList'] != null ? json['result']['ClientBankInfoList'][0]['BankBranchName'] ?? '' : '',
      bankCity: json['result']['ClientBankInfoList'] != null ?json['result']['ClientBankInfoList'][0]['BankCity'] ?? '' : '',
      customerId: json['result']['ClientBankInfoList'] != null ? json['result']['ClientBankInfoList'][0]['CustomerId'] ?? '' : '',
      bankCityPincode: json['result']['ClientBankInfoList'] != null ? json['result']['ClientBankInfoList'][0]['BankCityPincode'] ?? '' : '',
      bankIFSCCode: json['result']['ClientBankInfoList'] != null ? json['result']['ClientBankInfoList'][0]['BankIFSCCode'] : '',
      lastUpdatedOn: json['result']['ClientBankInfoList'] != null ? json['result']['ClientBankInfoList'][0]['LastUpdatedOn'].toString() : "",
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'code': code,
      'description': description,
      'result': {
        'ClientId': clientId,
        'ClientName': clientName,
        'EmailId': emailId,
        'MobileNo': mobileNo,
        'PAN': pan,
        'DematAccountNumber': dematAccountNumber,
        'IncludeInAutoSquareoff': includeInAutoSquareoff,
        'IncludeInAutoSquareoffBlocked': includeInAutoSquareoffBlocked,
        'IsProClient': isProClient,
        'IsInvestorClient': isInvestorClient,
        'ResidentialAddress': residentialAddress,
        'OfficeAddress': officeAddress,
        'DateOfBirth': dateOfBirth,
        //'ClientBankInfoList': List<dynamic>.from(clientBankInfoList.map((x) => x.toJson())),
        // 'ClientExchangeDetailsList': Map.from(clientExchangeDetailsList)
        //     .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        'IsPOAEnabled': isPOAEnabled,
        'AccountNumber': accountNumber,
        'AccountType': accountType,
        'BankName': bankName,
        'BankBranchName': bankBranchName,
        'BankCity': bankCity,
        'CustomerId': customerId,
        'BankCityPincode': bankCityPincode,
        'BankIFSCCode': bankIFSCCode,
        'LastUpdatedOn': lastUpdatedOn.toString(),

      },
    };
  }

  static List<UserProfile> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => UserProfile.fromJson(json)).toList();
  }

  static String toJsonList(List<UserProfile> list) {
    return json.encode(List<dynamic>.from(list.map((x) => x.toJson())));
  }
}

// class ClientBankInfo {
//   String clientId;
//   String accountNumber;
//   String accountType;
//   String bankName;
//   String bankBranchName;
//   String bankCity;
//   String customerId;
//   String bankCityPincode;
//   String bankIFSCCode;
//   DateTime lastUpdatedOn;

//   ClientBankInfo({
//     required this.clientId,
//     required this.accountNumber,
//     required this.accountType,
//     required this.bankName,
//     required this.bankBranchName,
//     required this.bankCity,
//     required this.customerId,
//     required this.bankCityPincode,
//     required this.bankIFSCCode,
//     required this.lastUpdatedOn,
//   });

//   factory ClientBankInfo.fromJson(Map<String, dynamic> json) {
//     return ClientBankInfo(
      // clientId: json['ClientBankInfoList']['ClientId'],
      // accountNumber: json['ClientBankInfoList']['AccountNumber'],
      // accountType: json['ClientBankInfoList']['AccountType'],
      // bankName: json['ClientBankInfoList']['BankName'],
      // bankBranchName: json['ClientBankInfoList']['BankBranchName'] ?? '',
      // bankCity: json['ClientBankInfoList']['BankCity'] ?? '',
      // customerId: json['ClientBankInfoList']['CustomerId'] ?? '',
      // bankCityPincode: json['ClientBankInfoList']['BankCityPincode'] ?? '',
      // bankIFSCCode: json['ClientBankInfoList']['BankIFSCCode'],
      // lastUpdatedOn:
      //     DateTime.parse(json['ClientBankInfoList']['LastUpdatedOn']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'ClientId': clientId,
//       'AccountNumber': accountNumber,
//       'AccountType': accountType,
//       'BankName': bankName,
//       'BankBranchName': bankBranchName,
//       'BankCity': bankCity,
//       'CustomerId': customerId,
//       'BankCityPincode': bankCityPincode,
//       'BankIFSCCode': bankIFSCCode,
//       'LastUpdatedOn': lastUpdatedOn.toIso8601String(),
//     };
//   }
// }

class ExchangeDetail {
  String clientId;
  int exchangeSegNumber;
  bool enabled;
  String participantCode;
  DateTime lastUpdatedOn;

  ExchangeDetail({
    required this.clientId,
    required this.exchangeSegNumber,
    required this.enabled,
    required this.participantCode,
    required this.lastUpdatedOn,
  });

  factory ExchangeDetail.fromJson(Map<String, dynamic> json) {
    return ExchangeDetail(
      clientId: json['ClientId'],
      exchangeSegNumber: json['ExchangeSegNumber'],
      enabled: json['Enabled'],
      participantCode: json['ParticipantCode'] ?? '',
      lastUpdatedOn: DateTime.parse(json['LastUpdatedOn']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ClientId': clientId,
      'ExchangeSegNumber': exchangeSegNumber,
      'Enabled': enabled,
      'ParticipantCode': participantCode,
      'LastUpdatedOn': lastUpdatedOn.toIso8601String(),
    };
  }
}

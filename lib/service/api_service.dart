import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:lifelinekerala/model/confgmodel/config_model.dart';
import 'package:lifelinekerala/model/helpProviderListModel/help_list_provider_model.dart';
import 'package:lifelinekerala/model/helpmodel/help_model.dart';
import 'package:lifelinekerala/model/loginmodel/login_model.dart';
import 'package:lifelinekerala/model/transactionmodel/transaction_model.dart';
import 'package:lifelinekerala/model/usermodel/member_details.dart';
import 'package:lifelinekerala/model/usermodel/user_model.dart';
import 'package:lifelinekerala/service/store_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = 'https://lifelinekeralatrust.com/api/v1/';
  final Dio _dio = Dio();

  Future<Config> fetchConfig() async {
    final response =
        await _dio.get('https://lifelinekeralatrust.com/api/v1/config');
    if (response.statusCode == 200) {
      return Config.fromJson(response.data);
    } else {
      throw Exception('Failed to load config');
    }
  }

  //---login---Service---//

  Future<LoginModel?> login(String userName, String password) async {
    final url = "${baseUrl}auth/login";
    log('url${url}');
    try {
      final response = await _dio.post(
        url,
        data: {
          'username': userName,
          'password': password,
        },
      );
      log('ststus response${response.statusCode}');
      // log("data${response.data}");
      if (response.statusCode!.toInt() == 200) {
        // final data = response.data;
        // log(response.data['data']);
        // log("data['data']");
        // log('data status:${data['status']}');
        if (response.data['status'] == true) {
          final loginModel = LoginModel.fromJson(response.data['data']);

          // Save member_id to SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          if (loginModel.id != null) {
            await StoreService.setLoginUserId(loginModel.id!.toString());
            await prefs.setString('member_id', loginModel.id!.toString());
          }

          return loginModel;
        } else {
          log('Login failed with message: ${response.data['message']}');
          return null;
        }
      } else {
        log('Login failed with status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Login failed with error: $e');
      return null;
    }
  }

  Future<void> updateDeviceToken(String username) async {
    final url = "${baseUrl}user/update_device_token";

    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final deviceToken = sharedPreferences.getString('deviceToken') ?? '';

      await _dio.post(
        url,
        data: {
          'username': username,
          'deviceToken': deviceToken,
        },
      );
    } catch (e) {
      log('Failed to update device token: $e');
    }
  }

  Future<void> logout() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    // Clear saved user credentials
    await sharedPreferences.remove('username');
    await sharedPreferences.remove('password');

    // Remove device token
    final url = "${baseUrl}user/remove_device_token";
    final deviceToken = sharedPreferences.getString('deviceToken') ?? '';

    try {
      await _dio.post(
        url,
        data: {
          'deviceToken': deviceToken,
        },
      );
    } catch (e) {
      log('Failed to remove device token: $e');
    }
  }

  //---user---view--//

  Future<UserProfile?> getUserView(int memberId) async {
    try {
      final response = await _dio.post(
        'https://lifelinekeralatrust.com/api/v1/user/profile',
        data: {
          'member_id': memberId.toString(),
        },
      );

      if (response.statusCode == 200 && response.data['status'] == true) {
        final userProfile = UserProfile.fromJson(response.data['data']);
        return userProfile;
      } else {
        log('Failed to load profile. Message: ${response.data['message']}');
        return null;
      }
    } catch (e) {
      log('Error: $e');
      return null;
    }
  }

//---- user==profilr---//
  Future<UserProfile> getUserProfile() async {
    final url = '${baseUrl}user/profile';

    try {
      final memberId = await StoreService.getLoginUserId();
      final response = await _dio.post(
        url,
        data: {'member_id': memberId},
      );

      // log('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final responseBody = response.data;
        if (responseBody != null && responseBody is Map<String, dynamic>) {
          final data = responseBody['data'];
          if (data != null && data is Map<String, dynamic>) {
            return UserProfile.fromJson(data);
          } else {
            log('Invalid data format');
            throw Exception('Invalid data format');
          }
        } else {
          log('Invalid response format');
          throw Exception('Invalid response format');
        }
      } else {
        log('Failed to fetch user profile with status code: ${response.statusCode}');
        throw Exception('Failed to fetch user profile');
      }
    } catch (e) {
      log('Failed to fetch user profile with error: $e');
      throw Exception('Failed to fetch user profile');
    }
  }

  Future<Config> getConfig() async {
    final url = 'https://lifelinekeralatrust.com/api/v1/config';

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        return Config.fromJson(response.data);
      } else {
        throw Exception('Failed to load configuration');
      }
    } catch (e) {
      log('Error fetching config: $e');
      throw e;
    }
  }

  //---dashboard--//

  Future<UserProfile?> getDashboard() async {
    try {
      final response = await _dio
          .get('https://lifelinekeralatrust.com/api/v1/user/dashboard');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.data);
        return UserProfile.fromJson(data['member_details']);
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      throw Exception('Failed to load user profile: $e');
    }
  }

  //--transaction---//
  Future<List<Transaction>> getTransactionList() async {
    const String url =
        'https://lifelinekeralatrust.com/api/v1/user/transactions';

    try {
      final memberId = await StoreService.getLoginUserId();
      final response = await _dio.post(
        url,
        data: {'member_id': memberId},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['list']['data'];
        return data.map((item) => Transaction.fromJson(item)).toList();
      } else {
        log('Error: ${response.statusCode}');
        throw Exception('Failed to load transactions');
      }
    } catch (e) {
      log('Exception: $e');
      throw Exception('Failed to load transactions: $e');
    }
  }
  //---help--list---//

  Future<List<HelpListProviderModel>> getHelpProvidedList() async {
    const String url = 'https://akpa.in/santhwanam/api/v1/user/help_list';

    try {
      final memberId = await StoreService.getLoginUserId();
      final response = await _dio.post(
        url,
        data: {'member_id': memberId},
        options: Options(
          headers: {
            'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
            'Content-Type': 'application/json',
          },
        ),
      );

      // Log the full response
      // log('API Response: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data['list'] != null &&
            response.data['list']['data'] != null) {
          List<dynamic> data = response.data['list']['data'];

          // log('Help List Data: $data');
   
             List<HelpListProviderModel> list = List<HelpListProviderModel>.from(
            data.map((x) => HelpListProviderModel.fromJson(x)));
          // List<HelpModel> helpPlist=  data.map((item) => HelpModel.fromJson(item)).toList();
           log("Help List ===${list.length}");
            
        
         
          return list;
        } else {
          log('No data found in the response');
          return [];
        }
      } else {
        log('Failed to load help list: ${response.statusMessage}');
        throw Exception('Failed to load help list');
      }
    } catch (e) {
      log('Error: $e');
      throw Exception('Failed to load help list: $e');
    }
  }

  Future<List<HelpModel>> getHelpReceivedList() async {
    const String url = 'https://lifelinekeralatrust.com/api/v1/user/view';

    try {
      final memberId = await StoreService.getLoginUserId();
      final response = await _dio.post(
        url,
        data: {'member_id': memberId},
        options: Options(
          headers: {
            'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['help_received'];
        return data.map((item) => HelpModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load help received list');
      }
    } catch (e) {
      log('Error: $e');
      throw Exception('Failed to load help received list: $e');
    }
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    final memberId = await StoreService.getLoginUserId();
    final response = await _dio.get(
      'https://lifelinekeralatrust.com/api/v1/user/view',
      queryParameters: {
        'member_id': memberId,
      },
    );

    if (response.statusCode == 200) {
      final data = response.data;
      print(data);
      return {
        "memberDetails": MemberDetails.fromJson(data['member_details']),
        "familyDetails": (data['family_details'] as List)
            .map((family) => FamilyDetails.fromJson(family))
            .toList(),
        "helpReceived": (data['help_received'] as List)
            .map((help) => HelpReceived.fromJson(help))
            .toList(),
      };
    } else {
      throw Exception('Failed to load user data');
    }
  }

  Future<MemberDetails> fetchMemberDetails() async {
    try {
      final memberId = await StoreService.getLoginUserId();
      final response = await _dio.post(
        'https://lifelinekeralatrust.com/api/v1/user/view',
        options: Options(
          headers: {
            'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'member_id': memberId,
        },
      );
      if (response.statusCode == 200) {
        log('Response data: ${response.data}');
        var data = response.data['member_details'];
        if (data != null) {
          return MemberDetails.fromJson(data);
        } else {
          throw Exception('Member details are missing from the response');
        }
      } else {
        throw Exception('Failed to load member details');
      }
    } catch (e) {
      log('Failed to load member details: $e');
      rethrow;
    }
  }

  Future<List<FamilyDetails>> fetchFamilyDetails() async {
    try {
      final memberId = await StoreService.getLoginUserId();
      final response = await _dio.post(
        'https://lifelinekeralatrust.com/api/v1/user/view',
        options: Options(
          headers: {
            'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'member_id': memberId,
        },
      );
      if (response.statusCode == 200) {
        var familyDetailsData = response.data['family_details'] as List;
        return familyDetailsData
            .map((familyDetail) => FamilyDetails.fromJson(familyDetail))
            .toList();
      } else {
        throw Exception('Failed to load family details');
      }
    } catch (e) {
      log('Failed to load family details: $e');
      rethrow;
    }
  }
}

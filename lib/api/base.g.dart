// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Base _$BaseFromJson(Map<String, dynamic> json) => Base(
      success: json['success'] as bool,
      result: json['result'],
    );

Map<String, dynamic> _$BaseToJson(Base instance) => <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      message: json['message'],
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'message': instance.message,
    };

ErrorBase _$ErrorBaseFromJson(Map<String, dynamic> json) => ErrorBase(
      success: json['success'] as bool,
      result: ErrorResult.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ErrorBaseToJson(ErrorBase instance) => <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

ErrorResult _$ErrorResultFromJson(Map<String, dynamic> json) => ErrorResult(
      error: json['error'] as String,
    );

Map<String, dynamic> _$ErrorResultToJson(ErrorResult instance) =>
    <String, dynamic>{
      'error': instance.error,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _RestClient implements RestClient {
  _RestClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://api.1fx.app:3007/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Login> loginUser(obj) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Login>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/login',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Login.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Login> googleLoginUser(obj) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Login>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/google_login',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Login.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SignUp> googleAuthUser(obj) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<SignUp>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/google_auth',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SignUp.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SignUp> getUserByReferral(uniqueId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<SignUp>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/get_user_by_referral?uniqueId=${uniqueId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SignUp.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SignUp> updateUserDetails(obj) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<SignUp>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/update_details',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SignUp.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SignUp> sendEmailVerifyOtp(obj) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<SignUp>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/send_email_verify_otp',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SignUp.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserAdditionalDetailsApiStruct> getUserDetails() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserAdditionalDetailsApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/user_additional_info',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserAdditionalDetailsApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SignUp> submitUserDetails(obj) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<SignUp>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/submit_user_Details',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SignUp.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SignUp> signUpUser(obj) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<SignUp>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/sign_up',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SignUp.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserDetailsApiStruct> getIUser() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserDetailsApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/get_details',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserDetailsApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<VerifyAuthApiStruct> verifyOtp(obj) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VerifyAuthApiStruct>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/verify_auth',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = VerifyAuthApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EnableAuthApiStruct> enableAuth(type) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<EnableAuthApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/enable_auth?type=${type}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EnableAuthApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<VerifyTOtpApiStruct> updateUserSettings(obj) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VerifyTOtpApiStruct>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/update_Settings',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = VerifyTOtpApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ActivityLogsApiStruct> getUserLogs() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ActivityLogsApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/get_logs',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ActivityLogsApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResetPassApiStruct> resetUserPass(email) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ResetPassApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/reset_email_request?email=${email}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResetPassApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RefreshMobilTokenApiStruct> refreshUserMobilToken(obj) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RefreshMobilTokenApiStruct>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/update_user_mobile_token',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RefreshMobilTokenApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResendVerificationEmailApiStruct> resendVerificationLink(obj) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResendVerificationEmailApiStruct>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/resend_verification_link',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResendVerificationEmailApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResetMobileApiStruct> updateUserMobile(obj) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResetMobileApiStruct>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/update_phone',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResetMobileApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DeleteAccountApiStruct> deleteAccount(obj) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DeleteAccountApiStruct>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/delete_account',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DeleteAccountApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ReferralApiStruct> getReferrals() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ReferralApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/referrals',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ReferralApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LogOutApiStruct> logOutAllDevices() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<LogOutApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/logout_all_devices',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LogOutApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SendActiveOtpApiStruct> sendActiveOtp() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SendActiveOtpApiStruct>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/send_email_otp',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SendActiveOtpApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<VerifyActiveOtpApiStruct> verifyActiveOtp(obj) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VerifyActiveOtpApiStruct>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/update_user_status',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = VerifyActiveOtpApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ChangePasswordApiStruct> changePassword(obj) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ChangePasswordApiStruct>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/change_password',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ChangePasswordApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AllCoins> getAllCoins() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<AllCoins>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'binance/get_all_coins',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AllCoins.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OrderBookStruct> getOrderBook(
    symbol,
    fiat,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<OrderBookStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'order/get_orders?symbol=${symbol}&fiat=${fiat}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OrderBookStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TradeHistoryApiStruct> getTradeHistory(
    symbol,
    fiat,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TradeHistoryApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'order_fills/get_trade_history?symbol=${symbol}&fiat=${fiat}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TradeHistoryApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetMasterCoinListApiStruct> getMasterCoinList({symbol}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetMasterCoinListApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'master_coin/get_all_coins?symbol=${symbol}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetMasterCoinListApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserWalletStruct> getUserWallet() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<UserWalletStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'wallet/get_user_wallets',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserWalletStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PlaceOrderApiStruct> createOrder(obj) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PlaceOrderApiStruct>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'order/create_order',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PlaceOrderApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PlaceOrderEntriesApiStruct> getOrderPlacedCancelledEntries(
    page,
    searchTerm,
    type,
    status,
    searchFilter,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PlaceOrderEntriesApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'order/get_all_orders?page=${page}&searchTerm=${searchTerm}&type=${type}&status=${status}&searchFilter=${searchFilter}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PlaceOrderEntriesApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PlaceOrderEntriesApiStruct> getCancelledEntries(
    page,
    searchTerm,
    type,
    status,
    searchFilter,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PlaceOrderEntriesApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'order/get_all_orders?page=${page}&searchTerm=${searchTerm}&type=${type}&status=${status}&searchFilter=${searchFilter}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PlaceOrderEntriesApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CancelOrderApiStruct> cancelOrder(obj) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CancelOrderApiStruct>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'order/cancel_order',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CancelOrderApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CompletedOrderEntriesApiStruct> getCompletedOrderEntries(
    page,
    searchTerm,
    type,
    symbol,
    searchFilter,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CompletedOrderEntriesApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'order_fills/get_user_order_report?page=${page}&searchTerm=${searchTerm}&type=${type}&symbol=${symbol}&searchFilter=${searchFilter}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CompletedOrderEntriesApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Last24HourVolumeApiStruct> getLast24HourVolume(symbol) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Last24HourVolumeApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'order_fills/24_hour_volume?symbol=${symbol}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Last24HourVolumeApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AllRequestApiStruct> getAllDeposits(
    page,
    status,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AllRequestApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'request/get_all_requests?page=${page}&status=${status}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AllRequestApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CreateRequestApiStruct> createInrRequest(obj) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CreateRequestApiStruct>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'request/create_request',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CreateRequestApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TransactionLogHistoryApiStruct> getCoinTransactionHistory(
    page,
    symbol,
    requestType,
    status,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TransactionLogHistoryApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'logs/get_history?page=${page}&symbol=${symbol}&requestType=${requestType}&status=${status}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TransactionLogHistoryApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LedgerEntriesApiStruct> getLedgerEntries(
    page,
    symbol,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LedgerEntriesApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'ledger/get_all_ledger_entries?page=${page}&symbol=${symbol}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LedgerEntriesApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FileUploadApiStruct> uploadDoc(
    image,
    data,
    type,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.files.add(MapEntry(
      'image',
      MultipartFile.fromFileSync(
        image.path,
        filename: image.path.split(Platform.pathSeparator).last,
      ),
    ));
    _data.fields.add(MapEntry(
      'data',
      data,
    ));
    _data.fields.add(MapEntry(
      'type',
      type,
    ));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FileUploadApiStruct>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'upload/doc',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FileUploadApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<KycIdApiStruct> getKycId() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<KycIdApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'kyc/get_kyc_Id',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = KycIdApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SubmitKycApiStruct> createKycEntry(obj) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SubmitKycApiStruct>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'kyc/create_entry',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SubmitKycApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserBankApiStruct> getUserBank() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<UserBankApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/get_banks',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserBankApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BankListApiStruct> getAllBanks() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<BankListApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'banks_list/get_bank_list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BankListApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CreateUserBankApiStruct> createUserBank(obj) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CreateUserBankApiStruct>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/create_bank',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CreateUserBankApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<VerifyUtrApiStruct> verifyUtr(obj) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<VerifyUtrApiStruct>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'users/verify_utr',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = VerifyUtrApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AdminBanksApiStruct> getAdminBanks() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AdminBanksApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'banks/get_banks',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AdminBanksApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AllMasterAuthApiStruct> getAllMasterAuth() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AllMasterAuthApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'master_auth/get_all_auth',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AllMasterAuthApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<WithdrawalInrApiStruct> withdrawalInr(obj) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<WithdrawalInrApiStruct>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'funds/withdrawal_Inr',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = WithdrawalInrApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GenerateUserAddressApiStruct> generateUserAddress(
    network,
    symbol,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GenerateUserAddressApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'funds/deposit/${network}?symbol=${symbol}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GenerateUserAddressApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CryptoDepositApiStruct> depositCrypto(
    network,
    obj,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CryptoDepositApiStruct>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'funds/transfer_tokens_new/${network}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CryptoDepositApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CryptoWithdrawalApiStruct> withdrawalCrypto(
    network,
    obj,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CryptoWithdrawalApiStruct>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'funds/withdrawal_tokens/${network}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CryptoWithdrawalApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AllCoinsFundApiStruct> allCoinsFunds(page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AllCoinsFundApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'funds/get_all_coins?page=${page}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AllCoinsFundApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EstimateDeductionApiStruct> getEstimatedFunds(
    amount,
    type,
    symbol,
    network,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<EstimateDeductionApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'funds/get_estimate_deduction?amount=${amount}&type=${type}&symbol=${symbol}&network=${network}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EstimateDeductionApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CreateTicketApiStruct> createTicket(obj) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CreateTicketApiStruct>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'help_desk/create_ticket',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CreateTicketApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CreateTicketWithDocApiStruct> createTicketWithDoc(
    attachments,
    phone,
    description,
    subject,
    status,
    priority,
    source,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.files.addAll(attachments.map((i) => MapEntry(
        'attachments',
        MultipartFile.fromFileSync(
          i.path,
          filename: i.path.split(Platform.pathSeparator).last,
        ))));
    _data.fields.add(MapEntry(
      'phone',
      phone,
    ));
    _data.fields.add(MapEntry(
      'description',
      description,
    ));
    _data.fields.add(MapEntry(
      'subject',
      subject,
    ));
    _data.fields.add(MapEntry(
      'status',
      status.toString(),
    ));
    _data.fields.add(MapEntry(
      'priority',
      priority.toString(),
    ));
    _data.fields.add(MapEntry(
      'source',
      source.toString(),
    ));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CreateTicketWithDocApiStruct>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'help_desk/create_ticket_with_doc',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CreateTicketWithDocApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AllTicketsApiStruct> getAllTickets() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AllTicketsApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'help_desk/get_all_tickets',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AllTicketsApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AllConversationsApiStruct> getAllConversations(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AllConversationsApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'help_desk/all_conversations_on_ticket?id=${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AllConversationsApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ReplyTicketApiStruct> replyTicket(obj) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ReplyTicketApiStruct>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'help_desk/reply_ticket',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ReplyTicketApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ReplyTicketWithDocApiStruct> replyTicketWithDoc(
    attachments,
    reply,
    id,
    user_id,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.files.addAll(attachments.map((i) => MapEntry(
        'attachments',
        MultipartFile.fromFileSync(
          i.path,
          filename: i.path.split(Platform.pathSeparator).last,
        ))));
    _data.fields.add(MapEntry(
      'reply',
      reply,
    ));
    _data.fields.add(MapEntry(
      'id',
      id.toString(),
    ));
    _data.fields.add(MapEntry(
      'user_id',
      user_id.toString(),
    ));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ReplyTicketWithDocApiStruct>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'help_desk/reply_ticket_with_doc',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ReplyTicketWithDocApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ReplyTicketWithDocApiStruct> replyTicketWithDoc1(
    attachments,
    id,
    user_id,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.files.addAll(attachments.map((i) => MapEntry(
        'attachments',
        MultipartFile.fromFileSync(
          i.path,
          filename: i.path.split(Platform.pathSeparator).last,
        ))));
    _data.fields.add(MapEntry(
      'id',
      id.toString(),
    ));
    _data.fields.add(MapEntry(
      'user_id',
      user_id.toString(),
    ));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ReplyTicketWithDocApiStruct>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'help_desk/reply_ticket_with_doc',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ReplyTicketWithDocApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetAllNotificationsApiStruct> getAllUserNotifications() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetAllNotificationsApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'notification/get_all_notifications',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetAllNotificationsApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdateNotificationsApiStruct> updateNotification(obj) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpdateNotificationsApiStruct>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'notification/update_notification',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpdateNotificationsApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetBannerApiStruct> getAllBanner(limit) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<GetBannerApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'banner/get_banner?limit=${limit}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetBannerApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetAnnouncementApiStruct> getAnnouncements([limit = "3"]) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetAnnouncementApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'announcements/read_announce_web?limit=${limit}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetAnnouncementApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ValidateBEP20AddressApiStruct> validateBEP20AddressApiStruct(
      address) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ValidateBEP20AddressApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'transaction/validate_BEP20_address?address=${address}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ValidateBEP20AddressApiStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ValidateAddressApiStruct> validateTronAddress(address) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ValidateAddressApiStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'tron/validate_address?address=${address}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ValidateAddressApiStruct.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  @override
  Future<UniqueCodeStruct> getUniqueCode(String paymentMode) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<UniqueCodeStruct>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'request/getUniqueCode?paymentMode=${paymentMode}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UniqueCodeStruct.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GenerateUnique> generateUnique(Object obj) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = obj;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<GenerateUnique>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'request/generateCDMUniqueCode',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GenerateUnique.fromJson(_result.data!);
    return value;
  }
}

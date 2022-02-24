import 'package:flutter/widgets.dart';

/// Color
Color themeColor = Color(0xFF74c7c8);
Color themeDarkColor = Color(0xFF54A7A8);
Color validColor = Color(0xFF447939);
Color incompleteValidColor = Color(0xFFF2CC11);
// Old Color(0xFFA2B511);
Color invalidColor = Color(0xFFD33F3F);
Color airportNoticeColor = Color(0xFFF2CC11);
// Old Color(0xFFE49FBA);
Color limitedValidColor = Color(0xFFF2CC11);
// Old Color(0xFFEF9C2B);

/// Key
final hashKey = 'eW8=';
final certString = '''
[{"certificateType": "DSC", "country": "TW", "kid": "tAI4+PVPEOQ=", "rawData": "MIICzDCCAnOgAwIBAgIIcKCWiDg+fkkwCgYIKoZIzj0EAwIwgYgxGzAZBgNVBAMMEkNvdW50cnkgU2lnbmluZyBDQTEnMCUGA1UECwweTWluaXN0cnkgb2YgSGVhbHRoIGFuZCBXZWxmYXJlMRcwFQYDVQQLDA5FeGVjdXRpdmUgWXVhbjEaMBgGA1UECgwRVGFpd2FuIEdvdmVybm1lbnQxCzAJBgNVBAYTAlRXMB4XDTIxMDcwMzAwMjA1MFoXDTIzMDcwMzAwMjA1MFowZzFlMGMGA1UEAwxcRG9jdW1lbnQgU2lnbmVyLE9VPU1pbmlzdHJ5IG9mIEhlYWx0aCBhbmQgV2VsZmFyZSxPVT1FeGVjdXRpdmUgWXVhbixPPVRhaXdhbiBHb3Zlcm5tZW50LEM9VFcwWTATBgcqhkjOPQIBBggqhkjOPQMBBwNCAASvon0NYuHZGhu8f8m2SzpMQ+L+6aSjjnjhGqRgcxzOFMKYEQ4s+BWiqo+n8huqqR53fzNiMDYT3QHh9VaglDmGo4HmMIHjMAwGA1UdEwEB/wQCMAAwHwYDVR0jBBgwFoAU9yIl1sNcA9UxXQ3S+9JbOwrxjFowMwYDVR0lBCwwKgYMKwYBBAEAjjePZQEDBgwrBgEEAQCON49lAQEGDCsGAQQBAI43j2UBAjBOBgNVHR8ERzBFMEOgQaA/hj1odHRwOi8vaGNhY3NjYS5uYXQuZ292LnR3L3JlcG9zaXRvcnkvSENBQ1NDQS9DUkwvY29tcGxldGUuY3JsMB0GA1UdDgQWBBSGbQGv+gr+0Zz3ZfNtIw9O6p1U/zAOBgNVHQ8BAf8EBAMCB4AwCgYIKoZIzj0EAwIDRwAwRAIgFBoK0/yZGRGdp44hZJmCJPBZrkC4kDRL94fMXLsFhV4CIA9+ctvaPi81lK/rNS0OzrJfkUPiE+m+iCmop+axSYxI"}]
''';
final dccPrefix = ['HC1:'];
final shcPrefix = ['shc:'];

/// Message
/// TODO: i18n with get_cli json
final appName = '數位新冠病毒健康證明查驗';
final loginText = '登入';
final loginSuccessText = loginText + '成功';
final loginFailText = loginText + '失敗';
final confirmText = '確認';
final retryText = '重試';
final closeText = '關閉';
final tokenInputHint = '請輸入驗證碼';
final tokenErrorHint = '驗證碼錯誤';
final tokenExpireHint = '驗證碼已過期';
final internetRequiredHint = '請確認網路狀況';
final vaccinationText = '疫苗證明';
final recoveryText = '康復證明';
final testResultText = '檢驗證明';
final aboutText = '關於';
final alertText = '注意';
final licenseText =
    '本應用由衛生福利部提供，僅供具授權之單位驗證歐盟數位新冠證明(EU-DCC)，請妥善保管登入驗證碼。\n如有使用操作問題，請向數位新冠病毒健康證明簽發平台尋求客服協助。\n\nCopyright © 2022 數位新冠病毒健康證明簽發平台';
const noInternetConnection = '無網路連線';
const noServerConnection = '連線失敗，請稍後再試';
const qrcodeDecodeFailed = '數位證明 QRCode 解析錯誤';
const qrcodeDecodeFailedDetail =
    '請確認資料是否為 EU Digital Covid Certificate Schema 格式';
const dccTrustedListNull = '尚未取得歐盟受信任憑證清單';

/// Path
final rootPath = '/';
final verifyPath = '/Verify';

/// Hive
final certSettings = 'CERTIFICATE_SETTINGS';

/// Duration
final vaccineEffectiveDurationAfter = Duration(days: 14);
final vaccineEffectiveDurationBefore = Duration(days: 365);

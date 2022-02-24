enum CertType {
  vaccine,
  recovery,
  test,
  unknown,
}

extension CertTypeExtension on CertType {
  static const certTypeResult = {
    CertType.vaccine: 'vaccine',
    CertType.recovery: 'recovery',
    CertType.test: 'test',
    CertType.unknown: 'unknown',
  };

  String? get result => certTypeResult[this];
}

enum CertValidity {
  valid,
  incompletevalid,
  invalid,
  limitvalid,
  notice,
  expire,
  notInWhitelist,
}

extension CertValidityExtension on CertValidity {
  static const certvalResult = {
    CertValidity.valid: '通過',
    CertValidity.incompletevalid: '接種不完整',
    CertValidity.invalid: '不通過',
    CertValidity.limitvalid: '限制性通過',
    CertValidity.notice: '待確認',
    CertValidity.expire: '非有效期內',
    CertValidity.notInWhitelist: '非核定清單',
  };

  String? get result => certvalResult[this];
}

enum TargetDiseaseEnum {
  covid19,
  unknown,
}

class TargetDisease {
  static const Map<String, String> map = {
    "840539006": 'COVID-19',
    "unknown": 'unknown',
  };
}

extension TargetDiseaseExtension on TargetDisease {
  static const targetDiseases = {
    TargetDiseaseEnum.covid19: 'COVID-19',
    TargetDiseaseEnum.unknown: 'unknown',
  };

  String? get targetDisease => targetDiseases[this];
}

class TestResult {
  static const Map<String, String> map = {
    "260415000": 'Not Detected',
    "260373001": 'Detected',
  };

  static const Map<String, TestResultEnum> mapEnum = {
    "260415000": TestResultEnum.not_detected,
    "260373001": TestResultEnum.detected,
  };
}

enum TestResultEnum {
  detected,
  not_detected,
}

extension TestResultExtension on TestResult {
  static const testResults = {
    TestResultEnum.detected: 'Detected',
    TestResultEnum.not_detected: 'Not Detected',
  };
}

class CountryMap {
  static const Map<String, String> map = {
    "AF": "Afghanistan",
    "AX": "Åland Islands",
    "AL": "Albania",
    "DZ": "Algeria",
    "AS": "American Samoa",
    "AD": "Andorra",
    "AO": "Angola",
    "AI": "Anguilla",
    "AQ": "Antarctica",
    "AG": "Antigua and Barbuda",
    "AR": "Argentina",
    "AM": "Armenia",
    "AW": "Aruba",
    "AU": "Australia",
    "AT": "Austria",
    "AZ": "Azerbaijan",
    "BS": "Bahamas",
    "BH": "Bahrain",
    "BD": "Bangladesh",
    "BB": "Barbados",
    "BY": "Belarus",
    "BE": "Belgium",
    "BZ": "Belize",
    "BJ": "Benin",
    "BM": "Bermuda",
    "BT": "Bhutan",
    "BO": "Bolivia, Plurinational State of",
    "BQ": "Bonaire, Sint Eustatius and Saba",
    "BA": "Bosnia and Herzegovina",
    "BW": "Botswana",
    "BV": "Bouvet Island",
    "BR": "Brazil",
    "IO": "British Indian Ocean Territory",
    "BN": "Brunei Darussalam",
    "BG": "Bulgaria",
    "BF": "Burkina Faso",
    "BI": "Burundi",
    "KH": "Cambodia",
    "CM": "Cameroon",
    "CA": "Canada",
    "CV": "Cabo Verde",
    "KY": "Cayman Islands",
    "CF": "Central African Republic",
    "TD": "Chad",
    "CL": "Chile",
    "CN": "China",
    "CX": "Christmas Island",
    "CC": "Cocos (Keeling) Islands",
    "CO": "Colombia",
    "KM": "Comoros",
    "CG": "Congo",
    "CD": "Congo, the Democratic Republic of the",
    "CK": "Cook Islands",
    "CR": "Costa Rica",
    "CI": "Côte d'Ivoire",
    "HR": "Croatia",
    "CU": "Cuba",
    "CW": "Curaçao",
    "CY": "Cyprus",
    "CZ": "Czech Republic",
    "DK": "Denmark",
    "DJ": "Djibouti",
    "DM": "Dominica",
    "DO": "Dominican Republic",
    "EC": "Ecuador",
    "EG": "Egypt",
    "SV": "El Salvador",
    "GQ": "Equatorial Guinea",
    "ER": "Eritrea",
    "EE": "Estonia",
    "ET": "Ethiopia",
    "FK": "Falkland Islands (Malvinas)",
    "FO": "Faroe Islands",
    "FJ": "Fiji",
    "FI": "Finland",
    "FR": "France",
    "GF": "French Guiana",
    "PF": "French Polynesia",
    "TF": "French Southern Territories",
    "GA": "Gabon",
    "GM": "Gambia",
    "GE": "Georgia",
    "DE": "Germany",
    "GH": "Ghana",
    "GI": "Gibraltar",
    "GR": "Greece",
    "EL": "Greece",
    "GL": "Greenland",
    "GD": "Grenada",
    "GP": "Guadeloupe",
    "GU": "Guam",
    "GT": "Guatemala",
    "GG": "Guernsey",
    "GN": "Guinea",
    "GW": "Guinea-Bissau",
    "GY": "Guyana",
    "HT": "Haiti",
    "HM": "Heard Island and McDonald Islands",
    "VA": "Holy See (Vatican City State)",
    "HN": "Honduras",
    "HK": "Hong Kong",
    "HU": "Hungary",
    "IS": "Iceland",
    "IN": "India",
    "ID": "Indonesia",
    "IR": "Iran, Islamic Republic of",
    "IQ": "Iraq",
    "IE": "Ireland",
    "IM": "Isle of Man",
    "IL": "Israel",
    "IT": "Italy",
    "JM": "Jamaica",
    "JP": "Japan",
    "JE": "Jersey",
    "JO": "Jordan",
    "KZ": "Kazakhstan",
    "KE": "Kenya",
    "KI": "Kiribati",
    "KP": "Korea, Democratic People's Republic of",
    "KR": "Korea, Republic of",
    "KW": "Kuwait",
    "KG": "Kyrgyzstan",
    "LA": "Lao People's Democratic Republic",
    "LV": "Latvia",
    "LB": "Lebanon",
    "LS": "Lesotho",
    "LR": "Liberia",
    "LY": "Libya",
    "LI": "Liechtenstein",
    "LT": "Lithuania",
    "LU": "Luxembourg",
    "MO": "Macao",
    "MK": "Macedonia, the former Yugoslav Republic of",
    "MG": "Madagascar",
    "MW": "Malawi",
    "MY": "Malaysia",
    "MV": "Maldives",
    "ML": "Mali",
    "MT": "Malta",
    "MH": "Marshall Islands",
    "MQ": "Martinique",
    "MR": "Mauritania",
    "MU": "Mauritius",
    "YT": "Mayotte",
    "MX": "Mexico",
    "FM": "Micronesia, Federated States of",
    "MD": "Moldova, Republic of",
    "MC": "Monaco",
    "MN": "Mongolia",
    "ME": "Montenegro",
    "MS": "Montserrat",
    "MA": "Morocco",
    "MZ": "Mozambique",
    "MM": "Myanmar",
    "NA": "Namibia",
    "NR": "Nauru",
    "NP": "Nepal",
    "NL": "Netherlands",
    "NC": "New Caledonia",
    "NZ": "New Zealand",
    "NI": "Nicaragua",
    "NE": "Niger",
    "NG": "Nigeria",
    "NU": "Niue",
    "NF": "Norfolk Island",
    "MP": "Northern Mariana Islands",
    "NO": "Norway",
    "OM": "Oman",
    "PK": "Pakistan",
    "PW": "Palau",
    "PS": "Palestine, State of",
    "PA": "Panama",
    "PG": "Papua New Guinea",
    "PY": "Paraguay",
    "PE": "Peru",
    "PH": "Philippines",
    "PN": "Pitcairn",
    "PL": "Poland",
    "PT": "Portugal",
    "PR": "Puerto Rico",
    "QA": "Qatar",
    "RE": "Réunion",
    "RO": "Romania",
    "RU": "Russian Federation",
    "RW": "Rwanda",
    "BL": "Saint Barthélemy",
    "SH": "Saint Helena, Ascension and Tristan da Cunha",
    "KN": "Saint Kitts and Nevis",
    "LC": "Saint Lucia",
    "MF": "Saint Martin (French part)",
    "PM": "Saint Pierre and Miquelon",
    "VC": "Saint Vincent and the Grenadines",
    "WS": "Samoa",
    "SM": "San Marino",
    "ST": "Sao Tome and Principe",
    "SA": "Saudi Arabia",
    "SN": "Senegal",
    "RS": "Serbia",
    "SC": "Seychelles",
    "SL": "Sierra Leone",
    "SG": "Singapore",
    "SX": "Sint Maarten (Dutch part)",
    "SK": "Slovakia",
    "SI": "Slovenia",
    "SB": "Solomon Islands",
    "SO": "Somalia",
    "ZA": "South Africa",
    "GS": "South Georgia and the South Sandwich Islands",
    "SS": "South Sudan",
    "ES": "Spain",
    "LK": "Sri Lanka",
    "SD": "Sudan",
    "SR": "Suriname",
    "SJ": "Svalbard and Jan Mayen",
    "SZ": "Swaziland",
    "SE": "Sweden",
    "CH": "Switzerland",
    "SY": "Syrian Arab Republic",
    "TW": "Taiwan 中華民國",
    "TJ": "Tajikistan",
    "TZ": "Tanzania, United Republic of",
    "TH": "Thailand",
    "TL": "Timor-Leste",
    "TG": "Togo",
    "TK": "Tokelau",
    "TO": "Tonga",
    "TT": "Trinidad and Tobago",
    "TN": "Tunisia",
    "TR": "Turkey",
    "TM": "Turkmenistan",
    "TC": "Turks and Caicos Islands",
    "TV": "Tuvalu",
    "UG": "Uganda",
    "UA": "Ukraine",
    "AE": "United Arab Emirates",
    "GB": "United Kingdom",
    "US": "United States",
    "UM": "United States Minor Outlying Islands",
    "UY": "Uruguay",
    "UZ": "Uzbekistan",
    "VU": "Vanuatu",
    "VE": "Venezuela, Bolivarian Republic of",
    "VN": "Vietnam",
    "VG": "Virgin Islands, British",
    "VI": "Virgin Islands, U.S.",
    "WF": "Wallis and Futuna",
    "EH": "Western Sahara",
    "YE": "Yemen",
    "ZM": "Zambia",
    "ZW": "Zimbabwe",
  };
}

enum VaccineProphylaxisEnum {
  antigenVaccine,
  mRNAVaccine,
  covid19Vaccine,
}

class VaccineProphylaxis {
  static const Map<String, String> map = {
    "1119305005": 'SARS-CoV2 antigen vaccine',
    "1119349007": 'SARS-CoV2 mRNA vaccine',
    "J07BX03": 'covid-19 vaccines',
    "": 'unknown',
  };
}

enum VaccineMedicinalProductEnum {
  comirnaty,
  spikevax,
  vaxzevria,
  janssen,
  cvncov,
  nvx_cov2373,
  sputnik_v,
  convidecia,
  epiVacCorona,
  bbibp_corv,
  inactivated_sars_cov2,
  coronavac,
  covaxin,
  covishield,
}

class VaccineMedicinalProduct {
  ///json_vaccine_mp
  static const Map<String, String> map = {
    "MVC-COVID-19-Vaccine": '高端',
    "MVC-COV1901": '高端',
    "EU/1/20/1528": 'Comirnaty',
    "EU/1/20/1507": 'Spikevax(previously COVID-19 Vaccine Moderna)',
    "EU/1/21/1529": 'Vaxzevria',
    "EU/1/20/1525": 'COVID-19 Vaccine Janssen',
    "CVnCoV": 'CVnCoV',
    "NVX-CoV2373": 'NVX-CoV2373',
    "Sputnik-V": 'Sputnik-V',
    "Convidecia": 'Convidecia',
    "EpiVacCorona": 'EpiVacCorona',
    "BBIBP-CorV": 'BBIBP-CorV',
    "InactivatedSARS-CoV-2-Vero-Cell": 'Inactivated SARS-CoV2 (Vero Cell)',
    "CoronaVac": 'CoronaVac',
    "Covaxin": 'Covaxin(also known as BBV152 A, B, C)',
    "Covishield": 'Covishield(ChAdOx1_nCoV-19)',
    "": 'unknown',
  };

  static const List<String> allowList = [
    "EU/1/20/1528",
    "EU/1/20/1507",
    "EU/1/21/1529",
    "EU/1/20/1525",
    "MVC-COVID-19-Vaccine", // 舊高端代碼
    "MVC-COV1901", // 新高端代碼
    "NVX-CoV2373",
    "BBIBP-CorV",
    "CoronaVac",
    "Covaxin",
    "Covishield",
  ];
}

enum VaccineManufacturerEnum {
  astraZeneca_AB,
  biontech_Manufacturing_GmbH,
  janssen_Cilag_International,
  moderna_Biotech_Spain_SL,
  curevac_AG,
  canSino_Biologics,
  chinaSinopharmInternationalCorp_Beijinglocation,
  sinopharmWeiqidaEuropePharmaceuticals_Praguelocation,
  sinopharmZhijun_Shenzhen_PharmaceuticalCo_Ltd_Shenzhenlocation,
  novavax_CZ_AS,
  gamaleyaResearchInstitute,
  vectorInstitute,
  sinovacBiotech,
  bharatBiotech,
}

class VaccineManufacturer {
  static const Map<String, String> map = {
    "Medigen-Vaccine-Biologics-Corp": 'Medigen Vaccine Biologics Corporation',
    "ORG-100001699": 'AstraZeneca AB',
    "ORG-100030215": 'Biontech Manufacturing GmbH',
    "ORG-100001417": 'Janssen Cilag International',
    "ORG-100031184": 'Moderna Biotech Spain S.L.',
    "ORG-100006270": 'Curevac AG',
    "ORG-100013793": 'CanSino Biologics',
    "ORG-100020693": 'China Sinopharm International Corp. - Beijing location',
    "ORG-100010771":
        'Sinopharm Weiqida Europe Pharmaceuticals.r.o. - Prague location',
    "ORG-100024420":
        'Sinopharm Zhijun Shenzhen PharmaceuticalCo. Ltd. - Shenzhen location',
    "ORG-100032020": 'Novavax CZ AS',
    "Gamaleya-Research-Institute": 'Gamaleya Research Institute',
    "Vector-Institute": 'Vector Institute',
    "Sinovac-Biotech": 'Sinovac Biotech',
    "Bharat-Biotech": 'Bharat Biotech',
    "ORG-100001981": 'Serum Institute Of India Private Limited',
    "ORG-100033914": 'Medigen Vaccine Biologics Corporation',
    "": 'unknown',
  };
}

enum TypeOfTestEnum {
  lP217198_3, // 快篩
  lP6464_4, // PCR
  unKnown,
}

class TypeOfTest {
  static const Map<String, String> map = {
    "LP217198-3": "Rapid immunoassay",
    "LP6464-4": "Nucleic acid amplification with probe detection",
  };

  static const Map<String, TypeOfTestEnum> mapEnum = {
    "LP217198-3": TypeOfTestEnum.lP217198_3,
    "LP6464-4": TypeOfTestEnum.lP6464_4,
  };

  /* 
  2022.01.04 PCR(lP6464_4) Rule
  <48hr: 綠燈
  48~120hr: 黃燈
  >120hr: 紅燈 
  */
  static const Map<TypeOfTestEnum, int> RedLightHourRule = {
    TypeOfTestEnum.lP217198_3: 48,
    TypeOfTestEnum.lP6464_4: 120,
  };

  static const Map<TypeOfTestEnum, int> AmberLightHourRule = {
    TypeOfTestEnum.lP217198_3: 0, // undefined
    TypeOfTestEnum.lP6464_4: 48,
  };
}

class TestManufacturerAndName {
  static const Map<String, String> map = {
    "1833": "AAZ-LMB, COVID-VIRO",
    "1232": "Abbott Rapid Diagnostics, Panbio COVID-19 Ag Rapid Test",
    "1468": "ACON Laboratories, Inc, Flowflex SARS-CoV-2 Antigen rapid test",
    "1304": "AMEDA Labordiagnostik GmbH, AMP Rapid Test SARS-CoV-2 Ag",
    "1822":
        "Anbio (Xiamen) Biotechnology Co., Ltd, Rapid COVID-19 Antigen Test(Colloidal Gold)",
    "1815":
        "Anhui Deep Blue Medical Technology Co., Ltd, COVID-19 (SARS-CoV-2) Antigen Test Kit (Colloidal Gold) - Nasal Swab",
    "1736":
        "Anhui Deep Blue Medical Technology Co., Ltd, COVID-19 (SARS-CoV-2) Antigen Test Kit(Colloidal Gold)",
    "768": "ArcDia International Ltd, mariPOC SARS-CoV-2",
    "1654": "Asan Pharmaceutical CO., LTD, Asan Easy Test COVID-19 Ag",
    "2010":
        "Atlas Link Technology Co., Ltd., NOVA Test® SARS-CoV-2 Antigen Rapid Test Kit (Colloidal Gold Immunochromatography)",
    "1906": "Azure Biotech Inc, COVID-19 Antigen Rapid Test Device",
    "1870":
        "Beijing Hotgen Biotech Co., Ltd, Novel Coronavirus 2019-nCoV Antigen Test (Colloidal Gold)",
    "1331":
        "Beijing Lepu Medical Technology Co., Ltd, SARS-CoV-2 Antigen Rapid Test Kit",
    "1484":
        "Beijing Wantai Biological Pharmacy Enterprise Co., Ltd, Wantai SARS-CoV-2 Ag Rapid Test (FIA)",
    "1223": "BIOSYNEX S.A., BIOSYNEX COVID-19 Ag BSS",
    "1236": "BTNX Inc, Rapid Response COVID-19 Antigen Rapid Test",
    "1173": "CerTest Biotec, CerTest SARS-CoV-2 Card test",
    "1919": "Core Technology Co., Ltd, Coretests COVID-19 Ag Test",
    "1225":
        "DDS DIAGNOSTIC, Test Rapid Covid-19 Antigen (tampon nazofaringian)",
    "1375": "DIALAB GmbH, DIAQUICK COVID-19 Ag Cassette",
    "1244": "GenBody, Inc, Genbody COVID-19 Ag Test",
    "1253":
        "GenSure Biotech Inc, GenSure COVID-19 Antigen Rapid Kit (REF: P2004)",
    "1144": "Green Cross Medical Science Corp., GENEDIA W COVID-19 Ag",
    "1747":
        "Guangdong Hecin Scientific, Inc., 2019-nCoV Antigen Test Kit (colloidal gold method)",
    "1360": "Guangdong Wesail Biotech Co., Ltd, COVID-19 Ag Test Kit",
    "1437":
        "Guangzhou Wondfo Biotech Co., Ltd, Wondfo 2019-nCoV Antigen Test (Lateral Flow Method)",
    "1256":
        "Hangzhou AllTest Biotech Co., Ltd, COVID-19 and Influenza A+B Antigen Combo Rapid Test",
    "1363":
        "Hangzhou Clongene Biotech Co., Ltd, Covid-19 Antigen Rapid Test Kit",
    "1365":
        "Hangzhou Clongene Biotech Co., Ltd, COVID-19/Influenza A+B Antigen Combo Rapid Test",
    "1844":
        "Hangzhou Immuno Biotech Co.,Ltd, Immunobio SARS-CoV-2 Antigen ANTERIOR NASAL Rapid Test Kit (minimal invasive)",
    "1215":
        "Hangzhou Laihe Biotech Co., Ltd, LYHER Novel Coronavirus (COVID-19) Antigen Test Kit(Colloidal Gold)",
    "1392":
        "Hangzhou Testsea Biotechnology Co., Ltd, COVID-19 Antigen Test Cassette",
    "1767": "Healgen Scientific, Coronavirus Ag Rapid Test Cassette",
    "1263": "Humasis, Humasis COVID-19 Ag Test",
    "1333":
        "Joinstar Biomedical Technology Co., Ltd, COVID-19 Rapid Antigen Test (Colloidal Gold)",
    "1764":
        "JOYSBIO (Tianjin) Biotechnology Co., Ltd, SARS-CoV-2 Antigen Rapid Test Kit (Colloidal Gold)",
    "1266": "Labnovation Technologies Inc, SARS-CoV-2 Antigen Rapid Test Kit",
    "1267": "LumiQuick Diagnostics Inc, QuickProfile COVID-19 Antigen Test",
    "1268": "LumiraDX, LumiraDx SARS-CoV-2 Ag Test",
    "1180": "MEDsan GmbH, MEDsan SARS-CoV-2 Antigen Rapid Test",
    "1190": "möLab, COVID-19 Rapid Antigen Test",
    "1481": "MP Biomedicals, Rapid SARS-CoV-2 Antigen Test Card",
    "1162": "Nal von minden GmbH, NADAL COVID-19 Ag Test",
    "1420": "NanoEntek, FREND COVID-19 Ag",
    "1199": "Oncosem Onkolojik Sistemler San. ve Tic. A.S., CAT",
    "308": "PCL Inc, PCL COVID19 Ag Rapid FIA",
    "1271": "Precision Biosensor, Inc, Exdia COVID-19 Ag",
    "1341":
        "Qingdao Hightop Biotech Co., Ltd, SARS-CoV-2 Antigen Rapid Test (Immunochromatography)",
    "1097": "Quidel Corporation, Sofia SARS Antigen FIA",
    "1606": "RapiGEN Inc, BIOCREDIT COVID-19 Ag - SARS-CoV 2 Antigen test",
    "1604": "Roche (SD BIOSENSOR), SARS-CoV-2 Antigen Rapid Test",
    "1489":
        "Safecare Biotech (Hangzhou) Co. Ltd, COVID-19 Antigen Rapid Test Kit (Swab)",
    "1490":
        "Safecare Biotech (Hangzhou) Co. Ltd, Multi-Respiratory Virus Antigen Test Kit(Swab)  (Influenza A+B/ COVID-19)",
    "344": "SD BIOSENSOR Inc, STANDARD F COVID-19 Ag FIA",
    "345": "SD BIOSENSOR Inc, STANDARD Q COVID-19 Ag Test",
    "1319": "SGA Medikal, V-Chek SARS-CoV-2 Ag Rapid Test Kit (Colloidal Gold)",
    "2017":
        "Shenzhen Ultra-Diagnostics Biotec.Co.,Ltd, SARS-CoV-2 Antigen Test Kit",
    "1769":
        "Shenzhen Watmind Medical Co., Ltd, SARS-CoV-2 Ag Diagnostic Test Kit (Colloidal Gold)",
    "1574":
        "Shenzhen Zhenrui Biotechnology Co., Ltd, Zhenrui ®COVID-19 Antigen Test Cassette",
    "1218": "Siemens Healthineers, CLINITEST Rapid Covid-19 Antigen Test",
    "1114": "Sugentech, Inc, SGTi-flex COVID-19 Ag",
    "1466": "TODA PHARMA, TODA CORONADIAG Ag",
    "1934":
        "Tody Laboratories Int., Coronavirus (SARS-CoV 2) Antigen - Oral Fluid",
    "1443":
        "Vitrosens Biotechnology Co., Ltd, RapidFor SARS-CoV-2 Rapid Ag Test",
    "1246":
        "VivaChek Biotech (Hangzhou) Co., Ltd, Vivadiag SARS CoV 2 Ag Rapid Test",
    "1763":
        "Xiamen AmonMed Biotechnology Co., Ltd, COVID-19 Antigen Rapid Test Kit (Colloidal Gold)",
    "1278": "Xiamen Boson Biotech Co. Ltd, Rapid SARS-CoV-2 Antigen Test Card",
    "1456": "Xiamen Wiz Biotech Co., Ltd, SARS-CoV-2 Antigen Rapid Test",
    "1884":
        "Xiamen Wiz Biotech Co., Ltd, SARS-CoV-2 Antigen Rapid Test (Colloidal Gold)",
    "1296":
        "Zhejiang Anji Saianfu Biotech Co., Ltd, AndLucky COVID-19 Antigen Rapid Test",
    "1295":
        "Zhejiang Anji Saianfu Biotech Co., Ltd, reOpenTest COVID-19 Antigen Rapid Test",
    "1343":
        "Zhezhiang Orient Gene Biotech Co., Ltd, Coronavirus Ag Rapid Test Cassette (Swab)",
  };
}

enum VerificationError {
  ///exp驗證
  green_certificate_expired,

  ///iat驗證
  green_certificate_in_future,

  ///未使用
  certificate_revoked,

  ///public key是否有
  verification_failed,

  ///驗證X509Certificate是否過期
  certificate_expired,

  ///test time
  test_date_is_in_the_future,
  test_date_is_excess,

  ///test result是否陽性
  test_result_positive,

  ///台灣尚未接受快篩數位證明
  test_tt_is_lP217198_3,

  ///recovery time驗證
  recovery_not_valid_so_far,
  recovery_not_valid_anymore,

  ///rule驗證
  rules_validation_failed,

  ///cose verify or other 密碼學簽章錯誤
  cryptographic_signature_invalid,
  not_error,
}

extension VerificationErrorExtension on VerificationError {
  static const verificationErrors = {
    VerificationError.green_certificate_expired: 'Certificate is expired',
    VerificationError.green_certificate_in_future:
        'Certificate issuance date is in the future',
    VerificationError.certificate_revoked: 'Certificate was revoked',
    VerificationError.verification_failed: 'Verification failed',
    VerificationError.certificate_expired: 'Signing Certificate is expired',
    VerificationError.test_date_is_in_the_future:
        'The test date is in the future',
    VerificationError.test_date_is_excess: 'PCR 檢測報告已超過有效期限',
    VerificationError.test_tt_is_lP217198_3: '台灣尚未接受快篩數位證明',
    VerificationError.test_result_positive: 'Test result positive',
    VerificationError.recovery_not_valid_so_far:
        'Recovery statement is not valid yet',
    VerificationError.recovery_not_valid_anymore:
        'Recovery statement is not valid anymore',
    VerificationError.rules_validation_failed:
        'Country rules validation failed',
    VerificationError.cryptographic_signature_invalid:
        'Cryptographic signature invalid',
  };
}

enum VerificationLimit {
  ///不在疾病代號清單中
  diseaseOutList,

  ///不在檢測類別清單中
  testTypeOutList,

  ///不在製造商清單中
  maOutList,

  ///陽性
  resultPositive,

  ///(棄用)
  ttOutTime48,

  ///(棄用)
  ttOutTime72,

  ///不在疫苗EMA清單中
  allowVaccine,

  ///不在有效時間內
  verificationTime,
}

extension VerificationLimitExtension on VerificationLimit {
  static const verificationLimitDesc = {
    VerificationLimit.diseaseOutList:
        'The "disease or agent targeted" must be COVID-19 of the value set list',
    VerificationLimit.testTypeOutList:
        'The test type must be one of the value set list (RAT OR NAA)',
    VerificationLimit.maOutList:
        'If the test type is "RAT" then the "test product and manufacturer" MUST be in the valueset list, if it\'s NAA return true',
    VerificationLimit.resultPositive:
        'Test result must be negative ("not detected")',
    VerificationLimit.ttOutTime48:
        'DateTime of Sample Collection must be less than 48 hours before the Verification Datetime for a test of type RAT (rapid antigen test)',
    VerificationLimit.ttOutTime72:
        'DateTime of Sample Collection must be less than 72 hours before the Verification Datetime for a test of type NAA (PCR test)',
    VerificationLimit.allowVaccine:
        'Only vaccines in the allowed valueset that have been approved by the EMA are allowed',
    VerificationLimit.verificationTime:
        'Verification Datetime must be more than 14 days and less than 365 days after the last date of vaccination',
  };
}

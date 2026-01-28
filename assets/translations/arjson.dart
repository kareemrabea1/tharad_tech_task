class Arjson {
  Arjson({
    this.loginTitle,
    this.email,
    this.password,
    this.loginBtn,
    this.haveAccount,
    this.dontHaveAccount,
    this.createAccount,
    this.homeNav,
    this.profileNav,
    this.welcomeTitle,
    this.language,
    this.apply,
    this.arabic,
    this.english,
    this.username,
    this.saveChanges,
  });

  Arjson.fromJson(dynamic json) {
    loginTitle = json['login_title'];
    email = json['email'];
    password = json['password'];
    loginBtn = json['login_btn'];
    haveAccount = json['have_account'];
    dontHaveAccount = json['dont_have_account'];
    createAccount = json['create_account'];
    homeNav = json['home_nav'];
    profileNav = json['profile_nav'];
    welcomeTitle = json['welcome_title'];
    language = json['language'];
    apply = json['apply'];
    arabic = json['arabic'];
    english = json['english'];
    username = json['username'];
    saveChanges = json['save_changes'];
  }
  String? loginTitle;
  String? email;
  String? password;
  String? loginBtn;
  String? haveAccount;
  String? dontHaveAccount;
  String? createAccount;
  String? homeNav;
  String? profileNav;
  String? welcomeTitle;
  String? language;
  String? apply;
  String? arabic;
  String? english;
  String? username;
  String? saveChanges;
  Arjson copyWith({
    String? loginTitle,
    String? email,
    String? password,
    String? loginBtn,
    String? haveAccount,
    String? dontHaveAccount,
    String? createAccount,
    String? homeNav,
    String? profileNav,
    String? welcomeTitle,
    String? language,
    String? apply,
    String? arabic,
    String? english,
    String? username,
    String? saveChanges,
  }) => Arjson(
    loginTitle: loginTitle ?? this.loginTitle,
    email: email ?? this.email,
    password: password ?? this.password,
    loginBtn: loginBtn ?? this.loginBtn,
    haveAccount: haveAccount ?? this.haveAccount,
    dontHaveAccount: dontHaveAccount ?? this.dontHaveAccount,
    createAccount: createAccount ?? this.createAccount,
    homeNav: homeNav ?? this.homeNav,
    profileNav: profileNav ?? this.profileNav,
    welcomeTitle: welcomeTitle ?? this.welcomeTitle,
    language: language ?? this.language,
    apply: apply ?? this.apply,
    arabic: arabic ?? this.arabic,
    english: english ?? this.english,
    username: username ?? this.username,
    saveChanges: saveChanges ?? this.saveChanges,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['login_title'] = loginTitle;
    map['email'] = email;
    map['password'] = password;
    map['login_btn'] = loginBtn;
    map['have_account'] = haveAccount;
    map['dont_have_account'] = dontHaveAccount;
    map['create_account'] = createAccount;
    map['home_nav'] = homeNav;
    map['profile_nav'] = profileNav;
    map['welcome_title'] = welcomeTitle;
    map['language'] = language;
    map['apply'] = apply;
    map['arabic'] = arabic;
    map['english'] = english;
    map['username'] = username;
    map['save_changes'] = saveChanges;
    return map;
  }
}

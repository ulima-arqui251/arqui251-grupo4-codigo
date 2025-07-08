class Config {
  static String get ambiente =>
      const String.fromEnvironment("AMBIENTE", defaultValue: "UNAUTHORIZED");

  static String get authApiUrl => const String.fromEnvironment("AUTH_API_URL");

  static String get noticiasApiUrl =>
      const String.fromEnvironment("NOTICIAS_API_URL");

  static String get chatbotApiUrl =>
      const String.fromEnvironment("CHATBOT_API_URL");

  static String get jawgAccessToken =>
      const String.fromEnvironment("JAWG_MAPS_ACCESS_TOKEN");

  static String get googleWebClientId =>
      const String.fromEnvironment("GOOGLE_WEB_CLIENT_ID");

  static String get googleAndroidClientId =>
      const String.fromEnvironment("GOOGLE_ANDROID_CLIENT_ID");

  static String get discordOauthUrl =>
      const String.fromEnvironment("DISCORD_OAUTH_URL");
}

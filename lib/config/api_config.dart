class ApiConfig {
  static const String apiKey = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjU2Y2QxODUxLTE4ODEtNGZiZC1hZTRlLWQwYzI2ODRmMDFjMCIsImlhdCI6MTc3ODMxNjY2OSwic3ViIjoiZGV2ZWxvcGVyL2I2NmEwZjJiLTllZDAtOGEzYi1iMmY5LWM4NzdiOTFmZWZmOCIsInNjb3BlcyI6WyJjbGFzaCJdLCJsaW1pdHMiOlt7InRpZXIiOiJkZXZlbG9wZXIvc2lsdmVyIiwidHlwZSI6InRocm90dGxpbmcifSx7ImNpZHJzIjpbIjg5LjIyLjIyNC4xMzkiXSwidHlwZSI6ImNsaWVudCJ9XX0.IG8vMW1x54tBls3pYMA0WonD9IonyITerwCbo7vyC5NtDECxy_NTpD93h-jQS9MIXKj0FECMhSBo0kmV0wzvbg';
  static const String baseUrl = 'https://api.clashofclans.com/v1';

  static Map<String, String> get headers => {
    'Accept': 'application/json',
    'authorization': 'Bearer $apiKey',
  };
}

class CompileCodeResponse {
  final String status;
  final String message;
  final CompileCodeData data;

  CompileCodeResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompileCodeResponse.fromJson(Map<String, dynamic> json) {
    return CompileCodeResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: CompileCodeData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class CompileCodeData {
  final CodeResult result;

  CompileCodeData({
    required this.result,
  });

  factory CompileCodeData.fromJson(Map<String, dynamic> json) {
    return CompileCodeData(
      result: CodeResult.fromJson(json['result'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result.toJson(),
    };
  }
}

class CodeResult {
  final String output;
  final String error;
  final String status;
  final int exitCode;
  final dynamic signal;
  final String time;
  final String memory;
  final String total;

  CodeResult({
    required this.output,
    required this.error,
    required this.status,
    required this.exitCode,
    required this.signal,
    required this.time,
    required this.memory,
    required this.total,
  });

  factory CodeResult.fromJson(Map<String, dynamic> json) {
    return CodeResult(
      output: json['output'] ?? '',
      error: json['error'] ?? '',
      status: json['status'] ?? '',
      exitCode: json['exit_code'] ?? 0,
      signal: json['signal'],
      time: json['time'] ?? '',
      memory: json['memory'] ?? '',
      total: json['total'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'output': output,
      'error': error,
      'status': status,
      'exit_code': exitCode,
      'signal': signal,
      'time': time,
      'memory': memory,
      'total': total,
    };
  }
}
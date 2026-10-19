/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:async' as _ida;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:weakspot_client/src/protocol/answer_result.dart' as _i3801zwx;
import 'package:weakspot_client/src/protocol/build_result.dart' as _ikuwddcu;
import 'package:weakspot_client/src/protocol/greetings/greeting.dart'
    as _ilrih83o;
import 'package:weakspot_client/src/protocol/mastery_report.dart' as _igg6xe51;
import 'package:weakspot_client/src/protocol/question.dart' as _im0y1xdc;
import 'protocol.dart' as _il2as5qe;

/// Serves questions, records answers, and reports where the student is weak.
///
/// No AI is involved in any of this. Every call is deterministic.
/// {@category Endpoint}
class EndpointQuiz extends _isc.EndpointRef {
  EndpointQuiz(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'quiz';

  /// The next weighted round. Weak topics come back more often.
  _ida.Future<List<_im0y1xdc.Question>> next({required int count}) =>
      caller.callServerEndpoint<List<_im0y1xdc.Question>>(
        'quiz',
        'next',
        {'count': count},
      );

  _ida.Future<_i3801zwx.AnswerResult> submit({
    required int questionId,
    required int selectedIndex,
  }) => caller.callServerEndpoint<_i3801zwx.AnswerResult>(
    'quiz',
    'submit',
    {
      'questionId': questionId,
      'selectedIndex': selectedIndex,
    },
  );

  _ida.Future<_igg6xe51.MasteryReport> report() =>
      caller.callServerEndpoint<_igg6xe51.MasteryReport>(
        'quiz',
        'report',
        {},
      );
}

/// Turns a syllabus into topics and questions, then hands back the first
/// weighted round so the client can go straight into a quiz.
/// {@category Endpoint}
class EndpointSyllabus extends _isc.EndpointRef {
  EndpointSyllabus(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'syllabus';

  _ida.Future<_ikuwddcu.BuildResult> build({
    required String syllabus,
    required int questionsPerTopic,
  }) => caller.callServerEndpoint<_ikuwddcu.BuildResult>(
    'syllabus',
    'build',
    {
      'syllabus': syllabus,
      'questionsPerTopic': questionsPerTopic,
    },
  );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _isc.EndpointRef {
  EndpointGreeting(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _ida.Future<_ilrih83o.Greeting> hello(String name) =>
      caller.callServerEndpoint<_ilrih83o.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    quiz = EndpointQuiz(this);
    syllabus = EndpointSyllabus(this);
    greeting = EndpointGreeting(this);
  }

  late final EndpointQuiz quiz;

  late final EndpointSyllabus syllabus;

  late final EndpointGreeting greeting;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'quiz': quiz,
    'syllabus': syllabus,
    'greeting': greeting,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {};
}

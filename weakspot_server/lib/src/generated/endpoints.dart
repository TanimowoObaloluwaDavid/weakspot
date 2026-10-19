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

import 'package:serverpod/serverpod.dart' as _is;
import '../endpoints/quiz_endpoint.dart' as _i7z0uw2a;
import '../endpoints/syllabus_endpoint.dart' as _iiu0augs;
import '../greetings/greeting_endpoint.dart' as _il624ik7;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'quiz': _i7z0uw2a.QuizEndpoint()
        ..initialize(
          server,
          'quiz',
          null,
        ),
      'syllabus': _iiu0augs.SyllabusEndpoint()
        ..initialize(
          server,
          'syllabus',
          null,
        ),
      'greeting': _il624ik7.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['quiz'] = _is.EndpointConnector(
      name: 'quiz',
      endpoint: endpoints['quiz']!,
      methodConnectors: {
        'next': _is.MethodConnector(
          name: 'next',
          params: {
            'count': _is.ParameterDescription(
              name: 'count',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['quiz'] as _i7z0uw2a.QuizEndpoint).next(
                session,
                count: params['count'],
              ),
        ),
        'submit': _is.MethodConnector(
          name: 'submit',
          params: {
            'questionId': _is.ParameterDescription(
              name: 'questionId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'selectedIndex': _is.ParameterDescription(
              name: 'selectedIndex',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['quiz'] as _i7z0uw2a.QuizEndpoint).submit(
                session,
                questionId: params['questionId'],
                selectedIndex: params['selectedIndex'],
              ),
        ),
        'report': _is.MethodConnector(
          name: 'report',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['quiz'] as _i7z0uw2a.QuizEndpoint).report(session),
        ),
      },
    );
    connectors['syllabus'] = _is.EndpointConnector(
      name: 'syllabus',
      endpoint: endpoints['syllabus']!,
      methodConnectors: {
        'build': _is.MethodConnector(
          name: 'build',
          params: {
            'syllabus': _is.ParameterDescription(
              name: 'syllabus',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'questionsPerTopic': _is.ParameterDescription(
              name: 'questionsPerTopic',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['syllabus'] as _iiu0augs.SyllabusEndpoint).build(
                    session,
                    syllabus: params['syllabus'],
                    questionsPerTopic: params['questionsPerTopic'],
                  ),
        ),
      },
    );
    connectors['greeting'] = _is.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _is.MethodConnector(
          name: 'hello',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['greeting'] as _il624ik7.GreetingEndpoint).hello(
                    session,
                    params['name'],
                  ),
        ),
      },
    );
  }
}

import 'note.dart';

class NotesApi {
	bool? success;
	List<Note>? notes;
	String? message;

	NotesApi({this.success, this.notes, this.message});

	factory NotesApi.fromJson(Map<String, dynamic> json) => NotesApi(
				success: json['success'] as bool?,
				notes: (json['data'] as List<dynamic>?)
						?.map((e) => Note.fromJson(e as Map<String, dynamic>))
						.toList(),
				message: json['message'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'success': success,
				'data': notes?.map((e) => e.toJson()).toList(),
				'message': message,
			};
}

class Note {
	int? id;
	String? noteTitle;
	String? noteDetails;
	String? createdAt;
	String? updatedAt;

	Note({
		this.id, 
		this.noteTitle, 
		this.noteDetails, 
		this.createdAt, 
		this.updatedAt, 
	});

	factory Note.fromJson(Map<String, dynamic> json) => Note(
				id: json['id'] as int?,
				noteTitle: json['note_title'] as String?,
				noteDetails: json['note_details'] as String?,
				createdAt: json['created_at'] as String?,
				updatedAt: json['updated_at'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'note_title': noteTitle,
				'note_details': noteDetails,
				'created_at': createdAt,
				'updated_at': updatedAt,
			};
}

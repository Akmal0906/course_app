class GroupModel {
  final int id;
  final String name;
  final int course;
  final List students;

  GroupModel(
  { required this.id, required  this.name, required this.course, required this.students});

factory GroupModel.fromJson(Map<String, dynamic> json){
    return GroupModel(id: json['id'],
        name: json['name'],
        course: json['course'],
        students: json['students']);
  }

  Map<String,dynamic> toJson(){
  return {
    'id':id,
    'name':name,
    'course':course,
    'students':students
  };
  }
}
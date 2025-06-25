import school/[functions]

when isMainModule:
  initDirector(dir, "Ivan", "Petrov", "15.05.1975")
  echo dir

  initTeacher(teacher, "Maria", "Ivanova", "22.08.1980")
  teacher.addClassNum("10A")
  teacher.addClassNum("11B")
  echo teacher

  initStudent(student, "Pavel", "Sidorov", "10.03.2008", "10A")
  echo student

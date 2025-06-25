type
  Person* = ref object of RootObj
    firstName*: string
    lastName*: string
    birthDate*: int64

  Director* = ref object of Person

  Teacher* = ref object of Person
    classNums*: seq[string]

  Student* = ref object of Person
    classNum*: string

  School* = ref object of RootObj
    director*: Director
    teachers*: seq[Teacher]
    students*: seq[Student]


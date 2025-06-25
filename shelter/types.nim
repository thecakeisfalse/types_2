type
  Post* = enum
    NONE, Уборщик, Ветеринар, Менеджер, Директор

  Person* = ref object of RootObj
    name*: string
    birthDate*: int64

  Staff* = ref object of Person
    uid*: int
    post*: Post

  Pet* = ref object of RootObj
    name*: string
    age*: int

  Manager* = ref object of Person

  Shelter* = ref object of RootObj
    staff*: seq[Staff]
    pets*: seq[Pet]
    managers*: seq[Manager]


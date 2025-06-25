import times
import re, strutils

import types

proc toUnix(date: string): int64 =
  try:
    return date.parse("dd'.'MM'.'YYYY").toTime.toUnix
  except TimeParseError:
    stderr.write(getCurrentExceptionMsg() & "\n")
    return result

proc toStr(date: int64): string =
  fromUnix(date).format("dd'.'MM'.'YYYY")

proc checkStr[T](data: T, description: string): bool =
  var pattern: Regex
  case description
  of "name":
    pattern = re"^(([A-Za-z]{2,}) ?){2,}$"
  data.match(pattern)

proc checkDigit[T](data: T, description: string): bool =
  case description
  of "age":
    data > 0 and data < 30
  of "uid":
    data > 0
  else:
    data > 0

template setDate*(obj, attr; date: string) =
  obj.attr = date.toUnix

template setAttrValue*(
    obj, attr, value, checkFunc;
    description: string) =
  if checkFunc(value, description):
    obj.attr = value

proc setStaffPost*(self: Staff, post: string) =
  try:
    self.post = parseEnum[Post](post)
  except ValueError:
    stderr.write("Нет такой должности $1\n" % post)
    self.post = NONE

template initPerson*(T: type; varName; nameValue, birthDateValue: string) =
  let varName = T()
  varName.setAttrValue(name, nameValue, checkStr, "name")
  varName.setDate(birthDate, birthDateValue)

template initStaff*(varName; nameValue, birthDateValue: string;
                   uidValue: int, postValue: string) =
  initPerson(Staff, varName, nameValue, birthDateValue)
  varName.setAttrValue(uid, uidValue, checkDigit, "uid")
  varName.setStaffPost(postValue)

template initManager*(varName; nameValue, birthDateValue: string) =
  initPerson(Manager, varName, nameValue, birthDateValue)

template initPet*(varName; nameValue: string; ageValue: int) =
  let varName = Pet()
  varName.setAttrValue(name, nameValue, checkStr, "name")
  varName.setAttrValue(age, ageValue, checkDigit, "age")

proc `$`*(self: Person): string =
  "$1, дата рождения: $2" % [
    self.name,
    self.birthDate.toStr
  ]

proc `$`*(self: Staff): string =
  "Сотрудник: " & `$`(self.Person) &
      "\nID: $1\nДолжность: $2" % [
    $self.uid,
    $self.post
  ]

proc `$`*(self: Manager): string =
  "Менеджер: " & `$`(self.Person)

proc `$`*(self: Pet): string =
  "Питомец: $1\nВозраст: $2 лет" % [
    self.name,
    $self.age
  ]


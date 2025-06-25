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
    pattern = re"^([A-Za-z]{2,})$"
  of "class":
    pattern = re"^([0-9]{1,2}[A-Za-z]?)$"
  data.match(pattern)

proc checkDigit[T](data: T, description: string): bool =
  data > 0

template getAttrValue(obj, attr): auto = obj.attr

template setDate*(obj, attr; date: string) =
  obj.attr = date.toUnix

template setAttrValue*(
    obj, attr, value, checkFunc;
    description: string) =
  if checkFunc(value, description):
    obj.attr = value

proc addClassNum*(self: Teacher, classNum: string) =
  if checkStr(classNum, "class"):
    self.classNums.add(classNum)

template initPerson*(T: type; varName;
                   firstNameValue, lastNameValue,
                   birthDateValue: string) =
  let varName = T()
  varName.setAttrValue(firstName, firstNameValue, checkStr, "name")
  varName.setAttrValue(lastName, lastNameValue, checkStr, "name")
  varName.setDate(birthDate, birthDateValue)

template initDirector*(varName;
                     firstNameValue, lastNameValue,
                     birthDateValue: string) =
  initPerson(Director, varName, firstNameValue, lastNameValue, birthDateValue)

template initTeacher*(varName;
                    firstNameValue, lastNameValue,
                    birthDateValue: string) =
  initPerson(Teacher, varName, firstNameValue, lastNameValue, birthDateValue)

template initStudent*(varName;
                    firstNameValue, lastNameValue,
                    birthDateValue, classNumValue: string) =
  initPerson(Student, varName, firstNameValue, lastNameValue, birthDateValue)
  varName.setAttrValue(classNum, classNumValue, checkStr, "class")

proc `$`*(self: Person): string =
  "$1 $2, дата рождения: $3" % [
    self.getAttrValue(firstName),
    self.getAttrValue(lastName),
    self.getAttrValue(birthDate).toStr
  ]

proc `$`*(self: Director): string =
  "Директор: " & `$`(self.Person)

proc `$`*(self: Teacher): string =
  var classesStr = if self.classNums.len > 0: self.classNums.join(
      ", ") else: "нет классов"
  "Учитель: " & `$`(self.Person) &
      "\nПреподаваемые классы: " & classesStr

proc `$`*(self: Student): string =
  "Ученик:" & `$`(self.Person) & "\nКласс: " & self.getAttrValue(classNum)


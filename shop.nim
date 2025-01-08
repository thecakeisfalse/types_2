import shop/[functions]

when isMainModule:
  initStaff(staff, "Ivan", "Ivanov", "22.02.1998", "Кассир")
  echo staff
  initGood(good, "Title", 100, "01.01.1970", 0.33, 5)
  echo good
  initCash(cash, 55, false, 55_333.44)
  echo cash

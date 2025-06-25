import shelter/[functions]

when isMainModule:
  initStaff(worker, "Ivan Petrov", "15.05.1990", 101, "Ветеринар")
  echo worker

  initPet(cat, "IGOR", 3)
  echo cat

  initManager(mgr, "Anna Sidorova", "22.08.1985")
  echo mgr

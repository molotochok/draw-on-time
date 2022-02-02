extends Reference

class_name FunctionDiagnostics

static func measure(function: FuncRef, name: String = ""):
  var time_before = OS.get_ticks_msec()

  function.call_func()

  var total_time = OS.get_ticks_msec() - time_before
  print("Time taken for " + name + ": " + str(total_time))
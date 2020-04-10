load harness

@test "testBasicAddition_1" {
  check '5 + 2' '7'
}

@test "testBasicAddition_2" {
  check '-5 + -2' '-7'
}

@test "testBasicMultiplication_1" {
  check '5 * 20' '100'
}

@test "testBasicMultiplication_2" {
  check '5 * -20' '-100'
}

@test "testMultiplication_DoubleNegetives" {
  check '-5 * -20' '100'
}

@test "testSubtraction_1" {
  check '5 - -2' '7'
}

@test "testSubtraction_2" {
  check '-5 - -2' '-3'
}

@test "testBasicDivision_1" {
  check '5 / 2' '2'
}

@test "testBasicDivision_2" {
  check '-5 / 2' '-2'
}

@test "testBasicDivision_3" {
  check '-5 / -2' '2'
}

@test "testBasicDivision_4" {
  check '0 / -2' '0'
}

@test "testComplex_1" {
  check '4 * 3 / 9 + 2' '2'
}

@test "testComplex_2" {
  check '4 * 3 + 9 - -3 / 2' '22'
}






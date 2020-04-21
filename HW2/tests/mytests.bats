load harness

@test "swap-two-numbers" {
  check 'x := 10 ; y := 5 ; x := x + y ; y := x - y ; x := x - y' '{x → 5, y → 10}'
}

@test "gcd" {
  check 'num1 := 55 ; num2 := 121 ; while num1 ¬= num2 do if num1 > num2 then num1 := num1 - num2 else num2 := num2 - num1' '{num1 → 11, num2 → 11}'
}

@test "nth-fibonacci" {
  check 'first := 0 ; second := 1 ; n := 8 ; i := 2 ; while i <= n do { third := first + second ; first := second ; second := third ; i := i + 1 }' '{first → 13, i → 9, n → 8, second → 21, third → 21}'
}

@test "sum-of-n-consecutive-odd-numbers" {
  check 'curr := 1 ; n := 15 ; i := 0 ; sum := 0 ; while i < n do { sum := sum + curr ; curr := curr + 2 ; i := i + 1 }' '{curr → 31, i → 15, n → 15, sum → 225}'
}

@test "largest-of-three-numbers" {
  check 'num1 := 10 ; num2 := 20 ; num3 := 7 ; if num1 >= num2 then if num1 >= num3 then largest := num1 else largest := num3 else if num2 >= num3 then largest := num2 else largest := num3' '{largest → 20, num1 → 10, num2 → 20, num3 → 7}'
}

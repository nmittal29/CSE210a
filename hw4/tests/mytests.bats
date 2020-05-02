load harness

@test "swap-two-numbers" {
  check 'x := 10 ; y := 5 ; x := x + y ; y := x - y ; x := x - y' '⇒ skip; y := 5; x := (x+y); y := (x-y); x := (x-y), {x → 10}
⇒ y := 5; x := (x+y); y := (x-y); x := (x-y), {x → 10}
⇒ skip; x := (x+y); y := (x-y); x := (x-y), {x → 10, y → 5}
⇒ x := (x+y); y := (x-y); x := (x-y), {x → 10, y → 5}
⇒ skip; y := (x-y); x := (x-y), {x → 15, y → 5}
⇒ y := (x-y); x := (x-y), {x → 15, y → 5}
⇒ skip; x := (x-y), {x → 15, y → 10}
⇒ x := (x-y), {x → 15, y → 10}
⇒ skip, {x → 5, y → 10}'
}

@test "gcd" {
  check 'num1 := 55 ; num2 := 121 ; while num1 ¬= num2 do if num1 > num2 then num1 := num1 - num2 else num2 := num2 - num1' '⇒ skip; num2 := 121; while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 55}
⇒ num2 := 121; while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 55}
⇒ skip; while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 55, num2 → 121}
⇒ while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 55, num2 → 121}
⇒ if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) }; while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 55, num2 → 121}
⇒ num2 := (num2-num1); while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 55, num2 → 121}
⇒ skip; while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 55, num2 → 66}
⇒ while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 55, num2 → 66}
⇒ if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) }; while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 55, num2 → 66}
⇒ num2 := (num2-num1); while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 55, num2 → 66}
⇒ skip; while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 55, num2 → 11}
⇒ while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 55, num2 → 11}
⇒ if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) }; while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 55, num2 → 11}
⇒ num1 := (num1-num2); while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 55, num2 → 11}
⇒ skip; while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 44, num2 → 11}
⇒ while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 44, num2 → 11}
⇒ if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) }; while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 44, num2 → 11}
⇒ num1 := (num1-num2); while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 44, num2 → 11}
⇒ skip; while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 33, num2 → 11}
⇒ while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 33, num2 → 11}
⇒ if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) }; while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 33, num2 → 11}
⇒ num1 := (num1-num2); while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 33, num2 → 11}
⇒ skip; while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 22, num2 → 11}
⇒ while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 22, num2 → 11}
⇒ if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) }; while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 22, num2 → 11}
⇒ num1 := (num1-num2); while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 22, num2 → 11}
⇒ skip; while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 11, num2 → 11}
⇒ while (num1¬=num2) do { if (num1>num2) then { num1 := (num1-num2) } else { num2 := (num2-num1) } }, {num1 → 11, num2 → 11}
⇒ skip, {num1 → 11, num2 → 11}'
}

@test "nth-fibonacci" {
  check 'first := 0 ; second := 1 ; n := 8 ; i := 2 ; while i <= n do { third := first + second ; first := second ; second := third ; i := i + 1 }' '⇒ skip; second := 1; n := 8; i := 2; while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 0}
⇒ second := 1; n := 8; i := 2; while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 0}
⇒ skip; n := 8; i := 2; while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 0, second → 1}
⇒ n := 8; i := 2; while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 0, second → 1}
⇒ skip; i := 2; while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 0, n → 8, second → 1}
⇒ i := 2; while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 0, n → 8, second → 1}
⇒ skip; while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 0, i → 2, n → 8, second → 1}
⇒ while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 0, i → 2, n → 8, second → 1}
⇒ third := (first+second); first := second; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 0, i → 2, n → 8, second → 1}
⇒ skip; first := second; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 0, i → 2, n → 8, second → 1, third → 1}
⇒ first := second; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 0, i → 2, n → 8, second → 1, third → 1}
⇒ skip; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 1, i → 2, n → 8, second → 1, third → 1}
⇒ second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 1, i → 2, n → 8, second → 1, third → 1}
⇒ skip; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 1, i → 2, n → 8, second → 1, third → 1}
⇒ i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 1, i → 2, n → 8, second → 1, third → 1}
⇒ skip; while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 1, i → 3, n → 8, second → 1, third → 1}
⇒ while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 1, i → 3, n → 8, second → 1, third → 1}
⇒ third := (first+second); first := second; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 1, i → 3, n → 8, second → 1, third → 1}
⇒ skip; first := second; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 1, i → 3, n → 8, second → 1, third → 2}
⇒ first := second; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 1, i → 3, n → 8, second → 1, third → 2}
⇒ skip; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 1, i → 3, n → 8, second → 1, third → 2}
⇒ second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 1, i → 3, n → 8, second → 1, third → 2}
⇒ skip; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 1, i → 3, n → 8, second → 2, third → 2}
⇒ i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 1, i → 3, n → 8, second → 2, third → 2}
⇒ skip; while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 1, i → 4, n → 8, second → 2, third → 2}
⇒ while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 1, i → 4, n → 8, second → 2, third → 2}
⇒ third := (first+second); first := second; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 1, i → 4, n → 8, second → 2, third → 2}
⇒ skip; first := second; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 1, i → 4, n → 8, second → 2, third → 3}
⇒ first := second; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 1, i → 4, n → 8, second → 2, third → 3}
⇒ skip; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 2, i → 4, n → 8, second → 2, third → 3}
⇒ second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 2, i → 4, n → 8, second → 2, third → 3}
⇒ skip; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 2, i → 4, n → 8, second → 3, third → 3}
⇒ i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 2, i → 4, n → 8, second → 3, third → 3}
⇒ skip; while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 2, i → 5, n → 8, second → 3, third → 3}
⇒ while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 2, i → 5, n → 8, second → 3, third → 3}
⇒ third := (first+second); first := second; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 2, i → 5, n → 8, second → 3, third → 3}
⇒ skip; first := second; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 2, i → 5, n → 8, second → 3, third → 5}
⇒ first := second; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 2, i → 5, n → 8, second → 3, third → 5}
⇒ skip; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 3, i → 5, n → 8, second → 3, third → 5}
⇒ second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 3, i → 5, n → 8, second → 3, third → 5}
⇒ skip; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 3, i → 5, n → 8, second → 5, third → 5}
⇒ i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 3, i → 5, n → 8, second → 5, third → 5}
⇒ skip; while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 3, i → 6, n → 8, second → 5, third → 5}
⇒ while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 3, i → 6, n → 8, second → 5, third → 5}
⇒ third := (first+second); first := second; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 3, i → 6, n → 8, second → 5, third → 5}
⇒ skip; first := second; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 3, i → 6, n → 8, second → 5, third → 8}
⇒ first := second; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 3, i → 6, n → 8, second → 5, third → 8}
⇒ skip; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 5, i → 6, n → 8, second → 5, third → 8}
⇒ second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 5, i → 6, n → 8, second → 5, third → 8}
⇒ skip; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 5, i → 6, n → 8, second → 8, third → 8}
⇒ i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 5, i → 6, n → 8, second → 8, third → 8}
⇒ skip; while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 5, i → 7, n → 8, second → 8, third → 8}
⇒ while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 5, i → 7, n → 8, second → 8, third → 8}
⇒ third := (first+second); first := second; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 5, i → 7, n → 8, second → 8, third → 8}
⇒ skip; first := second; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 5, i → 7, n → 8, second → 8, third → 13}
⇒ first := second; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 5, i → 7, n → 8, second → 8, third → 13}
⇒ skip; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 8, i → 7, n → 8, second → 8, third → 13}
⇒ second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 8, i → 7, n → 8, second → 8, third → 13}
⇒ skip; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 8, i → 7, n → 8, second → 13, third → 13}
⇒ i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 8, i → 7, n → 8, second → 13, third → 13}
⇒ skip; while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 8, i → 8, n → 8, second → 13, third → 13}
⇒ while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 8, i → 8, n → 8, second → 13, third → 13}
⇒ third := (first+second); first := second; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 8, i → 8, n → 8, second → 13, third → 13}
⇒ skip; first := second; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 8, i → 8, n → 8, second → 13, third → 21}
⇒ first := second; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 8, i → 8, n → 8, second → 13, third → 21}
⇒ skip; second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 13, i → 8, n → 8, second → 13, third → 21}
⇒ second := third; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 13, i → 8, n → 8, second → 13, third → 21}
⇒ skip; i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 13, i → 8, n → 8, second → 21, third → 21}
⇒ i := (i+1); while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 13, i → 8, n → 8, second → 21, third → 21}
⇒ skip; while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 13, i → 9, n → 8, second → 21, third → 21}
⇒ while (i<=n) do { third := (first+second); first := second; second := third; i := (i+1) }, {first → 13, i → 9, n → 8, second → 21, third → 21}
⇒ skip, {first → 13, i → 9, n → 8, second → 21, third → 21}'
}

@test "sum-of-n-consecutive-odd-numbers" {
  check 'curr := 1 ; n := 15 ; i := 0 ; sum := 0 ; while i < n do { sum := sum + curr ; curr := curr + 2 ; i := i + 1 }' '⇒ skip; n := 15; i := 0; sum := 0; while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 1}
⇒ n := 15; i := 0; sum := 0; while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 1}
⇒ skip; i := 0; sum := 0; while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 1, n → 15}
⇒ i := 0; sum := 0; while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 1, n → 15}
⇒ skip; sum := 0; while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 1, i → 0, n → 15}
⇒ sum := 0; while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 1, i → 0, n → 15}
⇒ skip; while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 1, i → 0, n → 15, sum → 0}
⇒ while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 1, i → 0, n → 15, sum → 0}
⇒ sum := (sum+curr); curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 1, i → 0, n → 15, sum → 0}
⇒ skip; curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 1, i → 0, n → 15, sum → 1}
⇒ curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 1, i → 0, n → 15, sum → 1}
⇒ skip; i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 3, i → 0, n → 15, sum → 1}
⇒ i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 3, i → 0, n → 15, sum → 1}
⇒ skip; while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 3, i → 1, n → 15, sum → 1}
⇒ while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 3, i → 1, n → 15, sum → 1}
⇒ sum := (sum+curr); curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 3, i → 1, n → 15, sum → 1}
⇒ skip; curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 3, i → 1, n → 15, sum → 4}
⇒ curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 3, i → 1, n → 15, sum → 4}
⇒ skip; i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 5, i → 1, n → 15, sum → 4}
⇒ i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 5, i → 1, n → 15, sum → 4}
⇒ skip; while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 5, i → 2, n → 15, sum → 4}
⇒ while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 5, i → 2, n → 15, sum → 4}
⇒ sum := (sum+curr); curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 5, i → 2, n → 15, sum → 4}
⇒ skip; curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 5, i → 2, n → 15, sum → 9}
⇒ curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 5, i → 2, n → 15, sum → 9}
⇒ skip; i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 7, i → 2, n → 15, sum → 9}
⇒ i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 7, i → 2, n → 15, sum → 9}
⇒ skip; while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 7, i → 3, n → 15, sum → 9}
⇒ while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 7, i → 3, n → 15, sum → 9}
⇒ sum := (sum+curr); curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 7, i → 3, n → 15, sum → 9}
⇒ skip; curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 7, i → 3, n → 15, sum → 16}
⇒ curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 7, i → 3, n → 15, sum → 16}
⇒ skip; i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 9, i → 3, n → 15, sum → 16}
⇒ i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 9, i → 3, n → 15, sum → 16}
⇒ skip; while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 9, i → 4, n → 15, sum → 16}
⇒ while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 9, i → 4, n → 15, sum → 16}
⇒ sum := (sum+curr); curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 9, i → 4, n → 15, sum → 16}
⇒ skip; curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 9, i → 4, n → 15, sum → 25}
⇒ curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 9, i → 4, n → 15, sum → 25}
⇒ skip; i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 11, i → 4, n → 15, sum → 25}
⇒ i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 11, i → 4, n → 15, sum → 25}
⇒ skip; while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 11, i → 5, n → 15, sum → 25}
⇒ while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 11, i → 5, n → 15, sum → 25}
⇒ sum := (sum+curr); curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 11, i → 5, n → 15, sum → 25}
⇒ skip; curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 11, i → 5, n → 15, sum → 36}
⇒ curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 11, i → 5, n → 15, sum → 36}
⇒ skip; i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 13, i → 5, n → 15, sum → 36}
⇒ i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 13, i → 5, n → 15, sum → 36}
⇒ skip; while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 13, i → 6, n → 15, sum → 36}
⇒ while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 13, i → 6, n → 15, sum → 36}
⇒ sum := (sum+curr); curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 13, i → 6, n → 15, sum → 36}
⇒ skip; curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 13, i → 6, n → 15, sum → 49}
⇒ curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 13, i → 6, n → 15, sum → 49}
⇒ skip; i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 15, i → 6, n → 15, sum → 49}
⇒ i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 15, i → 6, n → 15, sum → 49}
⇒ skip; while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 15, i → 7, n → 15, sum → 49}
⇒ while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 15, i → 7, n → 15, sum → 49}
⇒ sum := (sum+curr); curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 15, i → 7, n → 15, sum → 49}
⇒ skip; curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 15, i → 7, n → 15, sum → 64}
⇒ curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 15, i → 7, n → 15, sum → 64}
⇒ skip; i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 17, i → 7, n → 15, sum → 64}
⇒ i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 17, i → 7, n → 15, sum → 64}
⇒ skip; while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 17, i → 8, n → 15, sum → 64}
⇒ while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 17, i → 8, n → 15, sum → 64}
⇒ sum := (sum+curr); curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 17, i → 8, n → 15, sum → 64}
⇒ skip; curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 17, i → 8, n → 15, sum → 81}
⇒ curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 17, i → 8, n → 15, sum → 81}
⇒ skip; i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 19, i → 8, n → 15, sum → 81}
⇒ i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 19, i → 8, n → 15, sum → 81}
⇒ skip; while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 19, i → 9, n → 15, sum → 81}
⇒ while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 19, i → 9, n → 15, sum → 81}
⇒ sum := (sum+curr); curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 19, i → 9, n → 15, sum → 81}
⇒ skip; curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 19, i → 9, n → 15, sum → 100}
⇒ curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 19, i → 9, n → 15, sum → 100}
⇒ skip; i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 21, i → 9, n → 15, sum → 100}
⇒ i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 21, i → 9, n → 15, sum → 100}
⇒ skip; while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 21, i → 10, n → 15, sum → 100}
⇒ while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 21, i → 10, n → 15, sum → 100}
⇒ sum := (sum+curr); curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 21, i → 10, n → 15, sum → 100}
⇒ skip; curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 21, i → 10, n → 15, sum → 121}
⇒ curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 21, i → 10, n → 15, sum → 121}
⇒ skip; i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 23, i → 10, n → 15, sum → 121}
⇒ i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 23, i → 10, n → 15, sum → 121}
⇒ skip; while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 23, i → 11, n → 15, sum → 121}
⇒ while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 23, i → 11, n → 15, sum → 121}
⇒ sum := (sum+curr); curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 23, i → 11, n → 15, sum → 121}
⇒ skip; curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 23, i → 11, n → 15, sum → 144}
⇒ curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 23, i → 11, n → 15, sum → 144}
⇒ skip; i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 25, i → 11, n → 15, sum → 144}
⇒ i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 25, i → 11, n → 15, sum → 144}
⇒ skip; while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 25, i → 12, n → 15, sum → 144}
⇒ while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 25, i → 12, n → 15, sum → 144}
⇒ sum := (sum+curr); curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 25, i → 12, n → 15, sum → 144}
⇒ skip; curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 25, i → 12, n → 15, sum → 169}
⇒ curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 25, i → 12, n → 15, sum → 169}
⇒ skip; i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 27, i → 12, n → 15, sum → 169}
⇒ i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 27, i → 12, n → 15, sum → 169}
⇒ skip; while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 27, i → 13, n → 15, sum → 169}
⇒ while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 27, i → 13, n → 15, sum → 169}
⇒ sum := (sum+curr); curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 27, i → 13, n → 15, sum → 169}
⇒ skip; curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 27, i → 13, n → 15, sum → 196}
⇒ curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 27, i → 13, n → 15, sum → 196}
⇒ skip; i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 29, i → 13, n → 15, sum → 196}
⇒ i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 29, i → 13, n → 15, sum → 196}
⇒ skip; while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 29, i → 14, n → 15, sum → 196}
⇒ while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 29, i → 14, n → 15, sum → 196}
⇒ sum := (sum+curr); curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 29, i → 14, n → 15, sum → 196}
⇒ skip; curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 29, i → 14, n → 15, sum → 225}
⇒ curr := (curr+2); i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 29, i → 14, n → 15, sum → 225}
⇒ skip; i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 31, i → 14, n → 15, sum → 225}
⇒ i := (i+1); while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 31, i → 14, n → 15, sum → 225}
⇒ skip; while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 31, i → 15, n → 15, sum → 225}
⇒ while (i<n) do { sum := (sum+curr); curr := (curr+2); i := (i+1) }, {curr → 31, i → 15, n → 15, sum → 225}
⇒ skip, {curr → 31, i → 15, n → 15, sum → 225}'
}

@test "largest-of-three-numbers" {
  check 'num1 := 10 ; num2 := 20 ; num3 := 7 ; if num1 >= num2 then if num1 >= num3 then largest := num1 else largest := num3 else if num2 >= num3 then largest := num2 else largest := num3' '⇒ skip; num2 := 20; num3 := 7; if (num1>=num2) then { if (num1>=num3) then { largest := num1 } else { largest := num3 } } else { if (num2>=num3) then { largest := num2 } else { largest := num3 } }, {num1 → 10}
⇒ num2 := 20; num3 := 7; if (num1>=num2) then { if (num1>=num3) then { largest := num1 } else { largest := num3 } } else { if (num2>=num3) then { largest := num2 } else { largest := num3 } }, {num1 → 10}
⇒ skip; num3 := 7; if (num1>=num2) then { if (num1>=num3) then { largest := num1 } else { largest := num3 } } else { if (num2>=num3) then { largest := num2 } else { largest := num3 } }, {num1 → 10, num2 → 20}
⇒ num3 := 7; if (num1>=num2) then { if (num1>=num3) then { largest := num1 } else { largest := num3 } } else { if (num2>=num3) then { largest := num2 } else { largest := num3 } }, {num1 → 10, num2 → 20}
⇒ skip; if (num1>=num2) then { if (num1>=num3) then { largest := num1 } else { largest := num3 } } else { if (num2>=num3) then { largest := num2 } else { largest := num3 } }, {num1 → 10, num2 → 20, num3 → 7}
⇒ if (num1>=num2) then { if (num1>=num3) then { largest := num1 } else { largest := num3 } } else { if (num2>=num3) then { largest := num2 } else { largest := num3 } }, {num1 → 10, num2 → 20, num3 → 7}
⇒ if (num2>=num3) then { largest := num2 } else { largest := num3 }, {num1 → 10, num2 → 20, num3 → 7}
⇒ largest := num2, {num1 → 10, num2 → 20, num3 → 7}
⇒ skip, {largest → 20, num1 → 10, num2 → 20, num3 → 7}'
}
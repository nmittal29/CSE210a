datatype Exp = Const(val:int) | Var(string) | Plus(Exp, Exp) |  Mult(Exp, Exp)

function eval(e:Exp, store:map<string, int>):int
decreases e, store
{
	match(e)
		case Const(n) => n
		case Var(s) => if(s in store) then store[s] else -1
		case Plus(e1, e2) => eval(e1, store) + eval(e2, store)
		case Mult(e1, e2) => eval(e1, store) * eval(e2, store)
}

function optimize(e:Exp):Exp
decreases e
{
	match (e) 
	  case Mult(e1, e2) => if e1==Const(0) then Const(0) 
	                       else if e1==Const(1) then e2 
						   else if e2==Const(0) then Const(0)
						   else if e2==Const(1) then e1
						   else if e1.Const? && e2.Const? then Const(e1.val*e2.val)
						   else Mult(e1, e2)
	  case Plus(e1, e2) => if e1==Const(0) then e2
	                       else if e2==Const(0) then e1
						   else if e1.Const? && e2.Const? then Const(e1.val+e2.val)
						   else Plus(e1, e2)
	  case Const(n)     => Const(n)
	  case Var(s)       => Var(s)
}

method optimizeCorrect(e:Exp, s:map<string, int>)
 decreases e, s
ensures eval(e,s) == eval(optimize(e), s)
{
	match (e) {
		case Mult(e1, e2) => {
			if e1==Const(0) {
			assert eval(optimize(e), s)
			    == eval(optimize(Mult(e1, e2)), s)
				== eval(optimize(Mult(Const(0), e2)), s)
				== eval(Const(0), s)
				== 0
				== 0 * eval(e2, s)
				== eval(Const(0), s) * eval(e2, s)
				== eval(e1, s) * eval(e2, s)
				== eval(Mult(e1, e2), s)
				== eval(e, s);
			} else if e1==Const(1) {
				assert eval(optimize(e), s)
				    == eval(optimize(Mult(e1, e2)), s)
					== eval(optimize(Mult(Const(1), e2)), s)
					== eval(e2, s)
					== eval(e2, s) * 1
					== eval(e2, s) * eval(Const(1), s)
					== eval(e2, s) * eval(e1, s)
					== eval(e1, s) * eval(e2, s)
					== eval(e, s);
			} else if e2==Const(0) {
				assert eval(optimize(e), s)
				    == eval(optimize(Mult(e1, e2)), s)
					== eval(optimize(Mult(e1, Const(0))), s)
					== eval(Const(0), s)
					== 0
					== 0 * eval(e1, s)
					== eval(Const(0), s) * eval(e1, s)
					== eval(e1, s) * eval(e2, s)
					== eval(e, s);
			} else if e2==Const(1) {
				assert eval(optimize(e), s)
				    == eval(optimize(Mult(e1, e2)), s)
					== eval(optimize(Mult(e1, Const(1))), s)
					== eval(e1, s)
					== eval(e1, s) * 1
					== eval(e1, s) * eval(Const(1), s)
					== eval(e1, s) * eval(e2, s)
					== eval(e, s);
			} else if e1.Const? && e2.Const? {
				assert eval(optimize(e), s)
				    == eval(Const(e1.val*e2.val), s)
					== e1.val * e2.val
					== eval(e1, s) * eval(e2, s)
					== eval(Mult(e1, e2), s)
					== eval(e, s);
			} else {
				assert eval(optimize(e), s)
				    == eval(optimize(Mult(e1, e2)), s)
					== eval(Mult(e1, e2), s)
					== eval(e, s);
			}
		}
		case Plus(e1, e2) => {
			if e1==Const(0) {
				assert eval(optimize(e), s)
				    == eval(optimize(Plus(e1, e2)), s)
					== eval(optimize(Plus(Const(0), e2)), s)
					== eval(e2, s)
					== eval(e2, s) + 0
					== eval(e2, s) + eval(Const(0), s)
					== eval(e2, s) + eval(e1, s)
					== eval(e1, s) + eval(e2, s)
					== eval(e, s);
			} else if e2==Const(0) {
				assert eval(optimize(e), s)
				    == eval(optimize(Plus(e1, e2)), s)
					== eval(optimize(Plus(e1, Const(0))), s)
					== eval(e1, s)
					== eval(e1, s) + 0
					== eval(e1, s) + eval(Const(0), s)
					== eval(e1, s) + eval(e2, s)
					== eval(e, s);
			} else if e1.Const? && e2.Const? {
				assert eval(optimize(e), s)
				    == eval(Const(e1.val+e2.val), s)
					== e1.val + e2.val
					== eval(e1, s) + eval(e2, s)
					== eval(Plus(e1, e2), s)
					== eval(e, s);
			} else {
				assert eval(optimize(e), s)
				    == eval(optimize(Plus(e1, e2)), s)
					== eval(Plus(e1, e2), s)
					== eval(e, s);
			}
		}
		case Const(n) => {
			assert eval(optimize(e), s)
			    == eval(optimize(Const(n)), s)
				== eval(Const(n), s)
				== eval(e, s);
		}
		case Var(a) => {
			assert eval(optimize(e), s)
			    == eval(optimize(Var(a)), s)
				== eval(Var(a), s)
				== eval(e, s);
		}
	}
}

method optimizeFeatures()
{
	assert( optimize(Mult(Var("x"), Const(0))) == Const(0) );
	assert( optimize(Mult(Var("x"), Const(1))) == Var("x") );
	assert( optimize(Mult(Const(0), Var("x"))) == Const(0) );
	assert( optimize(Mult(Const(1), Var("x"))) == Var("x") );

	assert( optimize(Plus(Const(0), Var("x"))) == Var("x") );
	assert( optimize(Plus(Var("x"), Const(0))) == Var("x") );

	assert( optimize(Plus(Const(3), Const(4))) == Const(7) );
	assert( optimize(Mult(Const(3),Const(4))) == Const(12) );
	
	assert( optimize(Plus(Plus(Var("x"), Var("y")), Const(0))) == Plus(Var("x"), Var("y")) );
	
}
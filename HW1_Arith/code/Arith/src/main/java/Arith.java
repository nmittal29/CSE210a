import java.util.Arrays;
import java.util.List;

abstract class Expr {

  abstract int value();
}

class IntegerExpr extends BinaryExpr {

  int numericVal;

  public IntegerExpr(int numericVal) {
    this.numericVal = numericVal;
  }

  @Override
  int value() {
    return numericVal;
  }
}

abstract class BinaryExpr extends Expr {

  BinaryExpr e1, e2;

  void check() {
    if (e1 == null || e2 == null) {
      throw new UnEvaluatableExpression();
    }
  }
}

class SumExpr extends BinaryExpr {

  @Override
  int value() {
    check();
    return e1.value() + e2.value();
  }
}

class MultiplyExpr extends BinaryExpr {

  @Override
  int value() {
    check();
    return e1.value() * e2.value();
  }
}

class SubtractExpr extends BinaryExpr {

  @Override
  int value() {
    check();
    return e1.value() - e2.value();
  }
}

class DivideExpr extends BinaryExpr {

  @Override
  void check() {
    super.check();
    if (e2.value() == 0) {
      throw new DivideByZeroException();
    }
  }

  @Override
  int value() {
    this.check();
    return e1.value() / e2.value();
  }
}

class UnEvaluatableExpression extends RuntimeException {

}

class DivideByZeroException extends RuntimeException {

}

class AST {

  private BinaryExpr root;

  public int eval() {
    return root.value();
  }

  public void build(List<String> preFixList) {
    if(preFixList == null || preFixList.size() == 0)
      throw new UnEvaluatableExpression();
    String operator = preFixList.get(0);
    root = getOpExpr(operator);
    int index = 1;
    index = buildTreeRecursive(root, preFixList, index, true);
    buildTreeRecursive(root, preFixList, index, false);
  }

  /**
   * The rest of these functions are to build the AST for an expression.
   */
  private BinaryExpr getExp(String exp) {
    try {
      return new IntegerExpr(Integer.decode(exp));
    } catch (NumberFormatException e) {
      return getOpExpr(exp);
    }
  }

  private BinaryExpr getOpExpr(String exp) {
    if (exp.equals("+")) {
      return new SumExpr();
    } else if (exp.equals("*")) {
      return new MultiplyExpr();
    } else if (exp.equals("-")) {
      return new SubtractExpr();
    } else if (exp.equals("/")) {
      return new DivideExpr();
    }
    throw new UnEvaluatableExpression();
  }

  private boolean isInteger(String exp) {
    try {
      Integer.decode(exp);
      return true;
    } catch (NumberFormatException e) {
      return false;
    }
  }

  private int buildTreeRecursive(
      BinaryExpr expr,
      List<String> preFixList,
      int index,
      boolean isLeft
  ) {
    if (preFixList.size() - 1 >= index) {
      String exp = preFixList.get(index);
      BinaryExpr e;
      boolean isInt = false;

      isInt = isInteger(exp);

      if (isLeft) {
        expr.e1 = getExp(exp);
        e = expr.e1;
      } else {
        expr.e2 = getExp(exp);
        e = expr.e2;
      }
      if (isInt) {
        return index + 1;
      } else {
        int n = buildTreeRecursive(e, preFixList, index + 1, true);
        return buildTreeRecursive(e, preFixList, n, false);
      }
    }
    return index;
  }
}

public class Arith {

  public static int result = 0;

  public static void main(String[] args) {
    //System.out.println("Args: " + Arrays.asList(args));
    if (args.length == 0) {
      System.exit(1);
    }
    AST ast = new AST();
    ast.build(ArithUtils.infixToPrefix(String.join(" ", args)));
    result = ast.eval();
    System.out.println(result);

  }
}
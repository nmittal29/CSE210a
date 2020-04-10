import java.util.Arrays;
import java.util.List;
import java.util.Stack;

public class ArithUtils {

  public static int getPrecedence(char operator) {
    if (operator == '*' || operator == '/') {
      return 2;
    } else if (operator == '+' || operator == '+') {
      return 1;
    }
    return 0;
  }

  public static List<String> infixToPrefix(String s) {
    String str = s.trim();
    Stack<String> expr = new Stack<>();
    Stack<Character> operator = new Stack<>();
    int i = 0;

    while (i < str.length()) {
      char ch = str.charAt(i);
      if (ch == ' ') {
        int j = i + 1;
        while (j < str.length() && str.charAt(j) == ' ') {
          j++;
        }
        i = j;
      } else if (Character.isDigit(ch)) {
        int j = i + 1;
        String digit = "" + ch;
        while(j < str.length() && Character.isDigit(str.charAt(j))){
          digit += str.charAt(j);
          j++;
        }
        expr.push(digit);
        i = j;
      } else if (ch == '-' && (i + 1) < str.length() && Character.isDigit(str.charAt(i + 1))) {
        String digit = "" + str.charAt(i + 1);
        int j = i + 2;
        while(j < str.length() && Character.isDigit(str.charAt(j))){
          digit += str.charAt(j);
          j++;
        }
        expr.push("-" + digit);
        i = j;
      } else if (ch == '*' || ch == '/' || ch == '+' || ch == '-') {
        if (operator.isEmpty() || getPrecedence(operator.peek()) <= getPrecedence(ch)) {
          operator.push(ch);
          i++;
        } else {
          while (!operator.isEmpty() && getPrecedence(operator.peek()) > getPrecedence(ch)) {
            String operand1 = expr.pop();
            if(expr.isEmpty())
              throw new UnEvaluatableExpression();
            String operand2 = expr.pop();
            char binaryOperator = operator.pop();
            String newExpr = binaryOperator + " " + operand2 + " " + operand1;
            expr.push(newExpr);
          }
          operator.push(ch);
          i++;
        }

      }
    }

    while (!operator.isEmpty()) {
      if(expr.isEmpty())
        throw new UnEvaluatableExpression();
      String operand1 = expr.pop();
      if(expr.isEmpty())
        throw new UnEvaluatableExpression();
      String operand2 = expr.pop();
      char binaryOperator = operator.pop();
      String newExpr = binaryOperator + " " + operand2 + " " + operand1;
      expr.push(newExpr);
    }

    String prefix = expr.pop();
    String[] prefixList = prefix.split(" ");
    return Arrays.asList(prefixList);
  }

  public static void main(String[] args) {
    String expression = "100 + -100 * 0";
    System.out.println(ArithUtils.infixToPrefix(expression));
  }
}


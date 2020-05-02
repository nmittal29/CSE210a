#!/usr/bin/python3
# coding=utf-8

import enum
from typing import Tuple
import ply.lex as lex
import ply.yacc as yacc

STEPS_AS_DIVERGENCE = 10000

def indent(s):
    return str(s).replace('\n', '\n\t')


class WhileASTVar(object):
    desc = 'assignable variable'
    _val = None
    _id = None

    def __init__(self, var_id, val):
        self._id = var_id
        self._val = val

    def eval(self):
        return self._val

    def assign(self, val):
        self._val = val


class WhileASTState(object):
    desc = 'State of a program'

    def __init__(self, vars=dict()):
        self.state_dict = {}
        for var_id, value in vars.items():
            self.assign_var(var_id, value)

    def eval_var(self, var_id):
        for var,val in self.state_dict.items():
            if var_id == str(var):
                return val.eval()
        else:
            return 0

    def assign_var(self, var_id, val):
        '''flag = False
        for var, val in self.state_dict.items():
            if var_id.var_id == var.var_id:
                flag = True
                break
        '''

        if var_id.var_id not in self.state_dict:
            self.state_dict[var_id.var_id] = WhileASTVar(var_id.var_id, val)
        else:
            variable = self.state_dict[var_id.var_id]
            variable.assign(val)
            #print(self.state_dict)

    def reveal(self):
        for var_id, var in self.state_dict.items():
            print("var_id: %2s, type: %4s, value: %4s" % (var_id, var.type(), str(var.eval())))

    def __str__(self):

        return '{%s}' % (', '.join(('%s → %s' % (var_id, str(var.eval())) for var_id, var in sorted(self.state_dict.items()))))


class WhileASTTypeLit(object):
    desc = 'Abstract Class for integer and boolean type'

    def value(self):
        raise NotImplementedError


class WhileASTExp(object):
    desc = 'Abstract Class for WHILE AST Expression'

    def eval(self, state):
        raise NotImplementedError

    def __str__(self):
        raise NotImplementedError


class WhileASTAExp(WhileASTExp):
    def __init__(self, op, exp1, exp2):
        self.exp1 = exp1
        self.exp2 = exp2
        self.op = op

    def eval(self, state):
        if self.op == '+':
            return self.exp1.eval(state)[0] + self.exp2.eval(state)[0], state
        elif self.op == '-':
            return self.exp1.eval(state)[0] - self.exp2.eval(state)[0], state
        elif self.op == '*':
            return self.exp1.eval(state)[0] * self.exp2.eval(state)[0], state
        elif self.op == '/':
            return self.exp1.eval(state)[0] / self.exp2.eval(state)[0], state
        elif self.op == '=':
            return self.exp1.eval(state)[0] == self.exp2.eval(state)[0], state
        elif self.op == '<':
            return self.exp1.eval(state)[0] < self.exp2.eval(state)[0], state
        elif self.op == '∨':
            return self.exp1.eval(state)[0] or self.exp2.eval(state)[0], state
        elif self.op == '∧':
            return self.exp1.eval(state)[0] and self.exp2.eval(state)[0], state
        elif self.op == '>':
            return self.exp1.eval(state)[0] > self.exp2.eval(state)[0], state
        elif self.op == "<=":
            return self.exp1.eval(state)[0] <= self.exp2.eval(state)[0], state
        elif self.op == ">=":
            return self.exp1.eval(state)[0] >= self.exp2.eval(state)[0], state
        elif self.op == "¬=":
            return self.exp1.eval(state)[0] != self.exp2.eval(state)[0], state

    def __str__(self):
        if self.op == '+':
            return '(%s+%s)' % (self.exp1, self.exp2)
        elif self.op == '-':
            return '(%s-%s)' % (self.exp1, self.exp2)
        elif self.op == '*':
            return '(%s*%s)' % (self.exp1, self.exp2)
        elif self.op == '/':
            return '(%s/%s)' % (self.exp1, self.exp2)
        elif self.op == '=':
            return '(%s=%s)' % (self.exp1, self.exp2)
        elif self.op == '<':
            return '(%s<%s)' % (self.exp1, self.exp2)
        elif self.op == '∨':
            return '(%s∨%s)' % (self.exp1, self.exp2)
        elif self.op == '∧':
            return '(%s∧%s)' % (self.exp1, self.exp2)
        elif self.op == '>':
            return '(%s>%s)' % (self.exp1, self.exp2)
        elif self.op == "<=":
            return '(%s<=%s)' % (self.exp1, self.exp2)
        elif self.op == ">=":
            return '(%s>=%s)' % (self.exp1, self.exp2)
        elif self.op == "¬=":
            return '(%s¬=%s)' % (self.exp1, self.exp2)


class WhileASTAExpIntLit(object):
    desc = 'Aexp for integer literal'

    def __init__(self, n):
        self.int_value = int(n)

    def eval(self,state):
        return self.int_value, state

    def __str__(self):
        return str(self.int_value)


class WhileASTAExpVar(object):
    desc = 'Aexp for integer variable'

    def __init__(self, var_id):
        self.var_id = var_id

    def eval(self, state):
        """
        :param state: WhileASTState
        :return:
        """
        return state.eval_var(self.var_id), state

    def __str__(self):
        return self.var_id

class WhileASTBExpVar(object):
    desc = 'Bexp for bool variable'

    def __init__(self, var_id):
        self.var_id = var_id

    def eval(self, state):
        """
        :param state: WhileASTState
        :return:
        """
        return state.eval_var(self.var_id), state

    def __str__(self):
        return self.var_id


class WhileASTBExpBoolLit(object):
    desc = 'Bexp for boolean literal'

    def __init__(self, boolean):
        if boolean == 'true':
            self.bool_value = True
        else:
            self.bool_value = False

    def eval(self, state):
        return self.bool_value, state

    def __str__(self):
        return 'true' if self.bool_value else 'false'


class WhileASTBExpNot(object):
    desc = 'Bexp for logical not'

    def __init__(self, exp):
        self.exp = exp

    def eval(self, state):
        """
        :param state: WhileASTState
        :return:
        """
        return not self.exp.eval(state)[0], state

    def __str__(self):
        return '¬%s' % self.exp

class WhileASTComm(object):
    class CommType(enum.Enum):
        NotImplemented = 0
        Skip = 1
        Assign = 2
        Sequence = 3
        IfStatement = 4
        IfElseStatement = 5
        WhileStatement = 6
        EmptyBlock = 7

    comm_type = CommType.NotImplemented

    def exec(self, state: WhileASTState) -> WhileASTState:
        raise NotImplementedError

    def exec_small(self, state: WhileASTState):
        raise NotImplementedError

    def __str__(self):
        raise NotImplementedError


class WhileASTCommSkip(WhileASTComm):
    comm_type = WhileASTComm.CommType.Skip

    def exec(self, state):
        return state

    def exec_small(self, state: WhileASTState) -> Tuple[WhileASTComm, WhileASTState]:
        raise NotImplementedError("Should never execute skip command in small step.")

    def __str__(self):
        return 'skip'

class WhileASTCommEmptyBlock(WhileASTComm):
    comm_type = WhileASTComm.CommType.EmptyBlock

    def exec(self, state):
        return state

    def exec_small(self, state: WhileASTState) -> Tuple[WhileASTComm, WhileASTState]:
        raise NotImplementedError("Should never execute empty block in small step.")

    def __str__(self):
        return ''


class WhileASTCommAssign(WhileASTComm):
    comm_type = WhileASTComm.CommType.Assign
    var_id = None
    exp = None

    def __init__(self, var_id, exp):
        self.var_id = var_id
        self.exp = exp

    def exec(self, state):
        value = self.exp.eval(state)[0]
        state.assign_var(self.var_id, value)
        return state

    def exec_small(self, state: WhileASTState) -> Tuple[WhileASTComm, WhileASTState]:
        return WhileASTCommSkip(), self.exec(state)

    def __str__(self):
        return '%s := %s' % (self.var_id, self.exp)


class WhileASTCommSeq(WhileASTComm):
    comm_type = WhileASTComm.CommType.Sequence
    comm_A: WhileASTComm = None
    comm_B: WhileASTComm = None

    def __init__(self, comm_a: WhileASTComm, comm_b: WhileASTComm):
        self.comm_A = comm_a
        self.comm_B = comm_b

    def exec(self, state):
        state_prime = self.comm_A.exec(state)
        return self.comm_B.exec(state_prime)

    def exec_small(self, state: WhileASTState) -> Tuple[WhileASTComm, WhileASTState]:
        if not self.comm_A.comm_type == WhileASTComm.CommType.Skip:  # seq-rule 1
            comm_A_prime, state_prime =  self.comm_A.exec_small(state)
            return WhileASTCommSeq(comm_A_prime, self.comm_B), state_prime
        else:  # seq-rule 2
            return self.comm_B, state

    def __str__(self):
        return '%s; %s' % (self.comm_A, self.comm_B)


# if b then c1 for c1 ∈ Comm and b∈Bexp
class WhileASTCommIf(WhileASTComm):
    comm_type = WhileASTComm.CommType.IfStatement
    bool_b = None
    comm_1 = None

    def __init__(self, b, c1):
        self.bool_b = b
        self.comm_1 = c1

    def exec(self, state):
        if self.bool_b.eval(state)[0]:
            return self.comm_1.exec(state)
        else:
            return state

    def exec_small(self, state: WhileASTState) -> Tuple[WhileASTComm, WhileASTState]:
        if self.bool_b.eval(state)[0]:  # if-true rule
            return self.comm_1, state
        else:  # if-false rule
            return WhileASTCommSkip(), state

    # def __str__(self):
    #     return 'if (%s) %s else %s' % (self.bool_b, self.comm_1, self.comm_2)

    def __str__(self):
        return 'if %s then { %s }' % (self.bool_b, indent(self.comm_1))

class WhileASTCommIfElse(WhileASTComm):
    comm_type = WhileASTComm.CommType.IfElseStatement
    bool_b = None
    comm_1 = None
    comm_2 = None

    def __init__(self, b, c1, c2):
        self.bool_b = b
        self.comm_1 = c1
        self.comm_2 = c2

    def exec(self, state):
        if self.bool_b.eval(state)[0]:
            return self.comm_1.exec(state)
        else:
            return self.comm_2.exec(state)

    def exec_small(self, state: WhileASTState) -> Tuple[WhileASTComm, WhileASTState]:
        if self.bool_b.eval(state)[0]:  # if-true rule
            return self.comm_1, state
        else:  # if-false rule
            return self.comm_2, state

    # def __str__(self):
    #   return 'if (%s) %s else %s' % (self.bool_b, self.comm_1, self.comm_2)

    def __str__(self):
        return 'if %s then { %s } else { %s }' % (self.bool_b, self.comm_1, self.comm_2)


# while b do c for c ∈ Comm and b ∈ Bexp
class WhileASTCommWhile(WhileASTComm):
    comm_type = WhileASTComm.CommType.WhileStatement
    bool_b = None
    body_comm = None

    def __init__(self, b: WhileASTAExp, comm: WhileASTComm):
        self.bool_b = b
        self.body_comm = comm

    def exec(self, state):
        condition = self.bool_b.eval(state)[0]
        if condition:
            next_s = self.body_comm.exec(state)
            return self.exec(next_s)
        else:
            return state

    def exec_small(self, state: WhileASTState) -> Tuple[WhileASTComm, WhileASTState]:
        condition = self.bool_b.eval(state)[0]
        if not condition:  # while-false rule
            return WhileASTCommSkip(), state
        else:  # while-true rule
            return WhileASTCommSeq(self.body_comm, self), state

    # def __str__(self):
    #     return 'while (%s) %s' % (self.bool_b, self.body_comm)

    def __str__(self):
        return 'while %s do { %s }' % (self.bool_b, indent(self.body_comm))

'''class WhileASTCommComposite(WhileASTComm):
    def __init__(self, *commands):
        self.command_list = commands

    def exec(self, state):
        state_prime = state
        for command in self.command_list:
            state_prime = command.exec(state_prime)
        return state_prime

    def exec_small(self, state: WhileASTState) -> Tuple[WhileASTComm, WhileASTState]:
        state_prime = state
        command_tuple = ()
        for command in self.command_list:
            if not command.comm_type == WhileASTComm.CommType.Skip:
                command_prime, state_prime = command.exec_small(state_prime)
                command_tuple = WhileASTCommComposite(command_prime), state_prime
'''

def run_small(program: WhileASTComm, state: WhileASTState):
    step = 0
    comm = program
    while True:
        if step > STEPS_AS_DIVERGENCE:
            #print("Stop running after %d steps." % STEPS_AS_DIVERGENCE)
            #print("Program seems like diverging.")
            break
        if step > 0:
            #print("Step %d:" % step)
            print_str = str()
            print_str = print_str + '⇒ ' + str(comm) + ', ' + str(state)
            print(print_str)
            #print("State:", state)
        if not comm.comm_type == WhileASTComm.CommType.Skip:  # not the terminating skip command
            comm, state = comm.exec_small(state)
        else:  # the terminating skip command
            #print("Program terminated.")
            break
        step += 1
        #print()

reserved = {
    'if' : 'IF',
    'else' : 'ELSE',
    'while' : 'WHILE',
    'true' : 'TRUE',
    'false' : 'FALSE',
    'then' : 'THEN',
    'skip': 'SKIP',
    'do' : 'DO'
}

tokens = [
             'LPAREN', 'RPAREN',
             'NUMBER',
             'PLUS', 'MINUS', 'MULTIPLY', 'DIVIDE',
             'SEMICOLON',
             'LESS_THAN', 'LESS_THAN_EQUAL', 'EQUAL', 'NOT_EQUAL', 'GREATER_THAN', 'GREATER_THAN_EQUAL',
             'LCURLY', 'RCURLY',
             'ASSIGN', 'ID',
             'NOT', 'AND', 'OR'
         ] + list(reserved.values())

t_LPAREN = r'\('
t_RPAREN = r'\)'
t_PLUS = r'\+'
t_MINUS = r'-'
t_MULTIPLY = r'\*'
t_DIVIDE = r'/'
t_SEMICOLON = r';'
t_LESS_THAN = r'<'
t_LESS_THAN_EQUAL = r'<='
t_EQUAL = r'='
t_NOT_EQUAL = r'\¬='
t_GREATER_THAN = r'>'
t_GREATER_THAN_EQUAL = r'>='
t_LCURLY = r'{'
t_RCURLY = r'}'
t_ASSIGN = r':='
t_NOT = r'\¬'
t_AND = r'\∧'
t_OR = r'\∨'

def t_ID(t):
    r'[a-zA-Z_][a-zA-Z_0-9]*'
    t.type = reserved.get(t.value, 'ID')    # Check for reserved words
    if t.type == 'ID':
        t.value = WhileASTAExpVar(t.value)
    return t

def t_NUMBER(t):
    #r'(-?\d*(\d\.|\.\d)\d* | \d+)'
    r'(-?\d * (\d\.| \.\d)\d * | \d +)'
    try:
        t.value = WhileASTAExpIntLit(t.value)
    except ValueError:
        print("Integer value too large %d", t.value)
        t.value = 0
    return t

t_ignore = " \t\n"


def t_error(t):
    raise MySyntaxError(Exception)


lexer = lex.lex(debug=0)

# Parsing rules
precedence = (
    ('left', 'OR'),
    ('left', 'AND'),
    ('left', 'NOT'),
    ('left', 'LESS_THAN', 'LESS_THAN_EQUAL', 'EQUAL', 'NOT_EQUAL', 'GREATER_THAN', 'GREATER_THAN_EQUAL'),
    ('left', 'PLUS', 'MINUS'),
    ('left', 'MULTIPLY', 'DIVIDE'),
    ('left', 'LPAREN', 'RPAREN'),
)

def p_command_1(t):
    '''
    command : SKIP
    '''
    t[0] = WhileASTCommSkip()

def p_command_10(t):
    '''
    command : LCURLY command  RCURLY
    '''
    t[0] = t[2]


def p_command_7(t):
    '''
    command : LCURLY command SEMICOLON command RCURLY
    '''
    t[0] = WhileASTCommSeq(t[2],t[4])

def p_command_2(t):
    '''
    command : command SEMICOLON command
    '''
    t[0] = WhileASTCommSeq(t[1],t[3])

def p_command_11(t):
    '''
    command : WHILE expression DO ID ASSIGN expression SEMICOLON command
    '''
    t[0] = WhileASTCommSeq(WhileASTCommWhile(t[2], WhileASTCommAssign(t[4], t[6])), t[8])

def p_command_8(t):
    '''
    command : LCURLY RCURLY
    '''
    t[0] = WhileASTCommEmptyBlock()

def p_command_3(t):
    '''
    command : IF expression THEN command
    '''
    t[0] = WhileASTCommIf(t[2], t[4])

def p_command_4(t):
    '''
    command : IF expression THEN command ELSE command
    '''
    t[0] = WhileASTCommIfElse(t[2], t[4], t[6])


def p_expression_parenthesized_expression(t):
    '''
    expression : LPAREN expression RPAREN
    '''
    t[0] = t[2]

def p_command_5(t):
    '''
    command : ID ASSIGN expression
    '''
    t[0] = WhileASTCommAssign(t[1],t[3])


def p_command_9(t):
    '''
    command : WHILE expression DO LCURLY command RCURLY
    '''
    t[0] = WhileASTCommWhile(t[2],t[5])

def p_command_6(t):
    '''
    command : WHILE expression DO command
    '''
    t[0] = WhileASTCommWhile(t[2],t[4])


def p_expression_unary(t):
    '''
    expression : MINUS expression
               | PLUS expression
    '''

    t[0] = WhileASTAExpIntLit(str('-' + str(t[2])))

def p_expression_binop(t):

    '''
    expression : expression PLUS expression
                  | expression MINUS expression
                  | expression MULTIPLY expression
                  | expression DIVIDE expression
                  | expression LESS_THAN expression
                  | expression LESS_THAN_EQUAL expression
                  | expression EQUAL expression
                  | expression NOT_EQUAL expression
                  | expression GREATER_THAN expression
                  | expression GREATER_THAN_EQUAL expression
                  | expression AND expression
                  | expression OR expression
    '''
    t[0] = WhileASTAExp(t[2], t[1], t[3])


def p_expression_logical_operator(t):
    '''
    expression : NOT expression
    '''
    t[0] = WhileASTBExpNot(t[2])

def p_expression_factor(t):
    '''
    expression : factor
    '''
    t[0] = t[1]


def p_factor_number(t):
    '''
    factor : NUMBER
    '''
    t[0] = t[1]

def p_boolean(t):
    '''
    expression : TRUE
                  | FALSE
    '''
    t[0] = WhileASTBExpBoolLit(t[1])

def p_ID(t):
    '''
    expression : ID
    '''
    t[0] = t[1]


def p_error(t):
    raise MySyntaxError(Exception)


parser = yacc.yacc(debug=0)


import sys

class MySyntaxError(Exception):
    pass


class MySemanticError(Exception):
    pass

try:
    data = sys.argv[1]
    lex.input(data)
    #print(data)
    while True:
        token = lex.token()
        if not token: break
        #print(token)
    root = yacc.parse(data)
    run_small(root, WhileASTState({}))
except MySyntaxError:
    print("SYNTAX ERROR")
except MySemanticError:
    print("SEMANTIC ERROR")

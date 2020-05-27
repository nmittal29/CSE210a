datatype Tree<T> = Leaf | Node(Tree<T>, Tree<T>, T)
datatype List<T> = Nil | Cons(T, List<T>)

function flatten<T>(tree:Tree<T>):List<T>
decreases tree
ensures tree==Leaf ==> flatten(tree)==Nil
{
  match tree
  case Leaf                  => Nil
  case Node (left, right, m) => append(Cons(m, flatten(left)), flatten(right)) 
}

function append<T>(xs:List<T>, ys:List<T>):List<T>
decreases xs, ys
ensures xs==Nil ==> append(xs, ys)==ys
ensures ys == Nil ==> append(xs, ys)==xs
{
  match xs
  case  Nil => ys
  case Cons(x, xs') => Cons(x, append(xs', ys))
}

function treeContains<T>(tree:Tree<T>, element:T):bool
decreases tree
{
  match tree
  case  Leaf => false
  case  Node (left, right, m) => m==element || treeContains(left, element) || treeContains(right, element)
}

function listContains<T>(xs:List<T>, element:T):bool
decreases xs
{
  match xs
  case  Nil => false
  case  Cons(x, xs') => x == element || listContains(xs', element)
}

lemma {:induction xs, ys} memberOfAppendOnList<T>(xs:List<T>, ys:List<T>, element:T)
decreases xs, ys
ensures listContains(xs, element) || listContains(ys, element) <==> listContains(append(xs, ys), element)
{
  match (xs) {
    case Nil => {}
    case Cons(x, xs') => {
      memberOfAppendOnList(xs', ys, element);
      assert listContains(append(xs, ys), element)
          == listContains(append(Cons(x, xs'), ys), element)
          == listContains(Cons(x, append(xs', ys)), element)
          == (x == element || listContains(append(xs', ys), element))
          == (x == element || listContains(xs', element) || listContains(ys, element))
          == listContains(xs, element) || listContains(ys, element);
    }
  }
}

lemma {:induction tree} sameElements<T>(tree:Tree<T>, element:T)
decreases tree
ensures treeContains(tree, element) <==> listContains(flatten(tree), element)
{
  match (tree) {
    case Leaf => {}
    case Node(left, right, m) => {
      sameElements(left, element);
      sameElements(right, element);
      assert treeContains(tree, element)
          == treeContains(Node(left, right, m), element)
          == (m == element || treeContains(left, element) || treeContains(right, element))
          == (m == element || listContains(flatten(left), element) || listContains(flatten(right), element))
          == (listContains(Cons(m, flatten(left)), element) || listContains(flatten(right), element));

          memberOfAppendOnList(Cons(m, flatten(left)), flatten(right), element);

      assert (listContains(Cons(m, flatten(left)), element) || listContains(flatten(right), element))
          == listContains(append(Cons(m, flatten(left)), flatten(right)), element)
          == listContains(flatten(tree), element);
    }
  }
}

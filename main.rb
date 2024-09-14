require_relative("lib/node.rb")
require_relative("lib/tree.rb")

pre_tree = [1,3,6,9,12,15,18,21]

bst = Tree.new

bst.build_tree(bst.sac(pre_tree))

#bst.pretty_print
bst.insert(17)
#bst.pretty_print
#bst.delete(15)

#bst.pretty_print
second_tree = Tree.new
#pre_tree_2 = second_tree.sort_and_compact([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])


#second_tree.build_tree(second_tree.sac([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

#second_tree.pretty_print

alphabetree = Tree.new

alphabetree.build_tree(alphabetree.sac(['Luna', 'Lucy', 'Odin', 'Alex', 'Andrew']))

#alphabetree.pretty_print

alphabetree.insert('Glaurung')
alphabetree.insert('Adam')
alphabetree.insert("Kelly")
alphabetree.insert("Norma")
alphabetree.insert("Steve")
alphabetree.insert("Anders")
alphabetree.pretty_print
puts "\n"

#alphabetree.delete("Glaurung")
#alphabetree.delete("Lucy")
#alphabetree.delete("Norma")
#alphabetree.delete("Alex")

alphabetree.level_order


require_relative("lib/node.rb")
require_relative("lib/tree.rb")


# alphabetree = Tree.new

# alphabetree.build_tree(alphabetree.sac(['Luna', 'Lucy', 'Odin', 'Alex', 'Andrew']))

# #alphabetree.pretty_print

# alphabetree.insert('Glaurung')
# alphabetree.insert('Adam')
# alphabetree.insert("Kelly")
# alphabetree.insert("Norma")
# alphabetree.insert("Steve")
# alphabetree.insert("Anders")
# alphabetree.insert("Anderson")
# alphabetree.insert("Aldis")
# alphabetree.insert("Amy")
# alphabetree.insert("Amber")
# #alphabetree.pretty_print

# #alphabetree.delete("Glaurung")
# #alphabetree.delete("Lucy")
# #alphabetree.delete("Norma")
# #alphabetree.delete("Alex")
# #puts "level order #{alphabetree.level_order}"
# name_array= []
# cool_array = []
# lame_arr = []
#alphabetree.level_order do |node|
    #full_name = node.concat(" Barnard")
    #name_array << full_name
#end
#puts "#{name_array}"
#puts "pre order #{alphabetree.preorder}"
# alphabetree.preorder do |node|
#     full_name = node.concat(" Barnard")
#     name_array << full_name
# end
# puts "pre : #{name_array}"

#puts "in order #{alphabetree.inorder}"
# alphabetree.inorder do |node|
#     full_name = node.concat(" is cool")
#     cool_array << full_name
# end
# puts "in : #{cool_array}"
#puts "post order #{alphabetree.postorder}"
#alphabetree.postorder do |node|
    #full_name = node.concat(" NOT")
    #lame_arr << full_name
#end
#puts "post : #{lame_arr}"

#puts alphabetree.height("Alex"), alphabetree.height("Luna"), alphabetree.height("Anders")

#puts alphabetree.depth("Kelly")

#puts alphabetree.balanced?
#alphabetree.rebalance
#alphabetree.pretty_print

random_bst= Tree.new
random_bst.build_tree(random_bst.sac(Array.new(15){rand(1..100)}))
#random_bst.pretty_print
puts random_bst.balanced?
puts "level order#{random_bst.level_order}"
puts "pre order #{random_bst.preorder}"
puts "in order #{random_bst.inorder}"
puts "post order #{random_bst.postorder}"

for i in 1..3  
    i = rand(100..900)
    random_bst.insert(i)
end
for i in 1..3
    i = rand(0-9)
    random_bst.insert(i)
end


#random_bst.pretty_print
puts random_bst.balanced?
random_bst.rebalance
puts random_bst.balanced?
puts "level order#{random_bst.level_order}"
puts "pre order #{random_bst.preorder}"
puts "in order #{random_bst.inorder}"
puts "post order #{random_bst.postorder}"
#random_bst.pretty_print

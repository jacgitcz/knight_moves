# Knight Moves

Odin Project : Ruby Programming : Data Structures

The #knight_moves function attempts to find the shortest path from a given start position to a given target position

The program builds a tree with the start position as root until a child is added with the required target position. It then traces the path back from the child to the root using the parent links.

The #add_children function checks for the target position as well as adding children to a node.  It also adds children to a visited list to avoid cycles, and only adds unvisited positions as children.

The #build_tree function uses a queue to ensure breadth-first search.  Using BFS guarantees that the search will terminate (DFS without eliminating visited squares could run forever), and also that it will find the shortest path (which translates to the minimum number of tree levels).  DFS will find a path, but it isn't guaranteed to be the shortest.

Class Knight has a method #valid_moves, which returns all the reachable legal positions from a given start.

There is no explicit implementation of the board  - it is implicit in the boundary checks.  It might be cleaner to define the board limits using constants, say BOARD_MIN and BOARD_MAX


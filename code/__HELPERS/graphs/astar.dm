// todo: DO NOT FUCKING USE THIS
// it is *EXTREMELY* inefficient, and scales up quadratically in time complexity
// DO NOT USE THIS UNTIL IT IS REWRITTEN
// notably that "bad node trimming" is actually horrifying.

/**
 * A Star pathfinding algorithm
 *
 * This file's AStar should not be used generally; it's the generic graph search algorithm, as opposed
 * to the optimized turf-grid-only search algorithm.
 *
 * Returns a list of tiles forming a path from A to B, taking dense objects as well as walls, and the orientation of
 * windows along the route into account.
 *
 *
 * Use:
 * your_list = AStar(start location, end location, adjacent turf proc, distance proc)
 * For the adjacent turf proc i wrote:
 * /turf/proc/AdjacentTurfs
 * And for the distance one i wrote:
 * /turf/proc/Distance
 *
 * So an example use might be:
 *
 * src.path_list = AStar(src.loc, target.loc, TYPE_PROC_REF(/turf, AdjacentTurfs), TYPE_PROC_REF(/turf, Distance))
 *
 * Note: The path is returned starting at the END node, so i wrote reverselist to reverse it for ease of use.
 *
 * src.path_list = reverselist(src.pathlist)
 *
 * Then to start on the path, all you need to do it:
 * Step_to(src, src.path_list[1])
 * src.path_list -= src.path_list[1] or equivilent to remove that node from the list.
 *
 * Optional extras to add on (in order):
 * MaxNodes: The maximum number of nodes the returned path can be (0 = infinite)
 * Maxnodedepth: The maximum number of nodes to search (default: 30, 0 = infinite)
 * Mintargetdist: Minimum distance to the target before path returns, could be used to get
 * near a target, but not right to it - for an AI mob with a gun, for example.
 * Minnodedist: Minimum number of nodes to return in the path, could be used to give a path a minimum
 * length to avoid portals or something i guess?? Not that they're counted right now but w/e.
 */

// Modified to provide ID argument - supplied to 'adjacent' proc, defaults to null
// Used for checking if route exists through a door which can be opened

// Also added 'exclude' turf to avoid travelling over; defaults to null

/datum/graph_astar_node
	var/datum/position
	var/datum/graph_astar_node/previous_node

	var/best_estimated_cost
	var/estimated_cost
	var/known_cost
	var/cost
	var/nodes_traversed

/datum/graph_astar_node/New(_position, _previous_node, _known_cost, _cost, _nodes_traversed)
	position = _position
	previous_node = _previous_node

	known_cost = _known_cost
	cost = _cost
	estimated_cost = cost + known_cost

	best_estimated_cost = estimated_cost
	nodes_traversed = _nodes_traversed

/proc/cmp_graph_astar_node(datum/graph_astar_node/a, datum/graph_astar_node/b)
	return a.estimated_cost - b.estimated_cost

/proc/graph_astar(start, end, adjacent, dist, max_nodes, max_node_depth = 30, min_target_dist = 0, min_node_dist, id, datum/exclude)
	var/datum/priority_queue/open = new /datum/priority_queue(/proc/cmp_graph_astar_node)
	var/list/closed = list()
	var/list/path
	var/list/path_node_by_position = list()
	start = get_turf(start)
	if(!start)
		return 0

	open.enqueue(new /datum/graph_astar_node(start, null, 0, call(start, dist)(end), 0))

	while(!open.is_empty() && !path)
		var/datum/graph_astar_node/current = open.dequeue()
		closed.Add(current.position)

		if(current.position == end || call(current.position, dist)(end) <= min_target_dist)
			path = new /list(current.nodes_traversed + 1)
			path[path.len] = current.position
			var/index = path.len - 1

			while(current.previous_node)
				current = current.previous_node
				path[index--] = current.position
			break

		if(min_node_dist && max_node_depth)
			if(call(current.position, min_node_dist)(end) + current.nodes_traversed >= max_node_depth)
				continue

		if(max_node_depth)
			if(current.nodes_traversed >= max_node_depth)
				continue

		for(var/datum/datum in call(current.position, adjacent)(id))
			if(datum == exclude)
				continue

			var/best_estimated_cost = current.estimated_cost + call(current.position, dist)(datum)

			//handle removal of sub-par positions
			if(datum in path_node_by_position)
				var/datum/graph_astar_node/target = path_node_by_position[datum]
				if(target.best_estimated_cost)
					if(best_estimated_cost + call(datum, dist)(end) < target.best_estimated_cost)
						open.remove_item(target)
					else
						continue

			var/datum/graph_astar_node/next_node = new (datum, current, best_estimated_cost, call(datum, dist)(end), current.nodes_traversed + 1)
			path_node_by_position[datum] = next_node
			open.enqueue(next_node)

			if(max_nodes && length(open.queue) > max_nodes)
				open.remove(length(open.queue))

	return path

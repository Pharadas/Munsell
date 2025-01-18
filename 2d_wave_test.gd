extends Node2D

var rng = RandomNumberGenerator.new()

var u = []
var u_prev = []
var r = []

var num_spaces: Vector2i = Vector2i(200, 200)
var viewport_size: Vector2i
var size_space: Vector2i

func zero_matrix(nX, nY):
	var matrix = []
	for x in range(nX):
		matrix.append([])
		for y in range(nY):
			matrix[x].append(0)
	return matrix

func multiply(a, b):
	var matrix = zero_matrix(a.size(), b[0].size())
	
	for i in range(a.size()):
		for j in range(b[0].size()):
			for k in range(a[0].size()):
				matrix[i][j] = matrix[i][j] + a[i][k] * b[k][j]
	return matrix

func _draw():
	# Define Laplacian kernel
	#var laplacian_kernel = [[0.066, 0.184, 0.066], [0.184, -1.0, 0.184], [0.066, 0.184, 0.066]]
	# var laplacian_kernel = [[0.066, 0.066, 0.066], [0.066, -1.0, 0.066], [0.066, 0.066, 0.066]]
	# var laplacian = convolution2d(u, num_spaces, laplacian_kernel)

	for y in num_spaces.y:
		for x in num_spaces.x:
			draw_rect(Rect2(x * size_space.x, y * size_space.y, size_space.x, size_space.y), Color(r[y][x], -r[y][x], 0), true)

	if rng.randi_range(0, 20) == 0:
		print("doin it")
		var x = rng.randi_range(5, 195)
		var y = rng.randi_range(5, 195)

		r[y][x] = 10

		# for i in range(-2, 2):
		# 	for j in range(-2, 2):
		# 		r[y + i][x + j] = 10

	u_prev = u.duplicate()
	u = r.duplicate()

	for i in range(1, num_spaces.y - 1):
		for j in range(1, num_spaces.x - 1):
			r[i][j] = 0.25 * (u[i][j - 1] + u[i][j + 1] + u[i - 1][j] + u[i + 1][j] - (4 * u[i][j]))
			r[i][j] += 2 * (u[i][j] - u_prev[i][j])

	# var v = []

	# for y in num_spaces.y:
	# 	v.append([])
	# 	for x in num_spaces.x:
	# 		v[y].append((u[y][x] - u_prev[y][x]) * 5)

	# var r = []

	# for y in num_spaces.y:
	# 	r.append([])
	# 	for x in num_spaces.x:
	# 		r[y].append(u[y][x] + v[y][x] + laplacian[y][x])

	for i in range(1, num_spaces.y - 1):
		for j in range(1, num_spaces.x - 1):
			r[i][j] *= 0.995

	# u_prev = u.duplicate()
	# u = r.duplicate()

func zeros(x, y):
	var n = []
	for a in x:
		n.append([])
		for b in y:
			n[a].append(0)

	return n

func convolution2d(image, size, kernel):
	var c = 1
	var dt = 0.005
	var dx = 0.005
	var r = (c * dt/dx) ** 2

	var m = 3
	var n = 3
	var y = size.y
	var x = size.x
	var new_image = zeros(y, x)
	y = y - m + 1
	x = x - m + 1

	# foy x in yange(1, dimx-1):
	# 		foy y in yange(1, dimy-1):
	# 				u[0, x, y]  = alpha[x,y] * (u[1, x-1, y] + u[1, x+1, y] + u[1, x, y-1] + u[1, x, y+1] - 4*u[1, x, y])
	# 				u[0, x, y] += 2 * u[1, x, y] - u[2, x, y]

	# for i in y:
	# 	for j in x:
	# 		new_image[i][j] = image[i][j - 1] + image[i][j + 1] + image[i - 1][j] + image[i + 1][j] - 4 * image[i][j]
	# 		new_image[i][j] += 2 * image[i][j] - u[]

			# var top = [image[i - 1][j - 1], image[i - 1][j], image[i - 1][j + 1]]
			# var mid = [image[i][j - 1]		, image[i][j]		 , image[i][j + 1]]
			# var bot = [image[i + 1][j - 1], image[i + 1][j], image[i + 1][j + 1]]

			# var sub_image = [top, mid, bot]

			# var result_basis = multiply(sub_image, kernel)

			# var total_sum = (result_basis[0][0] + result_basis[0][1] + result_basis[0][2]) + (result_basis[1][0] + result_basis[1][1] + result_basis[1][2]) + (result_basis[2][0] + result_basis[2][1] + result_basis[2][2])

			# new_image[i][j] = total_sum

	return new_image

func _ready() -> void:
	scale = Vector2(1, 1)
	viewport_size = get_tree().get_root().get_viewport().get_size()
	size_space = viewport_size / num_spaces

	r = zeros(num_spaces.x, num_spaces.y)
	u = zeros(num_spaces.x, num_spaces.y)
	u_prev = zeros(num_spaces.x, num_spaces.y)

func _process(delta: float) -> void:
	queue_redraw()

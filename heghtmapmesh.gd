extends CollisionShape

export var ExportFileName: String = "res://heightmap.tres"

func _ready():
	var heightmapShape: HeightMapShape = shape
	var heights = heightmapShape.get_map_data()
	
	var index = 0
	
	var vertices: PoolVector3Array = PoolVector3Array()
	
	var uvs: PoolVector2Array = PoolVector2Array()
	
	var uvs2: PoolVector2Array = PoolVector2Array()
	
	var heightmapPoints: Array = []
	
	var vertex: Vector3
	var uv: Vector2
	var heightmapIndex = 0
	
	var arr_mesh: ArrayMesh = ArrayMesh.new()
	var arrays: Array = []
	
	var st: SurfaceTool = SurfaceTool.new()
	var meshInst = MeshInstance.new()
	
	var xDelta: float
	var zDelta: float
	var reverseTriangleDir: bool = false
	
	var depth: float
	var width: float
	var halfDepth: float
	var halfWidth: float
	
	width = heightmapShape.get_map_width()
	halfWidth = width/2
	depth = heightmapShape.get_map_depth()
	halfDepth = depth/2
	
	if width < 2 || depth < 2:
		#both dimensions must be 2 or greater for anything to be rendered
		return
	
	#Generate grid of points using heightmap dimensions and heights
	for height in heights:
		xDelta = -halfWidth + fmod(index, width)
		zDelta = -halfDepth + fmod(floor(index/width), depth)
		heightmapPoints.push_back(Vector3(xDelta, height, zDelta))
		index += 1
		
	#Generate triangle vertices and uvs
	while true:
		if !reverseTriangleDir:
			vertex = heightmapPoints[heightmapIndex] + Vector3(0.5, 0, 0.5)
			uv = Vector2((vertex.x + halfWidth), (vertex.z + halfDepth)) + Vector2(0.5, 0.5)
			vertices.push_back(vertex)
			uvs.push_back(uv)
			uvs2.push_back(uv)
			
			vertex = heightmapPoints[heightmapIndex + 1] + Vector3(0.5, 0, 0.5)
			uv = Vector2((vertex.x + halfWidth), (vertex.z + halfDepth)) + Vector2(0.5, 0.5)
			vertices.push_back(vertex)
			uvs.push_back(uv)
			uvs2.push_back(uv)
			
			vertex = heightmapPoints[heightmapIndex + width] + Vector3(0.5, 0, 0.5)
			uv = Vector2((vertex.x + halfWidth), (vertex.z + halfDepth)) + Vector2(0.5, 0.5)
			vertices.push_back(vertex)
			uvs.push_back(uv)
			uvs2.push_back(uv)

			vertex = heightmapPoints[heightmapIndex + width] + Vector3(0.5, 0, 0.5)
			uv = Vector2((vertex.x + halfWidth), (vertex.z + halfDepth)) + Vector2(0.5, 0.5)
			vertices.push_back(vertex)
			uvs.push_back(uv)
			uvs2.push_back(uv)
			
			vertex = heightmapPoints[heightmapIndex + 1] + Vector3(0.5, 0, 0.5)
			uv = Vector2((vertex.x + halfWidth), (vertex.z + halfDepth)) + Vector2(0.5, 0.5)
			vertices.push_back(vertex)
			uvs.push_back(uv)
			uvs2.push_back(uv)
			
			vertex = heightmapPoints[heightmapIndex + width + 1] + Vector3(0.5, 0, 0.5)
			uv = Vector2((vertex.x + halfWidth), (vertex.z + halfDepth)) + Vector2(0.5, 0.5)
			vertices.push_back(vertex)
			uvs.push_back(uv)
			uvs2.push_back(uv)
		else:
			#Reverse row direction for connecting heightmap edge faces
			vertex = heightmapPoints[heightmapIndex] + Vector3(0.5, 0, 0.5)
			uv = Vector2((vertex.x + halfWidth), (vertex.z + halfDepth)) + Vector2(0.5, 0.5)
			vertices.push_back(vertex)
			uvs.push_back(uv)
			uvs2.push_back(uv)
			
			vertex = heightmapPoints[heightmapIndex + width] + Vector3(0.5, 0, 0.5)
			uv = Vector2((vertex.x + halfWidth), (vertex.z + halfDepth)) + Vector2(0.5, 0.5)
			vertices.push_back(vertex)
			uvs.push_back(uv)
			uvs2.push_back(uv)
			
			vertex = heightmapPoints[heightmapIndex - 1] + Vector3(0.5, 0, 0.5)
			uv = Vector2((vertex.x + halfWidth), (vertex.z + halfDepth)) + Vector2(0.5, 0.5)
			vertices.push_back(vertex)
			uvs.push_back(uv)
			uvs2.push_back(uv)

			vertex = heightmapPoints[heightmapIndex - 1] + Vector3(0.5, 0, 0.5)
			uv = Vector2((vertex.x + halfWidth), (vertex.z + halfDepth)) + Vector2(0.5, 0.5)
			vertices.push_back(vertex)
			uvs.push_back(uv)
			uvs2.push_back(uv)
			
			vertex = heightmapPoints[heightmapIndex + width] + Vector3(0.5, 0, 0.5)
			uv = Vector2((vertex.x + halfWidth), (vertex.z + halfDepth)) + Vector2(0.5, 0.5)
			vertices.push_back(vertex)
			uvs.push_back(uv)
			uvs2.push_back(uv)
			
			vertex = heightmapPoints[heightmapIndex + width - 1] + Vector3(0.5, 0, 0.5)
			uv = Vector2((vertex.x + halfWidth), (vertex.z + halfDepth)) + Vector2(0.5, 0.5)
			vertices.push_back(vertex)
			uvs.push_back(uv)
			uvs2.push_back(uv)
				
		if !reverseTriangleDir:
			heightmapIndex += 1
		else:
			heightmapIndex -= 1
			
		if !reverseTriangleDir:
			if heightmapIndex == (width*(depth - 1) - 1):
				break;
			if !fmod(heightmapIndex + 1, width):
				reverseTriangleDir = true
				heightmapIndex += width
		else:
			if (heightmapIndex + (width - 1)) == (width*(depth - 1) - 1):
				break;
			if !fmod(heightmapIndex, width):
				reverseTriangleDir = false
				heightmapIndex += width
				
			
	#Set up Arraymesh
	arrays.resize(ArrayMesh.ARRAY_MAX)
	
	arrays[ArrayMesh.ARRAY_VERTEX] = vertices
	
	arrays[ArrayMesh.ARRAY_TEX_UV] = uvs
#
	arrays[ArrayMesh.ARRAY_TEX_UV2] = uvs2
	
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	
	#generate Arraymesh normals and tangents using Surface tool
	st.create_from(arr_mesh, 0)
	st.generate_normals()
	st.generate_tangents()
	arr_mesh = st.commit()
	
	# Create the final Mesh and add as a child of heightmap
	meshInst.mesh = arr_mesh
	add_child(meshInst)
	
	#Save generated mesh in resource file if filename is given
	if ExportFileName:
		ResourceSaver.save("%s"%ExportFileName, meshInst.mesh, ResourceSaver.FLAG_COMPRESS)



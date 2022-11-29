# GodotHeightmap2mesh
A Godot game engine tool for generating a mesh from a heightmap collisionshape node 

A script for generating a mesh from a heightmap collisionshape node.  

Script can be used for generating a mesh from a collisionshape node with shape set to heightmapshape at runtime and for creating a mesh resource file based on the heightmap.

Generated mesh supports uvs, normals, and tangents and can be textured, and use normal maps

This has been tested with Godot 3.5 only.

MIT License

Usage:

- Download the script(heightmapmesh.gd) and add to a collisionshape node with shape set to heightmapshape.
- Script has an exported field: Export file name.  Set this to the desired path and file name of the generated mesh file.
- Run the project.  The script will generate a MeshInstance node as a child of the collisionshape node. This temporary MeshInstance node is mainly for inspection of the generated mesh.
- To use the generated mesh, add a new MeshInstance node to the scene and select it.  In the Godot file system, navigate to the generated mesh file. Drag the generated mesh file onto the "Mesh" field of the new MeshInstance node.
- Script is only for creating the mesh file.  It can now be removed from the collisionshape node.


![heightmapmesh](https://user-images.githubusercontent.com/11907796/204204749-e18dddfc-ebb2-4478-ae9f-4d6c1d26525a.png)

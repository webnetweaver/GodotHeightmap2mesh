# GodotHeightmap2mesh
A Godot game engine tool for generating a mesh from a collision heightmap

A script for generating a mesh from a heightmap collision node.  

Script can be used for generating a mesh for a collision heightmap at runtime and for creating a mesh resource file based on a collision heightmap.

Generated mesh supports uvs, normals, and tangents and can be textured, and use normal maps

Usage:

- Download the script to a heightmap collision node 
- Script has an exported field: Export file name.  Set this to the desired path and file name of the generated mesh file.
- Run the project.  The script will generate a MeshInstance node as a child of the heightmap collision node. This temporary MeshInstance node is mainly for inspection of the generated mesh.
- To use the generated mesh, add a MeshInstance node to the project and select it.  In the Godot file system, navigate to the generated mesh file. Drag the generated mesh file onto the "Mesh" field of the MeshInstance node.

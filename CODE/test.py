import openseespy.opensees as ops
import meshio
import numpy as np
import pyvista as pv

# === 1. Leer archivo .msh ===
mesh = meshio.read("GMSH_FILES/geo.msh")

# === 2. Inicializar modelo 3D en OpenSees ===
ops.wipe()
ops.model("BasicBuilder", "-ndm", 3, "-ndf", 3)

# === 3. Crear nodos ===
for i, coord in enumerate(mesh.points):
    ops.node(i + 1, *coord[:3])  # X, Y, Z para modelo 3D

# === 4. Definir material 3D ===
E = 210e9       # módulo de elasticidad (Pa)
nu = 0.3        # coeficiente de Poisson
rho = 7850      # densidad del acero (kg/m³)

ops.nDMaterial("ElasticIsotropic", 1, E, nu, rho)

# === 5. Crear elementos tetraédricos ===
ele_tag = 1
for cell_block in mesh.cells:
    if cell_block.type == "tetra":
        for conn in cell_block.data:
            n1, n2, n3, n4 = map(int, conn + 1)
            ops.element("FourNodeTetrahedron", ele_tag, n1, n2, n3, n4, 1)
            ele_tag += 1

# === 6. Visualización con PyVista ===
# Filtrar celdas tetraédricas
tets = np.vstack([conn for c in mesh.cells if c.type == "tetra" for conn in c.data])
tets = tets.astype(int)

# PyVista necesita número de nodos por celda al principio
cells = np.hstack([np.full((len(tets), 1), 4), tets])
celltypes = np.full(len(tets), pv.CellType.TETRA)

grid = pv.UnstructuredGrid(cells, celltypes, mesh.points)

# Mostrar malla
plotter = pv.Plotter()
plotter.add_mesh(grid, show_edges=True, color="lightblue", opacity=0.5)
plotter.add_axes()
plotter.show_bounds(grid="front", location="outer", all_edges=True)
plotter.show(title="Malla 3D de Tetraedros - OpenSeesPy")

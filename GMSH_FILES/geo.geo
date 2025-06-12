SetFactory("OpenCASCADE");

// --------- PARÁMETROS -----------
Lx = 220;      // Largo total
Ly = 30;       // Altura de la placa central
e  = 10;       // Espesor ranura central
r  = 9;        // Radio de agujeros
dy = 11;       // Altura de los centros de agujeros (en centro ahora será 0)
dx = 20;       // Distancia a los apoyos

// --------- PUNTOS -----------
// Placa base central (de y = -11 a y = 11)
Point(1)  = {-110,     -11, 0, 1};
Point(2)  = {-110+dx,  -15, 0, 1};
Point(3)  = {-110+dx+e, -15, 0, 1};
Point(4)  = {110-dx-e, -15, 0, 1};
Point(5)  = {110-dx,   -15, 0, 1};
Point(6)  = {110,      -11, 0, 1};
Point(7)  = {110,       11, 0, 1};
Point(8)  = {-110,      11, 0, 1};

Point(9)  = {-110, -15, 0, 1};
Point(10) = {110,  -15, 0, 1};

Point(11) = {-110,  15, 0, 1};
Point(12) = {110,   15, 0, 1};
Point(13) = {-e/2,  15, 0, 1};
Point(14) = { e/2,  15, 0, 1};

// --------- LÍNEAS -----------
Line(1) = {1, 6};
Line(2) = {6, 7};
Line(3) = {7, 8};
Line(4) = {8, 1};

Line(5) = {9, 10};
Line(6) = {10, 6};
Line(7) = {6, 1};
Line(8) = {1, 9};

Line(9)  = {8, 7};
Line(10) = {7, 12};
Line(11) = {12, 11};
Line(12) = {11, 8};

// --------- AGUJEROS -----------
// Discos centrados en y = 0
Disk(100) = {-65, 0, 0, r};
Disk(101) = {-20, 0, 0, r};
Disk(102) = { 25, 0, 0, r};
Disk(103) = { 70, 0, 0, r};

// --------- SUPERFICIES PLANAS -----------
Line Loop(1000) = {1, 2, 3, 4};
Plane Surface(200) = {1000};

Line Loop(1001) = {5, 6, -7, -8};
Plane Surface(201) = {1001};

Line Loop(1002) = {-9, 10, 11, 12};
Plane Surface(202) = {1002};

// Restar agujeros en la placa central
BooleanDifference{ Surface{200}; Delete; }
                 { Surface{100, 101, 102, 103}; Delete; }

// --------- PARÁMETROS DE EXTRUSIÓN -----------
h_placa    = 3;
h_inferior = 20;
h_superior = 20;

// --------- EXTRUSIÓN Y VOLUMENES -----------
// Placa con huecos (extrusión simétrica en z)
out1[] = Extrude {0, 0,  h_placa/2} { Surface{200}; };
out2[] = Extrude {0, 0, -h_placa/2} { Surface{200}; };
Physical Volume("Vol_Plate") = {out1[1], out2[1]};

// Bloque Inferior (extrusión simétrica en z)
out3[] = Extrude {0, 0,  h_inferior/2} { Surface{201}; };
out4[] = Extrude {0, 0, -h_inferior/2} { Surface{201}; };
Physical Volume("Vol_BloqueInf") = {out3[1], out4[1]};

// Bloque Superior (extrusión simétrica en z)
out5[] = Extrude {0, 0,  h_superior/2} { Surface{202}; };
out6[] = Extrude {0, 0, -h_superior/2} { Surface{202}; };
Physical Volume("Vol_BloqueSup") = {out5[1], out6[1]};

Mesh 3;





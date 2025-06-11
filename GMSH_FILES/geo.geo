SetFactory("OpenCASCADE");

e = 10;
d = 30;

// Puntos del cuadrado
Point(1) = {0, 0, 0, 1};

Point(100) = {d,0,0,1};
Point(101) = {d+e,0,0,1};

Point(102) = {220-d-e,0,0,1};
Point(103) = {220-d,0,0,1};

Point(2) = {220, 0, 0, 1};
Point(3) = {220, 4, 0, 1};
Point(4) = {0, 4, 0, 1};
Point(5) = {0, 26, 0, 1};
Point(6) = {220, 26, 0, 1};
Point(7) = {0, 30, 0, 1};

Point(200) = {(220/2)-(e/2),30,0,1};
Point(201) = {(220/2)+(e/2),30,0,1};

Point(8) = {220, 30, 0, 1};


// Líneas
Line(1) = {1, 100};
Line(100) = {100,101};
Line(101) = {101,102};
Line(102) = {102, 103};
Line(103) = {103, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 1};

Line(5) = {4,5};
Line(6) = {5,6};
Line(7) = {6,3};

Line(8) = {5,7};

Line(200) = {7,200};
Line(201) = {200,201};

Line(9) = {201,8};
Line(10) = {8,6};

// Superficie
Line Loop(1) = {1,100,101, 102, 103, 2, 3, 4};
Line Loop(2) = {3,5,6,7};
Line Loop(3) = {6,8,200,201,9,10};


Plane Surface(1) = {1};
Plane Surface(2) = {2};
Plane Surface(3) = {3};





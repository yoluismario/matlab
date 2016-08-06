function v1= rot1g(v, alfa)
alfa=deg2rad(alfa);
CNB=[cos(alfa) sin(alfa); -sin(alfa) cos(alfa)];

v1=CNB*v;
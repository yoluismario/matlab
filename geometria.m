% b = 0.5;
% h = 1;
% nel = 10; % numero de elementos
% a = 0;
% theta = 10; %en grados
% theta = deg2rad(theta);

function geom = geometria(a,b,h,nel,theta)
dosb = 2*b; 
dosA = 2*a;
if dosA>b
	disp('2a es mayor que b')
    return
end
% el numero de nodos +1 del numero de elementos
% el numero de vortices y puntos de control es igual al numero de elementos
% los vortices al 25% y los puntos de control al 75%
nnp= nel +1;%numero de nodal points
nvp= nel; %number of vortex points
ncp= nel; %number of control points

dim = 2; % para poder cambiar los tamaños y usar un modelo 3D

% rnpB: vector de los puntos nodales en el sistema B
rnpB = zeros(dim,nnp);
rvpB = zeros(dim,nvp);
rcpB = zeros(dim,ncp);
vncpB = zeros(dim,ncp);

leB = -(1+a)*b; %borde de ataque = leading edge
teB = 2*b + leB; %borde de fuga = trailing edge

lel = dosb/nel;
% elem.coord(1) = 

for i=1:nel
    rnpB(1,1) = leB;
    rnpB(1,1+i) = rnpB(1,i)+lel;
    rvpB(1,i) = leB+lel*(i-0.75);%0.25*lel+lel*(i-1);
    rcpB(1,i) = leB+lel*(i-0.25);
    % calcular las normales
% debe tomar los puntos de cada segmento y calcular para cada uno.
    vncpB(:,i) = normal(rcpB(:,i));
%     dot(rcpB(:,i),vncpB(:,i))
end

CBN = [cos(theta) -sin(theta);sin(theta) cos(theta)];
CNB = CBN';

rnpN = CNB * rnpB;
rcpN = CNB * rcpB;
rvpN = CNB * rvpB;
vncpN = CNB * vncpB;
% dot(rcpN(:,2),vncpN(:,2))
ceroN = [0;h];

RnpN = rnpN + kron(ceroN,ones(1,size(rnpN,2)));
RcpN = rcpN + kron(ceroN,ones(1,size(rcpN,2)));
RvpN = rvpN + kron(ceroN,ones(1,size(rvpN,2)));



sistemaB.controlpoints = rcpB;
sistemaB.vortexpoints = rvpB;
sistemaB.nodalpoints = rnpB;
sistemaB.normals = vncpB;
sistemaN.controlpoints = rcpN;
sistemaN.vortexpoints = rvpN;
sistemaN.nodalpoints = rnpN;
sistemaN.normals = vncpN;
sistemaRN.controlpoints = RcpN;
sistemaRN.vortexpoints = RvpN;
sistemaRN.nodalpoints = RnpN;
sistemaRN.normals = vncpN;
% graficar(sistemaB,sistemaN,sistemaRN)

geom.sistema(1) = sistemaB;
geom.sistema(2) = sistemaN;
geom.sistema(3) = sistemaRN;

end 
load('torque.txt','isa','T')
ISA = torque(:,2);
H = [2000, 4000, 6000, 8000, 10000, 12000];
T1 = torque(:,3);
T2 = torque(:,3);
%nombrearchivo = 'torque.txt';
plot(ISA,T1,'o')
H1=polyval(ISA, T);

for i=1
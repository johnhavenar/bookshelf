alpha = 6;
M = 1.2;

figure;
WingDef = axes;
WingDef.View = [0 0];
WingDef.FontName = 'Times';

hold on

for section = [0.10, 0.20, 0.30, 0.40, 0.50, 0.60, 0.70, 0.80, 0.90, 1.00]
[x,y,z] = importDisp(alpha,M,'zDisp','le',section);
plot3(x,y,z,'r')
end

for section = [0.10, 0.20, 0.30, 0.40, 0.50, 0.60, 0.70, 0.80, 0.90, 1.00]
[x,y,z] = importDisp(alpha,M,'zDisp','te',section);
plot3(x,y,z,'b')
end

[x,y,z] = importDisp(alpha,M,'zDisp','wingtip',1.00);
plot3(x,y,z,'g')

xlabel("t (s)")
xlim([0,0.2])
ylabel("y/b")
ylim([0,1.05])
zlabel("\delta_z (m)")

hold off
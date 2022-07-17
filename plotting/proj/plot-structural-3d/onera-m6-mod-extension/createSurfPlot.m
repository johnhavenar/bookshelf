function [WingSurfAxes] = createSurfPlot(alpha,M,dataset,location)

figure;
WingSurfAxes = axes;
WingSurfAxes.View = [30 20];
WingSurfAxes.FontName = 'Times';
WingSurfAxes.Color = '#e8e8e8';
WingSurfAxes.GridColor = 'k';
WingSurfAxes.GridAlpha = 0.6;
WingSurfAxes.GridLineStyle = '-';
WingSurfAxes.LineWidth = 0.4;

hold on

sectionList = [0.10, 0.20, 0.30, 0.40, 0.50, 0.60, 0.70, 0.80, 0.90, 1.00];


% For initializing variables only.
[x,~,~] = importDisp(alpha,M,dataset,location,sectionList(1));



[X,Y] = meshgrid(x,sectionList);
Z = zeros(length(sectionList),length(x));

% Build displacement matrix.
for iter = 1:length(sectionList)
[~,~,z] = importDisp(alpha,M,dataset,location,sectionList(iter));
Z(iter,:) = z;
end

% Create surface plot.
s = surf(X,Y,Z,'FaceAlpha','1.0','MeshStyle','both',LineWidth=0.2);
pbaspect([3,2,2])
colormap turbo
shading faceted
lighting gouraud
colorbar
grid


% Format axes.
xlabel("t (s)")
xlim([0,0.2])
ylabel("y/b")
ylim([0.1,1.0])
zlabel("\delta_z (m)")
zlim([0,0.08])

fontsize(WingSurfAxes,12,'points')

hold off

end
function [ax] = graph_cp(section)

ax = axes;

[x,cp] = import_cp(section);
[x_exp,cp_exp] = import_cp_exp(section);

hold on
plot(x,cp,'.b',MarkerSize=8);
plot(x_exp,cp_exp,'sk',MarkerFaceColor='white',MarkerSize=6,LineWidth=1);
hold off

set(ax,'FontSize',13)
ax.YDir = 'reverse';
ax.FontName = 'Times';
ax.XLim = [-0.05,1.05];
ax.YLim = [-1.4,1];

ax.XTick = 0:0.2:1;
ax.YTick = -4:0.4:4;

xtickformat(ax,'%.1f');
ytickformat(ax,'%.1f');

xlabel('Distance along chord, $ x/c $',Interpreter="latex",FontSize=12)
ylabel('Pressure coefficient, $ C_{p} $',Interpreter="latex",FontSize=12)

txt = text(ax,0.8,0.85,["Section "+upper(section); "$ M_{\infty}=0.8 $"; "$ \alpha=2^{\circ} $"], Units='normalized',BackgroundColor='w', Interpreter='latex' ,EdgeColor='k');

box on
grid on

%title_text = ['$ \textrm{Pressure Coefficient at ', upper(section), '},\ M_{\infty}=0.8,\ \alpha=2^{\circ} $'];
%title(title_text,FontSize=14,Interpreter="latex")

legend_text_1 = '$ \textrm{SST k--$\omega$} $';
legend_text_2 = '$ \textrm{Exp. (Br{\"u}derlin, 2016)} $';
legend({legend_text_1,legend_text_2}, Interpreter="latex",Location="southeast")


end
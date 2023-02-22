%%
% Transportation, Routing and Scheduling Assignment
% Prepared by Ivaylo Ganchev and George Tzanetos
%%
clc 
clear all
close all
%%
t1 = readtable('tsp_50_0.csv');
T1 = table2array(t1);
t2 = readtable('tsp_50_1.csv');
T2 = table2array(t2);
t3 = readtable('tsp_50_2.csv');
T3 = table2array(t3);
t4 = readtable('tsp_50_3.csv');
T4 = table2array(t4);
t5 = readtable('tsp_50_4.csv');
T5 = table2array(t5);
t6 = readtable('tsp_75_0.csv');
T6 = table2array(t6);
t7 = readtable('tsp_75_1.csv');
T7 = table2array(t7);
t8 = readtable('tsp_75_2.csv');
T8 = table2array(t8);
t9 = readtable('tsp_75_3.csv');
T9 = table2array(t9);
t10 = readtable('tsp_75_4.csv');
T10 = table2array(t10);

%% Nearest Insertion Code
tic

Nodes = T1; %Cities with distances 
N_nodes = size(Nodes,1);

d = pdist(Nodes); 
d = squareform(d);%Creating square matrix with distances
d(d==0) = realmax;

shortLength = realmax;

for i = 1:N_nodes
    
    stCity = i; %Initialization

    p = stCity; %Path
    
    pTr = 0;
    NewDist = d;
    
    curCity = stCity; % City in the current moment
    
    for j = 1:N_nodes-1
        
        [minDist,nextCity] = min(NewDist(:,curCity));
        if (length(nextCity) > 1)
            nextCity = nextCity(1);
        end
        
        p(end+1,1) = nextCity;
        pTr = pTr +...
                    d(curCity,nextCity);
        
        NewDist(curCity,:) = realmax;
        
        curCity = nextCity;
        
    end
    
    p(end+1,1) = stCity;
    pTr = pTr +...
        d(curCity,stCity);
    
    if (pTr < shortLength)
        shortLength = pTr;
        shortPath = p; 
    end 
    
end

toc

figure
x_min = 0;
x_max = 1;
y_min = 0;
y_max = 1;
plot(Nodes(:,1),Nodes(:,2),'bo');
axis([x_min x_max y_min y_max]);
axis equal;
grid on;
hold on;

% plot the shortest path
xd=[];yd=[];
for i = 1:(N_nodes+1)
    xd(i)=Nodes(shortPath(i),1);
    yd(i)=Nodes(shortPath(i),2);
end
line(xd,yd,'color','b','LineWidth',2);
title(['Path length = ',num2str(shortLength)]);
hold off;

%%
% Length Comparison
figure
filenum = 1:10;
obj1 = [9.2705, 8.7469, 8.1090, 7.6924, 9.9183, ...
        13.4083, 10.8061, 12.7600, 10.5202, 11.2374];
obj2 = [6.3738, 6.4584, 6.8916, 5.8805, 6.1336, ...
        7.5897, 7.8169, 7.9136, 7.3443, 8.0144];
    
plot(filenum,obj1,'b',filenum,obj2,'r')
hold on
scatter(filenum,obj1,'b','filled')
hold on 
scatter(filenum,obj2,'r','filled')
hold on
xline(5.5,'--');
ylabel('Objective/Length','FontSize',15);
xticklabels({'tsp\_50\_0.csv','tsp\_50\_1.csv','tsp\_50\_2.csv', ...
             'tsp\_50\_3.csv','tsp\_50\_4.csv','tsp\_75\_0.csv', ...
             'tsp\_75\_1.csv','tsp\_75\_2.csv','tsp\_75\_3.csv', ...
             'tsp\_75\_4.csv'});
xtickangle(45);
legend({'Local Search','Nearest Neighbor'},'Location','northwest','FontSize',15);
title('Length Comparison','FontSize',15);
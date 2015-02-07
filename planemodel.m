clear all;

gridWidth = 10;
gridHeight = 10;
numberSearchPlanes = 5;
numberSteps = 100;

planeX = zeros(numberSteps);
planeY = zeros(numberSteps);
planeX(1) = gridWidth / 2; % plane start x
planeY(1) = gridHeight / 2; % plane start y

searchPlaneX = zeros(numberSearchPlanes, numberSteps); % i, t
searchPlaneY = zeros(numberSearchPlanes, numberSteps); % i, t
for i=1:numberSearchPlanes
    searchPlaneX(i,1) = 1;
    searchPlaneY(i,1) = i*2 - 1;
end

oceanFlowX = zeros(gridWidth, gridHeight);
oceanFlowY = zeros(gridWidth, gridHeight);
for i=1:10
    for j=1:10
        oceanFlowX(i,j) = 0;
        oceanFlowY(i,j) = 0;
    end
end

searchFlowX = zeros(gridWidth, gridHeight);
searchFlowY = zeros(gridWidth, gridHeight);
for i=1:10
    for j=1:10
        searchFlowX(i,j) = 1;
        searchFlowY(i,j) = 0;
    end
end

for n=1:numberSteps
    clf
    axis([1,gridWidth,1,gridHeight])
    hold on
    axis manual
    
    planeX(n+1) = planeX(n) + oceanFlowX(planeX(n), planeY(n));
    planeY(n+1) = planeY(n) + oceanFlowY(planeX(n), planeY(n));
    
    for i=1:numberSearchPlanes
        searchPlaneX(i,n+1) = searchPlaneX(i,n) + searchFlowX(searchPlaneX(i,n), searchPlaneY(i,n));
        searchPlaneY(i,n+1) = searchPlaneY(i,n) + searchFlowY(searchPlaneX(i,n), searchPlaneY(i,n));
    end
    
    scatter(planeX(n),planeY(n))
    scatter(searchPlaneX(:,n),searchPlaneY(:,n))
    
    pause;
end

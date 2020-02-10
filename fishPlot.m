wildType1 = readtable('WT_1.A.csv');
mutantType1 = readtable('Duchenne_1.A.csv');

frames = 300;

for i = 1 : frames
    
    % unmaintainable, needs to be a dynamic array of arrays for all datasets
    
    % WT = wild type
    % MT = mutant type
    
    %reading values of the 7 xy co-ordinates on the zebrafish spine
    xWT1 = wildType1{i, [8 10 12 14 16 18 20]};
    yWT1 = wildType1{i, [9 11 13 15 17 19 21]};
    
    
    xMT1 = mutantType1{i, [8 10 12 14 16 18 20]};
    yMT1 = mutantType1{i, [9 11 13 15 17 19 21]};
    
    angles = 7;
    
    %below used to calculate angles between spine points
    
    %allocating empty array for the magnitude values
    magnitudes = zeros(1, 7);
    angle = zeros(1,6);
    products = zeros(1,7);
    
    %calculating angle between two co-ordinates
    for j = 1 : angles
        fprintf('wot');
        magnitudes(1,j) = sqrt(xMT1(1,j).^2 + yMT1(1,j).^2);
        products(1,j) = xMT1(1,j) * yMT1(1,j);
    end
    
    % inverse cosine of uv/|u||v| == angle between two co-ordinates
    for j = 1: angles-1
        angle(1,j) = acos((products(1,j) + products(1,j+1))/(magnitudes(1,j)*magnitudes(1,j+1)));
        
        %if difference is more than 45 degrees between a frame, mark on the
        %plot
        if 10 < angle(1,j)
            plot(yMT1(1, 2*angle + 6), xMT1(1, 2*angle + 6));
            disp('abnormal movement');
        end
    end
    
    %first plots yWT against xWT, then yMT against xMT
    plot(yWT1,xWT1, yMT1, xMT1, 'LineWidth', 2.0);
    
    
    xlabel('x co-ordinates');
    ylabel('y co-ordinates');  
    title('x against y co-ordinates of the fish per frame');
    
    %defines the figure window size, in pixels
    set(gcf, 'Position',  [25, 25, 1200, 1900]);
    
    % sets the scale for the figure axes
    xlim([0,800]);
    ylim([0,700]);
    
    pause(.05);
    
end


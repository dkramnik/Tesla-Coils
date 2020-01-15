%% Clean up
clc
close all
clear

delete( instrfind )

%% Open serial link
MDX = MDX_open_serial( [] );

% Query the run time counter

fprintf( MDX, 'J' );
pause( 0.1 );   % Wait to allow time for response

disp( [ 'Received ' num2str( MDX.BytesAvailable ) ' J bytes from MDX.' ] );

message = [];
while MDX.BytesAvailable > 0
    message = [ message fgets( MDX ) ];
end

disp( message )

% Set the run time counter to maximum

fprintf( MDX, 'J0000' );

% Query the maximum level possible

%% Get the out-of-setpoint limit

fprintf( MDX, 'Q' );
pause( 0.1 );   % Wait to allow time for response

disp( [ 'Received ' num2str( MDX.BytesAvailable ) ' Q bytes from MDX.' ] );

message = [];
while MDX.BytesAvailable > 0
    message = [ message fgets( MDX ) ];
end

disp( message )

return

%% Get the setpoint and current level

% Transfer setpoint control from host to user port
fprintf( MDX, 'SA' );   % SB for the other way around

% Query the setpoint
fprintf( MDX, 'L' );
pause( 0.1 );   % Wait to allow time for response

disp( [ 'Received ' num2str( MDX.BytesAvailable ) ' L bytes from MDX.' ] );

message = [];
while MDX.BytesAvailable > 0
    message = [ message fgets( MDX ) ];
end

disp( message )

% Query the maximum level possible
fprintf( MDX, 'Z' );
pause( 0.1 );   % Wait to allow time for response

disp( [ 'Received ' num2str( MDX.BytesAvailable ) ' Z bytes from MDX.' ] );

message = [];
while MDX.BytesAvailable > 0
    message = [ message fgets( MDX ) ];
end

disp( message )

% Get current value over and over again
while( true )
    fprintf( MDX, 'I' );
    pause( 1.0 );   % Wait to allow time for response

    disp( [ 'Received ' num2str( MDX.BytesAvailable ) ' V bytes from MDX.' ] );

    message = [];
    while MDX.BytesAvailable > 0
        message = [ message fgets( MDX ) ];
    end

    disp( message )
end
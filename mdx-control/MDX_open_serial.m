function [ MDX ] = MDX_open_serial( port_name )
% Opens a USB COM port to talk to the MDX
% 'port_name' specifies the serial port to use, if specifically known

% RS-232 ASCII Format
% 1200 baud
% even parity
% 1 start bit, 7 data bits, 2 stop bits
    
    serial_list = seriallist;

    if( isempty( port_name ) )  % port name is not known
        serial_inds = strfind( serial_list, '/dev/cu.usbserial' ); % OSX systems
    else
        serial_inds = strfind( serial_list, port_name );
    end
        
    port_inds = find( not( cellfun( 'isempty', serial_inds ) ) );

    if length( port_inds ) > 1
        port_inds = port_inds( 1 ); % If more than one, pick first and print warning
        disp( 'Warning: multiple USB serial ports detected, picking first one.' );
    end
    
    MDX = serial( serial_list( port_inds ) );
    set( MDX, 'BaudRate', 1200 );
    set( MDX, 'Terminator', 'CR' ); % CR = char #13
    
    MDX.Parity = 'even';
    %MDX.StartBits = 1;
    MDX.DataBits = 7;
    MDX.StopBits = 2;
    
    fopen( MDX );
    
    disp( ['Connected to ' serial_list( port_inds ) ] );
    
end


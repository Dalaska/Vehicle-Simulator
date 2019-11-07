function [ trip_state,DB_start_pos,DB_stop_pos,write_signal,DB_mt_entry ] = Find_MicroTrips_OL( trip_state,p_attr,time,DB_start_pos,DB_stop_pos )
%==========================================================================
%                        Find MicroTrips OnLine
% find the starts and stops of microtrips
%--------------------------------------------------------------------------
% inputs:
% trip_state: state of wether in a microtrip (0/1)
% p_attr: event attribute
% time: current time
% DB_start_pos: start postion of a microtrip
% DB_stop_pos: end positio of a micortrip
%--------------------------------------------------------------------------
% outputs:
% trip_state: state of wether in a microtrip (0/1)
% DB_start_pos: start postion of a microtrip
% DB_stop_pos: end positio of a micortrip
% write_signal: signal end of a microtrip
% DB_mt_entry: entry of a microtrip
%--------------------------------------------------------------------------
%                           Tuning Parameters
T_min_v = 10; % speed lower bound
%==========================================================================
% inicialize
write_signal = 0; %
DB_mt_entry = 0; % entry of a microtrip

% finite state machine
switch trip_state
    case 0 % microtrip not started
        if p_attr(1)==1
            % if encout an accelerating event, start
            trip_state = 1;
            
            % for debugging:
            DB_start_pos = time - p_attr(2); % start time of a microtrip
        end
    case 1 %  microtrip started
        if (p_attr(1)==5)
            % stop when idle
            trip_state = 0;
            % end of a microtrip
            write_signal = 1;
            
            % for debugging:
            DB_stop_pos = time; % end time of a microtrip
            DB_mt_entry = [DB_start_pos,DB_stop_pos];
            
        else if ((p_attr(1)==1)&&(p_attr(3)<T_min_v))
                % stop when acceleration start beflow 10 and start again
                trip_state = 0;
                % end of a microtrip
                write_signal = 1;
                
                % for debugging:
                DB_stop_pos = time -  p_attr(2); % end time of a microtrip
                DB_mt_entry = [DB_start_pos,DB_stop_pos];
                
                % start again
                trip_state = 1;
                DB_start_pos = time - p_attr(2);
            end
        end
        
end
end


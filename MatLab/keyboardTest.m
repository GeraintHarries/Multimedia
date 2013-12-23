% create figure with uicontrol edit box with a key press function callback
h1 = figure;
h2 = uicontrol(h1,'Style','Edit','KeyPressFcn',@my_keypressfcn);

% key press function callback
function my_keypressfcn(~,~)
    character = get(h1,'CurrentKey');
    % if the 'return' key is pressed, run the start_computation function
    if strcmp(character,'return')
        start_computation
    end
end

% start computation function
function start_computation(~,~)
    % get string from edit box and convert it to a double
    value = str2double(get(h2,'String'));
    % do other stuff
end
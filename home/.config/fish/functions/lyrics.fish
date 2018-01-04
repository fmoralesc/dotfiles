# Defined in - @ line 0
function lyrics --description 'alias lyrics=clyrics (playerctl metadata title)'
	clyrics (playerctl metadata title) $argv;
end
